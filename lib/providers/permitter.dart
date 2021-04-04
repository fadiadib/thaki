import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkPermitter extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  String _disclaimer;
  String get disclaimer => _disclaimer;
  TkPermit _permit;
  TkPermit get permit => _permit;
  set permit(TkPermit p) {
    _permit = p;
    notifyListeners();
  }

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String _loadError;
  String get loadError => _loadError;
  String _applyError;
  String get applyError => _applyError;

  /// Load disclaimer
  Future<bool> loadDisclaimer() async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.loadPermitDisclaimer();

    // Clear model
    _loadError = null;
    _disclaimer = null;

    if (result[kStatusTag] == kSuccessCode) {
      _disclaimer = result[kDataTag][kPermitDisclaimerTag];
    } else {
      // an error happened
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }

  /// Apply for resident permit method
  Future<bool> applyResidentPermit(TkPermit permit) async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.applyResidentPermit(permit);

    // Clear model
    _applyError = null;

    if (result[kStatusTag] == kSuccessCode) {
    } else {
      // an error happened
      _applyError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_applyError == null);
  }
}
