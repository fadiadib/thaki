import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/db_commands.dart';
import 'package:thaki/models/notification.dart';
import 'package:thaki/utilities/badge_helper.dart';
import 'package:thaki/utilities/db_helper.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/firebase_controller.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/providers/onboarding_controller.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/server.dart';
import 'package:thaki/providers/tab_selector.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/providers/user_attributes_controller.dart';
import 'package:thaki/providers/versioner.dart';
import 'package:thaki/app.dart';

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
  TkDBHelper.insertInDatabase(kNtfTableName, kCreateNtfDBCmd, kInsertNtfDBCmd,
      kSelectIdNtfDBCmd, notification.id, json.encode(message));
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize firebase
  await Firebase.initializeApp();

  // Setup background notifications for iOS
  if (Platform.isIOS)
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Fix for Android 12 web view
  if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

  runApp(ThakiMain());
}

/// Main application
class ThakiMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Restrict orientation for Android devices
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // Initialize Providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TkVersioner>(
          create: (context) => new TkVersioner(),
        ),
        ChangeNotifierProvider<TkLangController>(
          create: (context) => new TkLangController(),
        ),
        ChangeNotifierProvider<TkFirebaseController>(
          create: (context) => new TkFirebaseController(),
        ),
        ChangeNotifierProvider<TkAttributesController>(
          create: (context) => new TkAttributesController(),
        ),
        ChangeNotifierProvider<TkUserAttributesController>(
          create: (context) => new TkUserAttributesController(),
        ),
        ChangeNotifierProvider<TkOnBoardingController>(
          create: (context) => new TkOnBoardingController(),
        ),
        ChangeNotifierProvider<TkTabSelector>(
          create: (context) => new TkTabSelector(),
        ),
        ChangeNotifierProvider<TkAccount>(
          create: (context) => new TkAccount(),
        ),
        ChangeNotifierProvider<TkServer>(
          create: (context) => new TkServer(),
        ),
        ChangeNotifierProvider<TkMessenger>(
          create: (context) => new TkMessenger(),
        ),
        ChangeNotifierProvider<TkBooker>(
          create: (context) => new TkBooker(),
        ),
        ChangeNotifierProvider<TkPurchaser>(
          create: (context) => new TkPurchaser(),
        ),
        ChangeNotifierProvider<TkSubscriber>(
          create: (context) => new TkSubscriber(),
        ),
        ChangeNotifierProvider<TkPayer>(
          create: (context) => new TkPayer(),
        ),
        ChangeNotifierProvider<TkTransactor>(
          create: (context) => new TkTransactor(),
        ),
      ],

      // Create the material app
      child: TkThakiApp(),
    );
  }
}
