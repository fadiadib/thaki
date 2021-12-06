import 'dart:convert';
import 'dart:io';

import 'package:collection/collection.dart' show IterableExtension;
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
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
  // TurniBadgeHelper.incrementBadge();

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
      json.encode(message));
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

  // /// Class constructor
  // TkMessenger() {
  //   // Request notifications permissions on ios
  //   if (Platform.isIOS) _firebaseMessaging.requestNotificationPermissions();
  //
  //   // Initialize message handlers
  //   firebaseCloudMessagingListeners();
  //
  //   // Read notifications from database
  //   initNotifications();
  // }

  /// Initializes the notifications events callbacks
  // void firebaseCloudMessagingListeners() {
  //   _firebaseMessaging.configure(
  //     // Foreground notification
  //     onMessage: (Map<String, dynamic> message) async {
  //       if (kVerboseNetworkMessages) print("onMessage: $message");
  //       addNotification(message);
  //     },
  //
  //     // App comes to the foreground
  //     onLaunch: (Map<String, dynamic> message) async {
  //       if (kVerboseNetworkMessages) print("onLaunch: $message");
  //       addNotification(message);
  //     },
  //
  //     // App starts
  //     onResume: (Map<String, dynamic> message) async {
  //       if (kVerboseNetworkMessages) print("onResume: $message");
  //       addNotification(message);
  //     },
  //   );
  //
  //   // Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
  //   // fcmStream.listen((token) async {
  //   //   if (_user != null) {
  //   //     String fbToken = await FirebaseMessaging().getToken();
  //   //     if (fbToken != null) {
  //   //       if (await _user.updateFbToken(fbToken)) {
  //   //         // Save the new firebase token in the preferences
  //   //         SharedPreferences prefs = await SharedPreferences.getInstance();
  //   //         prefs.setString(kFbTokenTag, token);
  //   //       }
  //   //     }
  //   //   }
  //   // });
  // }

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
          description: 'This channel is used for important notifications.', // description
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
      // await TurniBadgeHelper.removeBadge();
    }
  }

  /// [setupInteractedMessageAndInitialize]
  /// Get any messages which caused the application to open from
  /// a terminated state.
  Future<void> setupInteractedMessageAndInitialize() async {
    RemoteMessage? initialMessage =
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
            message.notification!.title,
            message.notification!.body,
            NotificationDetails(
              android: AndroidNotificationDetails(
                'high_importance_channel', // id
                'High Importance Notifications', // title
                channelDescription: 'This channel is used for important notifications.', // description
                icon: message.notification!.android!.smallIcon,
              ),
            ),
          );
        }
      }
    });

    // Stream<String> fcmStream = _firebaseMessaging.onTokenRefresh;
    // fcmStream.listen((token) async {
    //   await LoginRepo().setFbToken(UserModel.getInstance());
    // });
  }

  /// [hasNewNotifications]
  /// Checks if any of the notifications was not seen
  bool get hasNewNotifications {
    TkNotification? found = _notifications.firstWhereOrNull(
      (TkNotification n) => n.isSeen == false,
    );
    return found != null;
  }

  /// Initializes the notifications from the database
  Future<void> initNotifications() async {
    // Get the data from the database
    List<Map<String, dynamic>> messages = await TkDBHelper.readFromDatabase(
        kNtfTableName, kCreateNtfDBCmd, kSelectBtfDBCmd);

    // Iterate on each row and create a notification object
    for (Map<String, dynamic> message in messages.reversed) {
      Map<String, dynamic> js = json.decode(message[kNtfDataColumnName]);

      TkNotification notification = TkNotification.fromJson(js);
      if (notification.expiry != null &&
          notification.expiry!.isBefore(DateTime.now())) {
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
  Future<void> addNotification(RemoteMessage message) async {
    await mutex.acquire();

    try {
      TkNotification notification = TkNotification.fromJson(message.data);

      // Look for a notification with the same id
      TkNotification? found = _notifications.firstWhereOrNull(
          (TkNotification n) => n.id == notification.id);
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

    if (Platform.isAndroid) {
      // Remove the notification
      if (notification.tag != null) {
        await FlutterLocalNotificationsPlugin()
            .cancel(0, tag: notification.tag);
      } else if (notification.nid != null) {
        await FlutterLocalNotificationsPlugin().cancel(notification.nid!);
      } else {
        await FlutterLocalNotificationsPlugin().cancelAll();
      }
    }

  }

  /// Show notification body
  Future<void> showBody(TkNotification notification, {bool? value}) async {
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
  }
}
