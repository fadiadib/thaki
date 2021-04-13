import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkAccountError {
  register,
  login,
  logout,
  load,
  edit,
  loadCars,
  addCar,
  updateCar,
  deleteCar,
  loadCards,
  addCard,
  updateCard,
  deleteCard
}

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
  Map<TkAccountError, String> _error = Map();
  Map<TkAccountError, String> get error => _error;
  void clearErrors() => _error.clear();

  /// Checks for an active login session using user_token
  Future<bool> isLoggedIn() async {
    // Check if user token is stored
    String token = await _prefs.get(tag: kUserTokenTag);
    String tokenType = await _prefs.get(tag: kUserTokenTypeTag);

    if (token != null && tokenType != null)
      user =
          TkUser.fromJson({kUserTokenTag: token, kUserTokenTypeTag: tokenType});

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
    _error[TkAccountError.register] = null;

    notifyListeners();

    Map result = await _apis.register(user: user);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);

      // Save token
      if (store) {
        _prefs.store(tag: kUserTokenTag, data: user.token);
        _prefs.store(tag: kUserTokenTypeTag, data: user.tokenType);
      }
    } else {
      // an error happened
      _error[TkAccountError.register] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.register] == null);
  }

  /// User login, calls API and loads user model
  Future<bool> login({bool store = false}) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.login] = null;

    notifyListeners();
    Map result = await _apis.login(user: user);

    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user = TkUser.fromJson(result[kDataTag]);

      // Save token
      if (store) {
        _prefs.store(tag: kUserTokenTag, data: user.token);
        _prefs.store(tag: kUserTokenTypeTag, data: user.tokenType);
      }
    } else {
      // an error happened
      _error[TkAccountError.login] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.login] == null);
  }

  /// User logout, calls API and loads user model
  Future<bool> logout() async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.logout] = null;
    notifyListeners();

    Map result = await _apis.logout(user: user);
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an error happened
      _error[TkAccountError.logout] = result[kErrorMessageTag] ?? kUnknownError;
    } else {
      _prefs.delete(tag: kUserTokenTag);
      _prefs.delete(tag: kUserTokenTypeTag);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.logout] == null);
  }

  /// Load user profile, calls API and loads user model
  Future<bool> load() async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.load] = null;

    notifyListeners();

    Map result = await _apis.load(user: user);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      _error[TkAccountError.load] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.load] == null);
  }

  /// User register, calls API and loads user model
  Future<bool> edit() async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.edit] = null;

    notifyListeners();

    Map result = await _apis.edit(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      _error[TkAccountError.edit] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.edit] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> loadCars() async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.loadCars] = null;

    Map result = await _apis.loadCars(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      _error[TkAccountError.loadCars] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.loadCars] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> addCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.addCar] = null;

    Map result = await _apis.addCar(user: user, car: car);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      user.cars.add(TkCar.fromJson(result[kDataTag][kCarTag]));
    } else {
      // an error happened
      _error[TkAccountError.addCar] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.addCar] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> deleteCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.deleteCar] = null;

    Map result = await _apis.deleteCar(user: user, car: car);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.cars.removeWhere((element) => element.id == car.id);
    } else {
      // an error happened
      _error[TkAccountError.deleteCar] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.deleteCar] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> updateCar(TkCar car) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.updateCar] = null;

    Map result = await _apis.updateCar(user: user, car: car);
    if (result[kStatusTag] != kSuccessCode) {
      // an error happened
      _error[TkAccountError.updateCar] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.updateCar] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> loadCards() async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.loadCards] = null;

    Map result = await _apis.loadCards(user: user);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.updateModelFromJson(result[kDataTag]);
    } else {
      // an error happened
      _error[TkAccountError.loadCards] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.loadCards] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> addCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.addCard] = null;

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
      _error[TkAccountError.addCard] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.addCard] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> deleteCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.deleteCard] = null;

    Map result = await _apis.deleteCard(user: user, card: card);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      user.cards.removeWhere((element) => element.id == card.id);
    } else {
      // an error happened
      _error[TkAccountError.deleteCard] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.deleteCard] == null);
  }

  /// Get user cars, calls API and loads user model
  Future<bool> updateCard(TkCredit card) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkAccountError.updateCard] = null;

    Map result = await _apis.updateCard(user: user, card: card);
    if (result[kStatusTag] != kSuccessCode) {
      // an error happened
      _error[TkAccountError.updateCard] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkAccountError.updateCard] == null);
  }
}
