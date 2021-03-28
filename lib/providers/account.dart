import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkLoginMode { login, register }

class TkAccount extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();
  // static TkCryptoHelper _crypto = new TkCryptoHelper();
  static TkSharedPrefHelper _prefs = new TkSharedPrefHelper();

  // Model variables
  TkUser _user;
  TkUser get user => _user;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error variables
  String _loginError;
  String get loginError => _loginError;

  /// Checks for an active login session using user_token
  Future<bool> isLoggedIn() async {
    // No user object initialized
    if (_user == null) return false;

    // If the token is already loaded, return true
    if (_user.token != null) return true;

    // Check if user token is stored
    String token = await _prefs.get(tag: kUserTokenTag);
    if (token != null) {
      // User token is stored on disk, load it and return true
      _user = TkUser.fromJson({kUserTokenTag: token});
      return true;
    }

    // No login was called and no token in shared preference
    return false;
  }

  /// User login, calls API and loads user token
  Future<bool> login(TkInfoFieldsList fields) async {
    // Start any loading indicators
    _isLoading = true;
    notifyListeners();

    Map result = await _apis.login(fields: fields.toJson(), fbToken: '');
    // fbToken: await FirebaseMessaging().getToken()

    print(result);
    _loginError = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      _user = TkUser.fromJson(result[kDataTag]);

      // Save token
      _prefs.store(tag: kUserTokenTag, data: _user.token);
    } else {
      // an error happened
      _loginError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loginError == null);
  }
}
