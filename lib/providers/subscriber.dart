import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/analytics_helper.dart';
import 'package:thaki/utilities/index.dart';

enum TkSubscriberError {
  loadDisclaimer,
  apply,
  loadAllSubs,
  buy,
  loadUserSubs,
  loadDocuments
}

/// [TkSubscriber]
/// Provider class that manages permit requests and subscriptions
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

  List<TkSubscription> _subscriptions = [];
  List<TkSubscription> get subscriptions => _subscriptions;
  List<TkSubscription> _userSubscriptions = [];
  List<TkSubscription> get userSubscriptions => _userSubscriptions;
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

  TkCar selectedCar;

  String _cvv;
  String get cvv => _cvv;
  set cvv(String value) {
    _cvv = value;
    notifyListeners();
  }

  List<TkDocument> _documents = [];
  List<TkDocument> get documents => _documents;
  void updateDocument(String tag, File image) {
    TkDocument found = _documents.firstWhere((element) => element.tag == tag,
        orElse: () => null);
    if (found != null) {
      found.image = image;
      notifyListeners();
    }
  }

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  Map<TkSubscriberError, String> _error = Map();
  Map<TkSubscriberError, String> get error => _error;
  String loadUserSubscriptionsError;
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

  // Documents validation error
  String _validationDocumentsError;
  String get validationDocumentsError => _validationDocumentsError;
  set validationDocumentsError(String error) {
    _validationDocumentsError = error;
    notifyListeners();
  }

  /// [validateDocuments]
  /// Loops on the provided documents and makes sure that all the required
  /// documents are uploaded correctly
  bool validateDocuments(BuildContext context) {
    for (TkDocument doc in _documents) {
      if (doc.required && doc.image == null) {
        _validationDocumentsError = S.of(context).kUploadDocumentsToProceed;
        notifyListeners();
        return false;
      }
    }
    return true;
  }

  /// [loadDisclaimer]
  /// Calls API to load the permit disclaimer
  /// [user] the user object
  Future<bool> loadDisclaimer(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.loadDisclaimer] = null;

    final Map result =
        await _apis.loadDisclaimer(user: user, type: 'subscription');

    // Clear model
    _disclaimer = null;
    if (result[kStatusTag] == kSuccessCode) {
      _disclaimer = result[kDataTag][kDisclaimerTag];
    } else {
      // an error happened
      _error[TkSubscriberError.loadDisclaimer] = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.loadDisclaimer] == null);
  }

  /// [loadDocuments]
  /// Calls API to load the permit required documents
  /// [user] the user object
  Future<bool> loadDocuments(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.loadDocuments] = null;
    _documents.clear();

    final Map result =
        await _apis.loadDocuments(user: user, type: 'subscription');
    if (result[kStatusTag] == kSuccessCode) {
      for (Map json in result[kDataTag][kDocumentsTag]) {
        _documents.add(TkDocument.fromJson(json));
      }
    } else {
      // an error happened
      _error[TkSubscriberError.loadDocuments] = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.loadDocuments] == null);
  }

  /// [applyForSubscription]
  /// Calls API to apply for resident permit
  /// [user] the user object
  Future<bool> applyForSubscription(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.apply] = null;
    _permit.documents = _documents;

    final Map result = await _apis.applyForSubscription(
        permit: _permit, user: user, car: selectedCar);
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an error happened
      _error[TkSubscriberError.apply] = _apis.normalizeError(result);
    } else {
      selectedCar.isApproved = 3;

      // Update firebase analytics that the user successfully
      // applied for a resident permit
      await TkAnalyticsHelper.logApplyPermit();
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.apply] == null);
  }

  /// [loadSubscriptions]
  /// Calls API to load all types of subscriptions for the user to purchase
  /// [user] the user object
  Future<bool> loadSubscriptions(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.loadAllSubs] = null;
    _selectedSubscription = null;

    final Map result = await _apis.loadSubscriptions(user: user);

    // Clear model
    _subscriptions.clear();
    _cvv = null;
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kSubscriptionsListTag]) {
        _subscriptions.add(TkSubscription.fromJson(data));
      }
      if (_subscriptions.isNotEmpty)
        _selectedSubscription = _subscriptions.first;
    } else {
      // an error happened
      _error[TkSubscriberError.loadAllSubs] = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.loadAllSubs] == null);
  }

  /// [purchaseSelectedSubscription]
  /// Calls API to purchase the selected subscription, this method
  /// is only called in save cards mode, for transaction mode, the
  /// transactor provider is used instead
  /// [user] the user object
  Future<bool> purchaseSelectedSubscription(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.buy] = null;

    final Map result = await _apis.buySubscriptions(
      user: user,
      car: selectedCar,
      subscription: _selectedSubscription,
      card: _selectedCard,
      cvv: _cvv,
    );

    if (result[kStatusTag] != kSuccessCreationCode) {
      _error[TkSubscriberError.buy] = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkSubscriberError.buy] == null);
  }

  /// [loadUserSubscriptions]
  /// Calls API to load user subscriptions
  /// [user] the user object
  Future<bool> loadUserSubscriptions(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    loadUserSubscriptionsError = null;

    final Map result = await _apis.loadUserSubscriptions(user: user);

    // Clear model
    _userSubscriptions.clear();
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kSubscriptionsClientTag]) {
        _userSubscriptions.add(TkSubscription.fromUserSubscriptionsJson(data));
      }
    } else {
      // an error happened
      loadUserSubscriptionsError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadUserSubscriptionsError == null);
  }
}
