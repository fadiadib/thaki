import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkSubscriberError {
  loadDisclaimer,
  apply,
  loadAllSubs,
  buy,
  loadUserSubs,
  loadDocuments
}

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
  void clearErrors() => _error.clear();

  String loadUserSubscriptionsError;

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
    for (TkDocument doc in _documents) {
      if (doc.required && doc.image == null) {
        _validationDocumentsError = S.of(context).kUploadDocumentsToProceed;
        notifyListeners();
        return false;
      }
    }
    return true;
  }

  /// Load disclaimer
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

  /// Load documents
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

  /// Apply for resident permit method
  Future<bool> applyForSubscription(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkSubscriberError.apply] = null;
    _permit.documents = _documents;

    final Map result = await _apis.applyForSubscription(
        permit: _permit, user: user, car: selectedCar);

    // Clear model
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an error happened
      _error[TkSubscriberError.apply] = _apis.normalizeError(result);
    } else {
      selectedCar.isApproved = 3;
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

    final Map result = await _apis.loadSubscriptions(user: user);

    // Clear model
    _subscriptions.clear();
    _cvv = null;
    if (result[kStatusTag] == kSuccessCode) {
      for (Map data in result[kDataTag][kSubscriptionsTag]) {
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

  /// Purchase subscription
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

  /// Load user subscriptions
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
