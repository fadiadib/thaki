import 'package:flutter/foundation.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

enum TkBookerError { load, park, cancel, balance }

class TkBooker extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  Map<String, List<TkTicket>> _tickets = Map();
  List<TkTicket> get upcomingTickets => _tickets[kUpcomingTicketsTag];
  List<TkTicket> get completedTickets => _tickets[kCompletedTicketsTag];
  List<TkTicket> get cancelledTickets => _tickets[kCancelledTicketsTag];

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
  Map<TkBookerError, String> _error = Map();
  Map<TkBookerError, String> get error => _error;
  String loadQRError;
  void clearErrors() => _error.clear();

  Future<bool> loadQR(TkUser user, TkTicket ticket) async {
    // Start any loading indicators
    _isLoading = true;
    loadQRError = null;

    Map result = await _apis.loadQR(user: user, ticket: ticket);
    if (result[kStatusTag] == kSuccessCode) {
      if (result[kDataTag]['qr_message'] != null) {
        loadQRError = result[kDataTag]['qr_message'];
      } else {
        // Load user data
        TkTicket theTicket = _tickets[kUpcomingTicketsTag].firstWhere(
            (element) => element.id == ticket.id,
            orElse: () => null);
        if (theTicket != null) {
          theTicket.updateModel({
            kTicketCodeTag: result[kDataTag][kBookingQRData],
          });
        } else {
          theTicket = _tickets[kCompletedTicketsTag].firstWhere(
              (element) => element.id == ticket.id,
              orElse: () => null);
          if (theTicket != null) {
            theTicket.updateModel({
              kTicketCodeTag: result[kDataTag][kBookingQRData],
            });
          }
        }
      }
    } else {
      // an error happened
      loadQRError = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadQRError == null);
  }

  /// Load user tickets method
  Future<bool> loadTickets(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkBookerError.load] = null;

    Map result = await _apis.loadTickets(user: user);

    _tickets.clear();
    _tickets[kUpcomingTicketsTag] = [];
    _tickets[kCancelledTicketsTag] = [];
    _tickets[kCompletedTicketsTag] = [];

    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      for (String groupTag in [
        kUpcomingTicketsTag,
        kCancelledTicketsTag,
        kCompletedTicketsTag
      ]) {
        if (result[kDataTag][kBookingsTag].isNotEmpty) {
          if (result[kDataTag][kBookingsTag][groupTag] != null) {
            for (Map ticketData in result[kDataTag][kBookingsTag][groupTag])
              _tickets[groupTag].add(TkTicket.fromJson(ticketData));
          }
        }
      }
    } else {
      // an error happened
      _error[TkBookerError.load] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkBookerError.load] == null);
  }

  /// Cancel ticket method
  Future<bool> cancelTicket(TkUser user, TkTicket ticket) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkBookerError.cancel] = null;

    notifyListeners();

    Map result = await _apis.cancelTicket(user: user, ticket: ticket);
    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      TkTicket theTicket = _tickets[kUpcomingTicketsTag]
          .firstWhere((element) => element.id == ticket.id, orElse: () => null);
      if (theTicket != null) {
        _tickets[kUpcomingTicketsTag].remove(theTicket);
        _tickets[kCancelledTicketsTag].add(theTicket);
      }
    } else {
      // an error happened
      _error[TkBookerError.cancel] = result[kErrorMessageTag] ?? kUnknownError;
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkBookerError.cancel] == null);
  }

  /// Reserve Parking
  Future<bool> reserveParking(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    _error[TkBookerError.park] = null;

    notifyListeners();

    Map result = await _apis.reserveParking(
      user: user,
      car: selectedCar,
      dateTime: _bookNow ? null : _bookDate,
      duration: _bookDuration,
    );

    // Clear model
    _newTicket = null;
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an _purchaseError happened
      _error[TkBookerError.park] = result[kErrorMessageTag] ?? kUnknownError;
    } else {
      _newTicket = TkTicket.fromJson(result[kDataTag][kBookingInfoTag]);
      _tickets[kUpcomingTicketsTag].add(_newTicket);
      _tickets[kUpcomingTicketsTag].sort((a, b) => a.start.compareTo(b.start));
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (_error[TkBookerError.park] == null);
  }
}
