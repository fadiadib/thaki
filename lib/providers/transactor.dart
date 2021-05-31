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

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Error
  String transactionError;

  /// Reserve Parking
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
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (transactionError == null);
  }
}
