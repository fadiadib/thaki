import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';

void main() => runApp(ThankiApp());

class ThankiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Restrict orientation for Android devices
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // TODO: Initialize Providers
    return MultiProvider(
      providers: [],

      // Create the material app
      child: MaterialApp(
        // Remove debug banner
        debugShowCheckedModeBanner: false,

        // Setup the application title
        title: kAppTitle,

        // Setup the application theme
        theme: gThemeData,

        // TODO: Application screen routes map
        routes: {},

        // TODO: Push the splash screen
        initialRoute: null,
      ),
    );
  }
}
