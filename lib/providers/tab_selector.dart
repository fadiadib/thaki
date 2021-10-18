import 'package:flutter/foundation.dart';

/// Controls the active tab in the Home page
/// 0: Profile
/// 1: Tickets
/// 2: Dashboard
/// 3: Booking
/// 4: Violations
class TkTabSelector extends ChangeNotifier {
  // Default tab is Dashboard
  int _activeTab = 2;
  int get activeTab => _activeTab;

  /// Sets the active tab and updates listeners
  set activeTab(int index) {
    _activeTab = index;
    notifyListeners();
  }

  /// Checkers on active tab
  bool get isProfile => _activeTab == 4;
  bool get isTickets => _activeTab == 3;
  bool get isDashboard => _activeTab == 2;
  bool get isBooking => _activeTab == 1;
  bool get isViolations => _activeTab == 0;

  /// Setters of active tab
  void selectProfile() => activeTab = 4;
  void selectTickets() => activeTab = 3;
  void selectDashboard() => activeTab = 2;
  void selectBooking() => activeTab = 1;
  void selectViolations() => activeTab = 0;
}
