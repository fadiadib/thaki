import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

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
    notifyListeners();
  }

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String _loadError;
  String get loadError => _loadError;
  String _purchaseError;
  String get purchaseError => _purchaseError;

  /// Load available packages to purchase
  Future<bool> loadPackages() async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.loadPackages();

    // Clear model
    _loadError = null;
    _packages.clear();
    selectedPackage = null;

    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag])
        _packages.add(TkPackage.fromJson(data));
      if (_packages.length > 0) selectedPackage = _packages.first;
    } else {
      // an error happened
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }

  /// Purchase package method
  Future<bool> purchaseSelectedPackage() async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.purchasePackage(
        package: selectedPackage, card: selectedCard);

    // Clear model
    _purchaseError = null;

    if (result[kStatusTag] != kSuccessCode) {
      // an _purchaseError happened
      _purchaseError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_purchaseError == null);
  }
}
