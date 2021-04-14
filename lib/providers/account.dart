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
  void clearErrors() {
    registerError = loginError = logoutError = loadError = editError =
        loadCarsError = addCarError = updateCarError = deleteCarError =
            addCardError =
                loadCardsError = updateCardError = deleteCardError = null;
  }

  String registerError;
  String loginError;
  String logoutError;
  String loadError;
  String editError;
  String loadCarsError;
  String addCarError;
  String updateCarError;
  String deleteCarError;
  String addCardError;
  String loadCardsError;
  String updateCardError;
  String deleteCardError;

  /// Checks for an active login session using user_token
  Future<bool> isLoggedIn() async {
    // Check if user token is stored
    String token = await _prefs.get(tag: kUserTokenTag);
    String tokenType = await _prefs.get(tag: kUserTokenTypeTag);
    String lang = await _prefs.get(tag: kLangTag);

    if (token != null && tokenType != null)
      user = TkUser.fromJson({
        kUserTokenTag: token,
        kUserTokenTypeTag: tokenType,
        kUserLangTag: lang
      });

    // No user object initialized
    if (user == null) return false;

    // If the token is already loaded, return true
    if (user.token != null) return true;

    // No login was called and no token in shared preference
    return false;
  }

  /// User register, calls API and loads user model
  Future<bool> register({bool store = false}) async {
    // Start any loading indicators
    _isLoading = true;
    registerError = null;

    notifyListeners();

    // Update user language
    String lang = await _prefs.get(tag: kLangTag);
    user.updateModelFromJson({kUserLangTag: lang});

    Map result = await _apis.register(user: user);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);
      user.updateModelFromJson({kUserLangTag: lang});

      // Save token
      if (store) {
        _prefs.store(tag: kUserTokenTag, data: user.token);
        _prefs.store(tag: kUserTokenTypeTag, data: user.tokenType);
      }
    } else {
      // an error happened
      registerError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (registerError == null);
  }

  /// User login, calls API and loads user model
  Future<bool> login({bool store = false}) async {
    // Start any loading indicators
    _isLoading = true;
    loginError = null;

    notifyListeners();

    // Update user language
    String lang = await _prefs.get(tag: kLangTag);
    user.updateModelFromJson({kUserLangTag: lang});

    Map result = await _apis.login(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);
      user.updateModelFromJson({kUserLangTag: lang});

      // Save token
      if (store) {
        _prefs.store(tag: kUserTokenTag, data: user.token);
        _prefs.store(tag: kUserTokenTypeTag, data: user.tokenType);
      }
    } else {
      // an error happened
      loginError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loginError == null);
  }

  /// User logout, calls API and loads user model
  Future<bool> logout() async {
    // Start any loading indicators
    _isLoading = true;
    logoutError = null;
    notifyListeners();

    Map result = await _apis.logout(user: user);
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an error happened
      logoutError = _apis.normalizeError(result);
    } else {
      _prefs.delete(tag: kUserTokenTag);
      _prefs.delete(tag: kUserTokenTypeTag);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (logoutError == null);
  }

  /// Load user profile, calls API and loads user model
  Future<bool> load() async {
    // Start any loading indicators
    _isLoading = true;
    loadError = null;

    notifyListeners();

    Map result = await _apis.load(user: user);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      loadError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadError == null);
  }

  /// User register, calls API and loads user model
  Future<bool> edit() async {
    // Start any loading indicators
    _isLoading = true;
    editError = null;

    notifyListeners();

    Map result = await _apis.edit(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      editError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (editError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> loadCars() async {
    // Start any loading indicators
    _isLoading = true;
    loadCarsError = null;

    Map result = await _apis.loadCars(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      loadCarsError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadCarsError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> addCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    addCarError = null;
    notifyListeners();

    Map result = await _apis.addCar(user: user, car: car);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user.cars.add(TkCar.fromJson(result[kDataTag][kCarTag]));
    } else {
      // an error happened
      addCarError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (addCarError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> deleteCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    deleteCarError = null;
    notifyListeners();

    Map result = await _apis.deleteCar(user: user, car: car);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.cars.removeWhere((element) => element.id == car.id);
    } else {
      // an error happened
      deleteCarError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (deleteCarError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> updateCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    updateCarError = null;
    notifyListeners();

    Map result = await _apis.updateCar(user: user, car: car);
    if (result[kStatusTag] != kSuccessCode) {
      // an error happened
      updateCarError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (updateCarError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> loadCards() async {
    // Start any loading indicators
    _isLoading = true;
    loadCardsError = null;

    Map result = await _apis.loadCards(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      loadCardsError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadCardsError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> addCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    addCardError = null;
    notifyListeners();

    Map result = await _apis.addCard(user: user, card: card);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      TkCredit card = TkCredit.fromJson(result[kDataTag][kCardTag]);
      if (card.preferred)
        user.cards.insert(0, card);
      else
        user.cards.add(card);
    } else {
      // an error happened
      addCardError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (addCardError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> deleteCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    deleteCardError = null;
    notifyListeners();

    Map result = await _apis.deleteCard(user: user, card: card);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.cards.removeWhere((element) => element.id == card.id);
    } else {
      // an error happened
      deleteCardError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (deleteCardError == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> updateCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    updateCardError = null;
    notifyListeners();

    Map result = await _apis.updateCard(user: user, card: card);
    if (result[kStatusTag] != kSuccessCode) {
      // an error happened
      updateCardError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (updateCardError == null);
  }
}
