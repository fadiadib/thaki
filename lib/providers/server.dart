import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/utilities/index.dart';

class TkServer extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model variables
  bool _needUpgrade = false;
  bool get needUpgrade => _needUpgrade;

  // Loading variable
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error variables
  String _error;
  String get error => _error;

  /// Checks that the server is alive
  Future<bool> check(String version, String platform) async {
    // Start any loading indicators
    _isLoading = true;

    // Call API to check  if the server is alive
    Map result = await _apis.checkServer(version: version, platform: platform);

    if (result[kStatusTag] == kSuccessCode) {
      // Server alive, check if upgrade is needed
      _needUpgrade = result[kDataTag][kUpgradeTag] == true;

      _error = null;
    } else {
      // an error happened
      _error = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;

    // Notify listeners (Provider pattern)
    notifyListeners();

    return (_error == null);
  }
}
