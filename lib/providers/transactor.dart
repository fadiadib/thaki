import 'dart:async';

import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkTransactor extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  String transactionPage;
  String callbackPage;
  String transactionId;
  bool transactionResult;

  // Timer
  Timer _timer;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Error
  String transactionError;

  /// Initialize transaction
  Future<bool> initTransaction({
    TkUser user,
    String type,
    int id,
    TkCar car,
    DateTime dateTime,
    int duration,
  }) async {
    // Start any loading indicators
    _isLoading = true;
    transactionError = null;

    notifyListeners();

    Map result = await _apis.initTransaction(
      user: user,
      type: type,
      id: id,
      car: car,
      dateTime: dateTime,
      duration: duration,
    );

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
  Future<int> checkTransaction({@required TkUser user}) async {
    // Start any loading indicators
    transactionError = null;

    notifyListeners();

    Map result =
        await _apis.checkTransaction(user: user, transactionId: transactionId);

    int status = 1; // 1 means pending
    if (result[kStatusTag] == kTransErrorCode) {
      transactionError = _apis.normalizeError(result);
      status = 2;
    } else if (result[kStatusTag] == kSuccessCode) status = 0;

    // Stop any listening loading indicators
    notifyListeners();

    return status;
  }

  void startTransactionChecker(
      {@required TkUser user, @required Function callback}) {
    // Check if there is an active payment request
    if (transactionId == null) return;

    // Cancel any old timer
    if (_timer != null) return;

    // Start a new timer
    transactionResult = null;
    _timer = Timer.periodic(Duration(seconds: 10), (t) async {
      // Check payment status
      int result = await checkTransaction(user: user);
      if (result == 0 || result == 2) {
        // Success or failure
        stopTransactionChecker();
        transactionResult = result == 0;
        callback(result == 0);
      }
    });
  }

  void stopTransactionChecker() {
    if (_timer != null) {
      _timer.cancel();
      _timer = null;
    }
  }
}
