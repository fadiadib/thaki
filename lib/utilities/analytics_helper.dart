import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';

class TkAnalyticsHelper {
  static FirebaseAnalytics _analytics = FirebaseAnalytics();

  static FirebaseAnalyticsObserver getAnalyticsObserver() =>
      FirebaseAnalyticsObserver(analytics: _analytics);

  // TODO: Add static methods fro each event that needs to be recorded
}
