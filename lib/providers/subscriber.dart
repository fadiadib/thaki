import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkSubscriberError { loadDisclaimer, apply, loadAllSubs, buy, loadUserSubs }

class TkSubscriber extends ChangeNotifier {
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

  set frontImage(File image) {
    _validationDocumentsError = null;
    _permit.idFront = image;
    notifyListeners();
  }

  set backImage(File image) {
    _validationDocumentsError = null;
    _permit.idBack = image;
    notifyListeners();
  }

  List<TkSubscription> _subscriptions = [];
  List<TkSubscription> get subscriptions => _subscriptions;
  TkSubscription _selectedSubscription;
  TkSubscription get selectedSubscription => _selectedSubscription;
  set selectedSubscription(TkSubscription sub) {
    _selectedSubscription = sub;
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

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  Map<TkSubscriberError, String> _error = Map();
  Map<TkSubscriberError, String> get error => _error;
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

  // Validation
  String _validationDocumentsError;
  String get validationDocumentsError => _validationDocumentsError;
  bool validateDocuments(BuildContext context) {
    if (_permit.idBack == null || _permit.idFront == null) {
      _validationDocumentsError = S.of(context).kUploadDocumentsToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  /// Load disclaimer
  Future<bool> loadDisclaimer(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.loadDisclaimer] = null;

    Map result = await _apis.loadDisclaimer(user: user, type: 'subscription');

    // Clear model
    _disclaimer = null;
    if (result[kStatusTag] == kSuccessCode) {
      _disclaimer = result[kDataTag][kDisclaimerTag];
    } else {
      // an error happened
      _error[TkSubscriberError.loadDisclaimer] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.loadDisclaimer] == null);
  }

  /// Apply for resident permit method
  Future<bool> applyForSubscription(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.apply] = null;

    Map result = await _apis.applyForSubscription(permit: _permit, user: user);

    // Clear model
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an error happened
      _error[TkSubscriberError.apply] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.apply] == null);
  }

  /// Load disclaimer
  Future<bool> loadSubscriptions(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.loadAllSubs] = null;
    _selectedSubscription = null;

    Map result = await _apis.loadSubscriptions(user: user);

    // Clear model
    _subscriptions.clear();
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kSubscriptionsTag]) {
        _subscriptions.add(TkSubscription.fromJson(data));
      }
      if (_subscriptions.isNotEmpty)
        _selectedSubscription = _subscriptions.first;
    } else {
      // an error happened
      _error[TkSubscriberError.loadAllSubs] =
          result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.loadAllSubs] == null);
  }

  /// Purchase subscription
  Future<bool> purchaseSelectedSubscription(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.buy] = null;

    Map result = await _apis.buySubscriptions(
        user: user,
        subscription: _selectedSubscription,
        card: _selectedCard,
        cvv: _cvv);

    if (result[kStatusTag] != kSuccessCode) {
      _error[TkSubscriberError.buy] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.buy] == null);
  }
}
