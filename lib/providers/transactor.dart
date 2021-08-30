import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/providers/lang_controller.dart';

class TkTransactor extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  String transactionPage;
  String callbackPage;
  String transactionId;
  bool transactionResult;
  List<TkTransaction> _transactions = [];
  List<TkTransaction> transactions<T>() {
    List<TkTransaction> result = [];
    _transactions.forEach((element) {
      if (element is T) result.add(element);
    });

    return result;
  }

  // Timer
  Timer _timer;
  bool _avoidConcurrency = false;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  bool _isTransacting = false;
  bool get isTransacting => _isTransacting;
  set isTransacting(bool value) {
    _isTransacting = value;
    notifyListeners();
  }

  // Error
  String transactionError;
  String loadTransactionsError;

  /// Initialize transaction
  Future<bool> initTransaction({
    TkUser user,
    String type,
    TkLangController langController,
    int id,
    TkCar car,
    DateTime dateTime,
    int duration,
    List<int> ids,
    bool guest = false,
  }) async {
    // Start any loading indicators
    _isLoading = true;
    transactionError = null;

    notifyListeners();

    Map result = Map();

    if (!guest) {
      result = await _apis.initTransaction(
        user: user,
        type: type,
        id: id,
        car: car,
        dateTime: dateTime,
        duration: duration,
        ids: ids,
      );
    } else {
      result = await _apis.initGuestTransaction(
        langController: langController,
        type: type,
        id: id,
        car: car,
        dateTime: dateTime,
        duration: duration,
        ids: ids,
      );
    }

    // Clear model
    if (result[kStatusTag] != kSuccessCreationCode) {
      transactionError = _apis.normalizeError(result);
    } else {
      transactionPage = result[kDataTag][kPaymentLinkTag];
      callbackPage = result[kDataTag][kRedirectLinkTag];
      transactionId = result[kDataTag][kSessionIdTag];
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (transactionError == null);
  }

  /// Check transaction
  Future<int> checkTransaction({
    @required TkUser user,
    @required TkLangController langController,
    bool guest = false,
  }) async {
    // Start any loading indicators
    transactionError = null;

    notifyListeners();

    Map result = await _apis.checkTransaction(
      user: user,
      transactionId: transactionId,
      langController: langController,
      guest: guest,
    );

    int status = 1; // 1 means pending
    if (result[kStatusTag] == kTransErrorCode) {
      transactionError = _apis.normalizeError(result);
      status = 2;
    } else if (result[kStatusTag] == kSuccessCode) status = 0;

    // Stop any listening loading indicators
    notifyListeners();

    return status;
  }

  void startTransactionChecker({
    @required TkUser user,
    @required Function callback,
    @required TkLangController langController,
    bool guest = false,
  }) {
    // Check if there is an active payment request
    if (transactionId == null) return;

    // Cancel any old timer
    if (_timer != null) return;

    // Start a new timer
    transactionResult = null;
    _avoidConcurrency = false;

    _timer =
        Timer.periodic(Duration(seconds: kTransactionRefreshTimer), (t) async {
      // Check payment status
      if (!_avoidConcurrency) {
        _avoidConcurrency = true;
        int result = await checkTransaction(
                user: user, langController: langController, guest: guest)
            .then((int value) {
          _avoidConcurrency = false;
          return value;
        });
        if (result == 0 || result == 2) {
          // Success or failure
          stopTransactionChecker();
          transactionResult = result == 0;
          callback(result == 0);
        }
      }
    });
  }

  void stopTransactionChecker() {
    _avoidConcurrency = false;

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  /// Loads the packages transactions, subscriptions transactions
  /// and violations transactions
  void loadTransactionsModel(Map<String, dynamic> data) {
    // Load packages
    _transactions.clear();

    for (Map json in data[kPackagesTag])
      _transactions.insert(0, TkPackageTransaction.fromJson(json));

    // Load subscriptions
    for (Map json in data[kSubscriptionsTag])
      _transactions.insert(0, TkSubscriptionTransaction.fromJson(json));

    // Load violations
    for (Map json in data[kViolationsTag])
      _transactions.insert(0, TkViolationTransaction.fromJson(json));
  }

  /// Get user transactions
  Future<bool> loadTransactions({TkUser user}) async {
    // Start any loading indicators
    _isLoading = true;
    loadTransactionsError = null;

    final Map result = await _apis.getTransactions(user: user);

    // Clear model
    if (result[kStatusTag] != kSuccessCode) {
      loadTransactionsError = _apis.normalizeError(result);
    } else {
      loadTransactionsModel(result[kDataTag][kTransactionsTag]);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadTransactionsError == null);
  }
}
