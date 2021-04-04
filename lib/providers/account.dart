import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkAccount extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();
  static TkSharedPrefHelper _prefs = new TkSharedPrefHelper();

  // Model variables
  TkUser user;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Error variables
  String _registerError;
  String get registerError => _registerError;
  String _loginError;
  String get loginError => _loginError;
  String _loadError;
  String get loadError => _loadError;

  /// Checks for an active login session using user_token
  Future<bool> isLoggedIn() async {
    // Check if user token is stored
    String token = await _prefs.get(tag: kUserTokenTag);
    if (token != null) user = TkUser.fromJson({kUserTokenTag: token});

    // No user object initialized
    if (user == null) return false;

    // If the token is already loaded, return true
    if (user.token != null) return true;

    if (token != null) {
      // User token is stored on disk, load it and return true
      user = TkUser.fromJson({kUserTokenTag: token});
      return true;
    }

    // No login was called and no token in shared preference
    return false;
  }

  /// User register, calls API and loads user model
  Future<bool> register({bool store = false}) async {
    // Start any loading indicators
    _isLoading = true;
    notifyListeners();

    Map result = await _apis.register(user: user, fbToken: '');
    // fbToken: await FirebaseMessaging().getToken()

    _registerError = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);

      // Save token
      if (store) _prefs.store(tag: kUserTokenTag, data: user.token);
    } else {
      // an error happened
      _registerError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_registerError == null);
  }

  /// User login, calls API and loads user model
  Future<bool> login({bool store = false}) async {
    // Start any loading indicators
    _isLoading = true;
    notifyListeners();

    Map result = await _apis.login(user: user, fbToken: '');
    // fbToken: await FirebaseMessaging().getToken()

    _loginError = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);

      // Save token
      if (store) _prefs.store(tag: kUserTokenTag, data: user.token);
    } else {
      // an error happened
      _loginError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loginError == null);
  }

  /// Load user profile, calls API and loads user model
  Future<bool> load() async {
    // Start any loading indicators
    _isLoading = true;
    notifyListeners();

    Map result = await _apis.load(user: user, fbToken: '');
    // fbToken: await FirebaseMessaging().getToken()

    _loadError = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);
    } else {
      // an error happened
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }
}
