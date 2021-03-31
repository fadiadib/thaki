import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

class TkBooker extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  List<TkTicket> _tickets = [];
  List<TkTicket> get tickets => _tickets;
  TkBalance _balance;
  TkBalance get balance => _balance;
  TkCar selectedCar;

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Errors
  String _loadError;
  String get loadError => _loadError;
  String _parkError;
  String get parkError => _parkError;
  String _cancelError;
  String get cancelError => _cancelError;
  String _balanceError;
  String get balanceError => _balanceError;

  // TODO: Cancel ticket method

  /// Load user tickets method
  Future<bool> loadTickets(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.loadTickets(userToken: user.token);

    _loadError = null;
    _tickets.clear();
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      for (Map data in result[kDataTag]) _tickets.add(TkTicket.fromJson(data));
    } else {
      // an error happened
      _loadError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_loadError == null);
  }

  /// Load user balance method
  Future<bool> loadBalance(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;

    Map result = await _apis.loadBalance(userToken: user.token);

    _balanceError = null;
    _balance = null;
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      _balance = TkBalance.fromJson(result[kDataTag]);
    } else {
      // an error happened
      _balanceError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_balanceError == null);
  }

  /// Reserve Parking
  Future<bool> reserveParking() async {
    // Start any loading indicators
    _isLoading = true;

    // Map result = await _apis.payViolations(
    //     violations: selectedViolations, card: selectedCard);
    //
    // // Clear model
    // _parkError = null;
    //
    // if (result[kStatusTag] != kSuccessCode) {
    //   // an _purchaseError happened
    //   _parkError = result[kErrorMessageTag] ?? kUnknownError;
    // }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_parkError == null);
  }
}
