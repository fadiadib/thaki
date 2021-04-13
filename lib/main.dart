import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:thaki/app.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/providers/state_controller.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/server.dart';
import 'package:thaki/providers/tab_selector.dart';
import 'package:thaki/providers/versioner.dart';

void main() => runApp(ThankiMain());

class ThankiMain extends StatelessWidget {
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
        ChangeNotifierProvider<TkStateController>(
          create: (context) => new TkStateController(),
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
      ],

      // Create the material app
      child: TkThakiApp(),
    );
  }
}
