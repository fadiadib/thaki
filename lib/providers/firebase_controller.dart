import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class TkFirebaseController extends ChangeNotifier {
  Future<void> initializeFlutterFire() async {
    // Initialize local notifications
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    // initialise the plugin. app_icon needs to be a added as a drawable resource to the Android head project
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();
    final MacOSInitializationSettings initializationSettingsMacOS =
    MacOSInitializationSettings();
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS,
        macOS: initializationSettingsMacOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);

    // Initialize firebase app
    await Firebase.initializeApp();
  }
}
