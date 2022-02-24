import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/db_helper.dart';

/// [TkBadgeHelper]
/// A helper class that takes care of the app badge showing
/// the number of unseen notifications.
class TkBadgeHelper {
  /// [updateBadge]
  /// Static method that updates the app badge based on the passed
  /// notifications, if the notifications is not passed, the method
  /// opens the notifications database and checks for unseen notifications
  /// [notifications] list of notifications to use to display the badge
  static Future<void> updateBadge({List<TkNotification> notifications}) async {
    // Check if the platform supports badges
    if (!await FlutterAppBadger.isAppBadgeSupported()) {
      return;
    }

    int count = 0;

    // First check if the notifications list is passed
    if (notifications != null) {
      for (TkNotification notification in notifications)
        if (!notification.isSeen) count++;
    } else {
      // No notifications list, get the data from the database
      List<Map<String, dynamic>> messages = await TkDBHelper.readFromDatabase(
          kNtfTableName, kCreateNtfDBCmd, kSelectBtfDBCmd);
      for (Map<String, dynamic> message in messages) {
        Map<String, dynamic> js = json.decode(message[kNtfDataColumnName]);

        TkNotification notification = TkNotification.fromJson(js);
        if (!notification.isSeen) count++;
      }
    }

    // Update badge with count
    if (count > 0)
      FlutterAppBadger.updateBadgeCount(count);
    else
      FlutterAppBadger.removeBadge();

    // Save count to shared preference
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Store user token in shared preferences
    prefs.setString(kNotificationsCount, count.toString());
  }

  /// [removeBadge]
  /// Helper method that clears the app badge
  static Future<void> removeBadge() async {
    // Check if the platform supports badges
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      FlutterAppBadger.removeBadge();

      // Save count to shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString(kNotificationsCount, '0');
    }
  }

  /// [incrementBadge]
  /// Helper method that increments the badge count
  static Future<void> incrementBadge() async {
    // Check if the platform supports badges
    if (await FlutterAppBadger.isAppBadgeSupported()) {
      // Get count to shared preference
      SharedPreferences prefs = await SharedPreferences.getInstance();
      int count = int.tryParse(prefs.getString(kNotificationsCount));

      // Increment count
      count = count == null ? 1 : count + 1;

      // Update badge
      FlutterAppBadger.updateBadgeCount(count);
    }
  }
}
