import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/analytics_helper.dart';
import 'package:thaki/utilities/index.dart';

class TkBooker extends ChangeNotifier {
  // Helpers
  static TkAPIHelper _apis = new TkAPIHelper();

  // Model
  Map<String, List<TkTicket?>> _tickets = Map();
  List<TkTicket?>? get upcomingTickets => _tickets[kUpcomingTicketsTag];
  List<TkTicket?>? get completedTickets => _tickets[kCompletedTicketsTag];
  List<TkTicket?>? get cancelledTickets => _tickets[kCancelledTicketsTag];
  List<TkTicket?>? get pendingTickets => _tickets[kPendingTicketsTag];

  TkCar? selectedCar;

  bool _bookNow = true;
  bool get bookNow => _bookNow;
  set bookNow(bool value) {
    _bookNow = value;
    notifyListeners();
  }

  DateTime? _bookDate;
  DateTime? get bookDate => _bookDate;
  set bookDate(DateTime? value) {
    _bookDate = value;
    notifyListeners();
  }

  int? _bookDuration;
  int? get bookDuration => _bookDuration;
  set bookDuration(int? value) {
    _bookDuration = value;
    notifyListeners();
  }

  TkTicket? _newTicket;
  TkTicket? get newTicket => _newTicket;

  bool creditMode = false;

  TkCredit? _selectedCard;
  TkCredit? get selectedCard => _selectedCard;
  set selectedCard(TkCredit? card) {
    _selectedCard = card;
    _validationPaymentError = null;
    notifyListeners();
  }

  String? _cvv;
  String? get cvv => _cvv;
  set cvv(String? value) {
    _cvv = value;
    notifyListeners();
  }

  // Validation
  String? _validationPaymentError;
  String? get validationPaymentError => _validationPaymentError;
  bool validatePayment(BuildContext context) {
    if (_selectedCard == null) {
      _validationPaymentError = S.of(context).kSelectPaymentToProceed;
      notifyListeners();
      return false;
    }
    return true;
  }

  void clearBooking() {
    _bookNow = true;
    _bookDate = null;
    _bookDuration = 1;
    creditMode = false;
  }

  // Loading variables
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  bool _isQRLoading = false;
  bool get isQRLoading => _isQRLoading;

  // Errors
  void clearErrors() {
    loadError = parkError = cancelError = balanceError = loadQRError = null;
  }

  String? loadQRError;
  String? loadError;
  String? parkError;
  String? cancelError;
  String? balanceError;

  /// [loadQR]
  /// Calls API to load the ticket QR code if available
  /// [user] the user object
  /// [ticket] the ticket used to get teh QR code
  Future<bool> loadQR(TkUser user, TkTicket ticket) async {
    // Start any loading indicators
    _isQRLoading = true;
    loadQRError = null;
    notifyListeners();

    Map result = await _apis.loadQR(user: user, ticket: ticket);
    if (result[kStatusTag] == kSuccessCode) {
      if (result[kDataTag][kBookingQRMessage] != null) {
        loadQRError = result[kDataTag][kBookingQRMessage];
      } else {
        // Load user data
        TkTicket? theTicket = _tickets[kUpcomingTicketsTag]!.firstWhere(
            (element) => element!.id == ticket.id,
            orElse: () => null);
        if (theTicket != null) {
          theTicket
              .updateModel({kTicketCodeTag: result[kDataTag][kBookingQRData]});
        } else {
          theTicket = _tickets[kCompletedTicketsTag]!.firstWhere(
              (element) => element!.id == ticket.id,
              orElse: () => null);
          if (theTicket != null) {
            theTicket.updateModel(
                {kTicketCodeTag: result[kDataTag][kBookingQRData]});
          } else {
            theTicket = _tickets[kPendingTicketsTag]!.firstWhere(
                (element) => element!.id == ticket.id,
                orElse: () => null);
            if (theTicket != null) {
              theTicket.updateModel(
                  {kTicketCodeTag: result[kDataTag][kBookingQRData]});
            }
          }

          // Update firebase analytics that the user successfully
          // loaded the QR code for the selected ticket
          await TkAnalyticsHelper.logLoadQR();
        }
      }
    } else {
      // an error happened
      loadQRError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isQRLoading = false;
    notifyListeners();

    return (loadQRError == null);
  }

  /// [loadTickets]
  /// Calls the API to load user upcoming, and completed tickets
  /// [user] the user object
  Future<bool> loadTickets(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    loadError = null;

    Map result = await _apis.loadTickets(user: user);

    _tickets.clear();
    _tickets[kUpcomingTicketsTag] = [];
    _tickets[kCancelledTicketsTag] = [];
    _tickets[kCompletedTicketsTag] = [];
    _tickets[kPendingTicketsTag] = [];

    // Notify listeners
    notifyListeners();

    if (result[kStatusTag] == kSuccessCode) {
      // Load user data
      for (String groupTag in [
        kUpcomingTicketsTag,
        kCancelledTicketsTag,
        kCompletedTicketsTag,
        kPendingTicketsTag,
      ]) {
        if (result[kDataTag][kBookingsTag].isNotEmpty) {
          if (result[kDataTag][kBookingsTag][groupTag] != null) {
            for (Map ticketData in result[kDataTag][kBookingsTag][groupTag])
              _tickets[groupTag]!.add(TkTicket.fromJson(ticketData as Map<String, dynamic>));
          }
        }
      }
    } else {
      // an error happened
      loadError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (loadError == null);
  }

  /// [cancelTicket]
  /// Calls API to cancel a ticket for the user
  /// [user] the user object
  /// [ticket] the ticket object to be cancelled
  Future<bool> cancelTicket(TkUser user, TkTicket ticket) async {
    // Start any loading indicators
    _isLoading = true;
    cancelError = null;

    notifyListeners();

    Map result = await _apis.cancelTicket(user: user, ticket: ticket);
    if (result[kStatusTag] == kSuccessCreationCode) {
      // Load user data
      TkTicket? theTicket = _tickets[kUpcomingTicketsTag]!
          .firstWhere((element) => element!.id == ticket.id, orElse: () => null);
      if (theTicket != null) {
        _tickets[kUpcomingTicketsTag]!.remove(theTicket);
        _tickets[kCancelledTicketsTag]!.add(theTicket);
      }
    } else {
      // an error happened
      cancelError = _apis.normalizeError(result);
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (cancelError == null);
  }

  /// [reserveParking]
  /// Calls API to reserve parking for the selected car using the selected date and interval
  /// [user] the user object
  Future<bool> reserveParking(TkUser user) async {
    // Start any loading indicators
    _isLoading = true;
    parkError = null;

    notifyListeners();

    Map result = await _apis.reserveParking(
      user: user,
      car: selectedCar!,
      dateTime: _bookNow ? null : _bookDate,
      duration: _bookDuration,
      card: _selectedCard,
    );

    // Clear model
    _newTicket = null;
    if (result[kStatusTag] != kSuccessCreationCode) {
      // an _purchaseError happened
      parkError = _apis.normalizeError(result);
    } else {
      _newTicket = TkTicket.fromJson(result[kDataTag][kBookingInfoTag]);
      _tickets[kUpcomingTicketsTag]!.add(_newTicket);
      _tickets[kUpcomingTicketsTag]!.sort((a, b) => a!.start!.compareTo(b!.start!));

      // Update firebase analytics that the user successfully
      // booked a new ticket
      await TkAnalyticsHelper.logBookTicket();
    }

    // Stop any listening loading indicators
    _isLoading = false;
    notifyListeners();

    return (parkError == null);
  }
}
