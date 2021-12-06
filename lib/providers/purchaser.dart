import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkPurchaser extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkPackage> _packages = [];
  List<TkPackage> get packages => _packages;
  TkPackage? _selectedPackage;
  TkPackage? get selectedPackage => _selectedPackage;
  set selectedPackage(TkPackage? package) {
    _selectedPackage = package;
    notifyListeners();
  }

  TkCredit? _selectedCard;
  TkCredit? get selectedCard => _selectedCard;
  set selectedCard(TkCredit? card) {
    _selectedCard = card;
    _validationPaymentError = null;
    notifyListeners();
  }

  String? _cvv;
  String? get cvv => _cvv;
  set cvv(String? value) {
    _cvv = value;
    notifyListeners();
  }

  TkBalance? _balance;
  TkBalance? get balance => _balance;
  List<TkPackage> _userPackages = [];
  List<TkPackage> get userPackages => _userPackages;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  void clearErrors() => loadError = purchaseError = loadBalanceError = null;

  String? loadError;
  String? purchaseError;
  String? loadBalanceError;

  // Validation
  String? _validationPaymentError;
  String? get validationPaymentError => _validationPaymentError;
  bool validatePayment(BuildContext context) {
    if (_selectedCard == null) {
      _validationPaymentError = S.of(context).kSelectPaymentToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  /// [loadBalance]
  /// Load user balance method
  Future<bool> loadBalance(TkUser user, {bool notify = true}) async {
    // Start any loading indicators
    _isLoading = true;

    // Clear model
    loadBalanceError = null;
    _userPackages.clear();
    _balance = null;

    // Notify listeners
    if (notify) notifyListeners();

    Map result = await _apis.loadUserPackages(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      _balance = TkBalance.fromJson(result[kDataTag]);
      for (Map data in result[kDataTag][kClientPackagesTag])
        _userPackages.add(TkPackage.fromUserPackageJson(data as Map<String, dynamic>));
    } else {
      // an error happened
      loadBalanceError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadBalanceError == null);
  }

  /// [loadPackages]
  /// Load available packages to purchase
  Future<bool> loadPackages(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;

    // Clear model
    loadError = null;
    _packages.clear();
    _selectedPackage = null;
    _cvv = null;

    Map result = await _apis.loadPackages(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kPackagesListTag])
        _packages.add(TkPackage.fromJson(data as Map<String, dynamic>));
      if (_packages.isNotEmpty) _selectedPackage = _packages.first;
    } else {
      // an error happened
      loadError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadError == null);
  }

  /// [purchaseSelectedPackage]
  /// Purchase the selected package, only used in save cards mode,
  /// transactions mode uses the TkTransactor provider
  Future<bool> purchaseSelectedPackage(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    purchaseError = null;
    _userPackages.clear();
    notifyListeners();

    Map result = await _apis.purchasePackage(
        user: user, package: selectedPackage!, card: selectedCard!, cvv: _cvv);
    if (result[kStatusTag] == kSuccessCreationCode) {
      _balance!.updateFromJson(result[kDataTag]);
      for (Map data in result[kDataTag][kClientPackagesTag])
        _userPackages.add(TkPackage.fromUserPackageJson(data as Map<String, dynamic>));
    } else {
      purchaseError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (purchaseError == null);
  }
}
