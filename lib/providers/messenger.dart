import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:mutex/mutex.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

/// Don't shoot the messenger!
/// Change Notifier that deals with all push notifications
/// and notifies the UI accordingly
class TkMessenger extends ChangeNotifier {
  static Mutex mutex = Mutex();

  // Model variables
  static List<TkNotification> _notifications = [];
  List<TkNotification> get notifications => _notifications;

  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();

  /// Class constructor
  TkMessenger() {
    // Request notifications permissions on ios
    if (Platform.isIOS) _firebaseMessaging.requestNotificationPermissions();

    // Initialize message handlers
    firebaseCloudMessagingListeners();

    // Read notifications from database
    initNotifications();
  }

  /// Initializes the notifications events callbacks
  void firebaseCloudMessagingListeners() {
    _firebaseMessaging.configure(
      // Foreground notification
      onMessage: (Map<String, dynamic> message) async {
        if (kVerboseNetworkMessages) print("onMessage: $message");
        addNotification(message);
      },

      // App comes to the foreground
      onLaunch: (Map<String, dynamic> message) async {
        if (kVerboseNetworkMessages) print("onLaunch: $message");
        addNotification(message);
      },

      // App starts
      onResume: (Map<String, dynamic> message) async {
        if (kVerboseNetworkMessages) print("onResume: $message");
        addNotification(message);
      },
    );

    // Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    // fcmStream.listen((token) async {
    //   if (_user != null) {
    //     String fbToken = await FirebaseMessaging().getToken();
    //     if (fbToken != null) {
    //       if (await _user.updateFbToken(fbToken)) {
    //         // Save the new firebase token in the preferences
    //         SharedPreferences prefs = await SharedPreferences.getInstance();
    //         prefs.setString(kFbTokenTag, token);
    //       }
    //     }
    //   }
    // });
  }

  /// Checks if any of the notifications was not seen
  bool get hasNewNotifications {
    TkNotification found = _notifications.firstWhere(
      (TkNotification n) => n.isSeen == false,
      orElse: () => null,
    );
    return found != null;
  }

  /// Initializes the notifications from the database
  Future<void> initNotifications() async {
    // Get the data from the database
    List<Map<String, dynamic>> messages = await TkDBHelper.readFromDatabase(
        kNtfTableName, kCreateNtfDBCmd, kSelectBtfDBCmd);

    // Iterate on each row and create a notification object
    for (Map<String, dynamic> message in messages) {
      Map<String, dynamic> js = json.decode(message[kNtfDataColumnName]);

      TkNotification notification = TkNotification(js);
      if (notification.expiry != null &&
          notification.expiry.isBefore(DateTime.now())) {
        // Expired, Remove from database
        await TkDBHelper.deleteFromDatabase(
          kNtfTableName,
          kCreateNtfDBCmd,
          kDeleteNtfDBCmd,
          notification.id,
        );
      } else {
        // Add the notification to the list
        _notifications.insert(0, notification);
      }
    }

    // Notify listeners
    notifyListeners();
  }

  /// Add a new notification
  Future<void> addNotification(Map<String, dynamic> message) async {
    await mutex.acquire();

    try {
      TkNotification notification = TkNotification(message);

      // Look for a notification with the same id
      TkNotification found = _notifications.firstWhere(
          (TkNotification n) => n.id == notification.id,
          orElse: () => null);
      if (found == null) {
        // Add the notification to the list
        _notifications.insert(0, notification);

        // No onl notification with same id, so Insert the new one into database
        await TkDBHelper.insertInDatabase(
            kNtfTableName,
            kCreateNtfDBCmd,
            kInsertNtfDBCmd,
            kSelectIdNtfDBCmd,
            notification.id,
            json.encode(message));

        // Notify listeners
        notifyListeners();
      }
    } finally {
      mutex.release();
    }
  }

  /// Update seen
  Future<void> updateSeen(TkNotification notification, bool status) async {
    notification.isSeen = status;

    // Remove old entry
    await TkDBHelper.deleteFromDatabase(
        kNtfTableName, kCreateNtfDBCmd, kDeleteNtfDBCmd, notification.id);

    // Add a new entry
    await TkDBHelper.insertInDatabase(
        kNtfTableName,
        kCreateNtfDBCmd,
        kInsertNtfDBCmd,
        kSelectIdNtfDBCmd,
        notification.id,
        json.encode(notification.toJson()));

    notifyListeners();
  }

  Future<void> clearNotifications() async {
    // Remove all notifications from database
    await TkDBHelper.deleteDatabase(
        kNtfTableName, kCreateNtfDBCmd, kDeleteAllNtfDBCmd);

    _notifications.clear();

    notifyListeners();
  }
}
