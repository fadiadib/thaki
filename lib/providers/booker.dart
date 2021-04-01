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
  List<TkTicket> get upcomingTickets {
    List<TkTicket> tickets = [];
    for (TkTicket ticket in _tickets) {
      if (ticket.end.isAfter(DateTime.now()) && !ticket.cancelled)
        tickets.add(ticket);
    }
    return tickets;
  }

  List<TkTicket> get completedTickets {
    List<TkTicket> tickets = [];
    for (TkTicket ticket in _tickets) {
      if (ticket.end.isBefore(DateTime.now()) && !ticket.cancelled)
        tickets.add(ticket);
    }
    return tickets;
  }

  List<TkTicket> get cancelledTickets {
    List<TkTicket> tickets = [];
    for (TkTicket ticket in _tickets) {
      if (ticket.cancelled) tickets.add(ticket);
    }
    return tickets;
  }

  TkBalance _balance;
  TkBalance get balance => _balance;

  TkCar selectedCar;

  bool _bookNow = true;
  bool get bookNow => _bookNow;
  set bookNow(bool value) {
    _bookNow = value;
    notifyListeners();
  }

  DateTime _bookDate;
  DateTime get bookDate => _bookDate;
  set bookDate(DateTime value) {
    _bookDate = value;
    notifyListeners();
  }

  int _bookDuration;
  int get bookDuration => _bookDuration;
  set bookDuration(int value) {
    _bookDuration = value;
    notifyListeners();
  }

  TkTicket _newTicket;
  TkTicket get newTicket => _newTicket;

  void clearBooking() {
    _bookNow = true;
    _bookDate = null;
    _bookDuration = 1;
  }

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

    Map result = await _apis.reserveParking(
        dateTime: _bookNow ? DateTime.now() : _bookDate,
        duration: _bookDuration);

    // Clear model
    _parkError = null;
    _newTicket = null;
    if (result[kStatusTag] != kSuccessCode) {
      // an _purchaseError happened
      _parkError = result[kErrorMessageTag] ?? kUnknownError;
    } else {
      _newTicket = TkTicket.fromJson(result[kDataTag][kTicketTag]);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_parkError == null);
  }
}
