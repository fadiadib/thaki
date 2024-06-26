import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:mutex/mutex.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

/// [_firebaseMessagingBackgroundHandler]
/// Global function that handles background messages
/// Adds the new notification to the notifications database and updates the app badge
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // Update badge
  TkBadgeHelper.incrementBadge();

  // Initialize firebase
  await Firebase.initializeApp();

  // Create a new notification object and insert it into the database
  // when the app comes to the foreground, the notifications are
  // reinitialized from the database
  final TkNotification notification = TkNotification.fromJson(message.data);
  TkDBHelper.insertInDatabase(
    kNtfTableName,
    kCreateNtfDBCmd,
    kInsertNtfDBCmd,
    kSelectIdNtfDBCmd,
    notification.id,
    json.encode(notification.toJson()),
    force: true,
  );
}

/// Don't shoot the messenger!
/// Change Notifier that deals with all push notifications
/// and notifies the UI accordingly
class TkMessenger extends ChangeNotifier {
  static Mutex mutex = Mutex();

  // Model variables
  static List<TkNotification> _notifications = [];
  List<TkNotification> get notifications => _notifications;

  // Firebase messaging
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  /// [init]
  /// Initializes the permissions, listeners and interactive message
  Future<void> init() async {
    bool isAuthorized = true;
    if (Platform.isIOS) {
      // Request notifications permissions on ios
      final NotificationSettings settings =
          await _firebaseMessaging.requestPermission();
      isAuthorized =
          (settings.authorizationStatus == AuthorizationStatus.authorized);
    }

    // Check authorization result
    if (isAuthorized) {
      // set foreground notification presentation
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
              alert: true, badge: true, sound: true);

      if (Platform.isAndroid) {
        final AndroidNotificationChannel kChannel = AndroidNotificationChannel(
          'high_importance_channel', // id
          'High Importance Notifications', // title
          'This channel is used for important notifications.', // description
          importance: Importance.max,
        );

        // Create notification channel for Android
        await FlutterLocalNotificationsPlugin()
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.createNotificationChannel(kChannel);
      }

      // Initialize message handlers
      await firebaseCloudMessagingListeners();

      // Run code required to handle interacted messages
      await setupInteractedMessageAndInitialize();
    } else {
      await TkBadgeHelper.removeBadge();
    }
  }

  /// [setupInteractedMessageAndInitialize]
  /// Get any messages which caused the application to open from
  /// a terminated state.
  Future<void> setupInteractedMessageAndInitialize() async {
    RemoteMessage initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();

    if (initialMessage != null) {
      await addNotification(initialMessage);
    }

    FirebaseMessaging.onMessageOpenedApp
        .listen((message) async => await addNotification(message));

    // Read notifications from database
    await initNotifications();
  }

  /// [firebaseCloudMessagingListeners]
  /// Initializes the notifications events callbacks
  Future<void> firebaseCloudMessagingListeners() async {
    // background notifications handling
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // foreground notifications handling
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      await addNotification(message);

      if (Platform.isAndroid) {
        // If `onMessage` is triggered with a notification, construct our own
        // local notification to show to users using the created channel.
        if (message.notification != null &&
            message.notification?.android != null) {
          FlutterLocalNotificationsPlugin().show(
            message.notification.hashCode,
            message.notification.title,
            message.notification.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                'This channel is used for important notifications.', // description
                icon: message.notification.android.smallIcon,
              ),
            ),
          );
        }
      }
    });

    // Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    // fcmStream.listen((token) async {
    //   if (_user != null) {
    //     String fbToken = await _firebaseMessaging.getToken();
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

  /// [hasNewNotifications]
  /// Checks if any of the notifications was not seen
  bool get hasNewNotifications {
    TkNotification found = _notifications.firstWhere(
      (TkNotification n) => n.isSeen == false,
      orElse: () => null,
    );
    return found != null;
  }

  /// [sortNotifications]
  /// Sorts the notifications by date and time
  void sortNotifications() {
    if (_notifications.isNotEmpty && _notifications.length > 1) {
      // Sort the notifications by date
      _notifications.sort((a, b) => b.date.compareTo(a.date));
    }
  }

  /// [initNotifications]
  /// Initializes the notifications from the database
  Future<void> initNotifications() async {
    _notifications.clear();

    // Get the data from the database
    List<Map<String, dynamic>> messages = await TkDBHelper.readFromDatabase(
        kNtfTableName, kCreateNtfDBCmd, kSelectBtfDBCmd);

    // Iterate on each row and create a notification object
    for (Map<String, dynamic> message in messages) {
      Map<String, dynamic> js = json.decode(message[kNtfDataColumnName]);

      final TkNotification notification = TkNotification.fromJson(js);
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

    // Sort the notifications
    sortNotifications();

    // Notify listeners
    notifyListeners();

    // Update badge
    await TkBadgeHelper.updateBadge(notifications: _notifications);
  }

  /// [addNotification]
  /// Add a new notification to the model and database
  /// [message] a map containing the message details
  Future<void> addNotification(RemoteMessage message) async {
    await mutex.acquire();

    try {
      // Create notification object
      final TkNotification notification = TkNotification.fromJson(message.data,
          nid: message.notification.hashCode);

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
            json.encode(notification.toJson()));

        // Sort the notifications
        sortNotifications();

        // Notify listeners
        notifyListeners();

        // Update badge
        await TkBadgeHelper.updateBadge(notifications: _notifications);
      }
    } finally {
      mutex.release();
    }
  }

  /// [updateSeen]
  /// Toggle the isSeen flag of a specific notification
  /// Updates the model and database
  /// [notification] the notification to be updated
  /// [status] new is seen status boolean
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

    // Sort the notifications
    sortNotifications();

    // Notify listeners
    notifyListeners();

    if (Platform.isAndroid) {
      // Remove the notification
      if (notification.tag != null) {
        await FlutterLocalNotificationsPlugin()
            .cancel(0, tag: notification.tag);
      } else if (notification.nid != null) {
        await FlutterLocalNotificationsPlugin().cancel(notification.nid);
      } else {
        await FlutterLocalNotificationsPlugin().cancelAll();
      }
    }

    // Update badge
    await TkBadgeHelper.updateBadge(notifications: _notifications);
  }

  /// Show notification body
  Future<void> showBody(TkNotification notification, {bool value}) async {
    if (value != null)
      notification.showBody = value;
    else
      notification.showBody = !notification.showBody;
    notifyListeners();
  }

  Future<void> deleteNotification(TkNotification notification) async {
    // Remove old entry
    await TkDBHelper.deleteFromDatabase(
        kNtfTableName, kCreateNtfDBCmd, kDeleteNtfDBCmd, notification.id);
    _notifications.remove(notification);

    notifyListeners();
  }

  Future<void> clearNotifications() async {
    // Remove all notifications from database
    await TkDBHelper.deleteDatabase(
        kNtfTableName, kCreateNtfDBCmd, kDeleteAllNtfDBCmd);

    _notifications.clear();

    notifyListeners();

    if (Platform.isAndroid) {
      // Remove all notifications
      await FlutterLocalNotificationsPlugin().cancelAll();
    }

    // Update badge
    await TkBadgeHelper.removeBadge();
  }
}
