import 'dart:async';
import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/analytics_helper.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/providers/lang_controller.dart';

enum TkTransactionType { booking, package, subscription, violation }

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

  /// [initTransaction]
  /// Initialize transaction method
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

  /// [checkTransaction]
  /// Calls an API that checks the transaction result
  /// returns status: 1 => pending, 2 => Error, 0 => success
  /// [user] the user object
  /// [langController] language controller provider, used in case of guest checkout
  /// [guest] boolean to control whether it is a guest or logged in user
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

  /// [startTransactionChecker]
  /// Start a timer that periodically calls the transaction check API
  /// [user] the user object
  /// [callback] method to call when a result is success or failure is returned
  /// [langController] the language controller provider (used in case of guest login)
  /// [guest] boolean whether to pay as guest or as logged in user
  void startTransactionChecker({
    @required TkUser user,
    @required Function callback,
    @required TkLangController langController,
    @required TkTransactionType type,
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
          // Stop the transaction checker
          stopTransactionChecker();

          // Check if the result is success
          transactionResult = result == 0;

          // Update firebase analytics in case of success
          if (transactionResult) {
            switch (type) {
              case TkTransactionType.violation:
                TkAnalyticsHelper.logPayViolation();
                break;
              case TkTransactionType.package:
                TkAnalyticsHelper.logPurchasePackage();
                break;
              case TkTransactionType.subscription:
                TkAnalyticsHelper.logPurchaseSubscription();
                break;
              case TkTransactionType.booking:
                break;
            }
          } else {
            // Log purchase failure
            TkAnalyticsHelper.logPurchaseFailure();
          }

          // Call callback with result as bool
          callback(transactionResult);
        }
      }
    });
  }

  /// [stopTransactionChecker]
  /// Stops the transaction checker timer
  void stopTransactionChecker() {
    _avoidConcurrency = false;

    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }

  /// [loadTransactionsModel]
  /// Loads the packages transactions, subscriptions transactions
  /// and violations transactions
  /// [data] map containing the transactions data
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

  /// [loadTransactions]
  /// Calls API to retrieve user transactions
  /// [user] the user object
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
