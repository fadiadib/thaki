import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkPurchaserError { load, purchase, loadBalance }

class TkPurchaser extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkPackage> _packages = [];
  List<TkPackage> get packages => _packages;
  TkPackage _selectedPackage;
  TkPackage get selectedPackage => _selectedPackage;
  set selectedPackage(TkPackage package) {
    _selectedPackage = package;
    notifyListeners();
  }

  TkCredit _selectedCard;
  TkCredit get selectedCard => _selectedCard;
  set selectedCard(TkCredit card) {
    _selectedCard = card;
    _validationPaymentError = null;
    notifyListeners();
  }

  String _cvv;
  String get cvv => _cvv;
  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  TkBalance _balance;
  TkBalance get balance => _balance;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  Map<TkPurchaserError, String> _error = Map();
  Map<TkPurchaserError, String> get error => _error;
  void clearErrors() => _error.clear();

  // Validation
  String _validationPaymentError;
  String get validationPaymentError => _validationPaymentError;
  bool validatePayment(BuildContext context) {
    if (_selectedCard == null) {
      _validationPaymentError = S.of(context).kSelectPaymentToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  /// Load user balance method
  Future<bool> loadBalance(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkPurchaserError.loadBalance] = null;
    Map result = await _apis.loadUserPackages(user: user);

    _balance = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      _balance = TkBalance.fromJson(result[kDataTag]);
    } else {
      // an error happened
      _error[TkPurchaserError.loadBalance] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkPurchaserError.loadBalance] == null);
  }

  /// Load available packages to purchase
  Future<bool> loadPackages(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkPurchaserError.load] = null;
    Map result = await _apis.loadPackages(user: user);

    // Clear model
    _packages.clear();
    selectedPackage = null;

    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kPackagesTag])
        _packages.add(TkPackage.fromJson(data));
      if (_packages.isNotEmpty) selectedPackage = _packages.first;
    } else {
      // an error happened
      _error[TkPurchaserError.load] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkPurchaserError.load] == null);
  }

  /// Purchase package method
  Future<bool> purchaseSelectedPackage(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkPurchaserError.purchase] = null;
    Map result = await _apis.purchasePackage(
        user: user, package: selectedPackage, card: selectedCard, cvv: _cvv);

    if (result[kStatusTag] == kSuccessCreationCode) {
      _balance.updateFromJson(result[kDataTag]);
    } else {
      _error[TkPurchaserError.purchase] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkPurchaserError.purchase] == null);
  }
}
