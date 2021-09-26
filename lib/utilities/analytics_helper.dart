import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

/// [TkAnalyticsHelper]
/// A utility class that logs firebase analytics events
class TkAnalyticsHelper {
  /// FirebaseAnalytics object
  static FirebaseAnalytics _analytics = FirebaseAnalytics();

  /// [getAnalyticsObserver]
  /// Creates a firebase analytics observer passed to the app pages routes
  static FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  /// [setUserProperties]
  /// Sets the user properties in firebase analytics
  /// [user] TkUser object of the current user
  static Future<void> setUserProperties(TkUser user) async {
    await _analytics.setUserId(user.token);
  }

  /// [logLogin]
  /// Records in firebase analytics a user login event
  /// [method] login method either email, or social
  static Future<void> logLogin(String method) async {
    await _analytics.logLogin(loginMethod: method);
  }

  /// [logSignUp]
  /// Records in firebase analytics a user sign up event
  /// [method] login method either email, or social
  static Future<void> logSignUp(String method) async {
    await _analytics.logSignUp(signUpMethod: method);
  }

  /// [logAddCar]
  /// Records in firebase analytics when a user adds a car
  static Future<void> logAddCar() async {
    await _analytics.logEvent(name: kAddCarEvent);
  }

  /// [logBookTicket]
  /// Records in firebase analytics when a user books a ticket
  static Future<void> logBookTicket() async {
    await _analytics.logEvent(name: kBookTicketEvent);
  }

  /// [logLoadQR]
  /// Records in firebase analytics when a user loads the ticket QR code
  static Future<void> logLoadQR() async {
    await _analytics.logEvent(name: kLoadQREvent);
  }

  /// [logApplyPermit]
  /// Records in firebase analytics when a user applies for a resident permit
  static Future<void> logApplyPermit() async {
    await _analytics.logEvent(name: kApplyPermitEvent);
  }

  /// [logPurchasePackage]
  /// Records in firebase analytics when a user purchases a package
  static Future<void> logPurchasePackage() async {
    await _analytics.logEvent(name: kPurchasePackageEvent);
  }

  /// [logPurchaseSubscription]
  /// Records in firebase analytics when a user purchases a subscription
  static Future<void> logPurchaseSubscription() async {
    await _analytics.logEvent(name: kPurchaseSubscriptionEvent);
  }

  /// [logPurchaseSubscription]
  /// Records in firebase analytics when a user pays a violation
  static Future<void> logPayViolation() async {
    await _analytics.logEvent(name: kPayViolationEvent);
  }

  /// [logPurchaseFailure]
  /// Records in firebase analytics when a user failed to make a transaction
  static Future<void> logPurchaseFailure() async {
    await _analytics.logEvent(name: kPurchaseFailureEvent);
  }
}
