import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/providers/server.dart';

import 'package:thaki/screens/home.dart';
import 'package:thaki/screens/login.dart';
import 'package:thaki/screens/onboarding.dart';
import 'package:thaki/screens/register.dart';
import 'package:thaki/screens/splash.dart';
import 'package:thaki/screens/welcome.dart';
import 'package:thaki/screens/add_card.dart';
import 'package:thaki/screens/edit_profile.dart';
import 'package:thaki/screens/forgot_password.dart';

void main() => runApp(ThankiApp());

class ThankiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Restrict orientation for Android devices
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

    // TODO: Initialize Providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TkAccount>(
          create: (context) => new TkAccount(),
        ),
        ChangeNotifierProvider<TkServer>(
          create: (context) => new TkServer(),
        ),
        ChangeNotifierProvider<TkMessenger>(
          create: (context) => new TkMessenger(),
        ),
      ],

      // Create the material app
      child: MaterialApp(
        // Remove debug banner
        debugShowCheckedModeBanner: false,

        // Setup the application title
        title: kAppTitle,

        // Setup the application theme
        theme: gThemeData,

        // Application screen routes map
        routes: {
          TkSplashScreen.id: (context) => TkSplashScreen(),
          TkOnBoardingScreen.id: (context) => TkOnBoardingScreen(),
          TkWelcomeScreen.id: (context) => TkWelcomeScreen(),
          TkLoginScreen.id: (context) => TkLoginScreen(),
          TkRegisterScreen.id: (context) => TkRegisterScreen(),
          TkForgotPasswordScreen.id: (context) => TkForgotPasswordScreen(),
          TkHomeScreen.id: (context) => TkHomeScreen(),
          TkEditProfileScreen.id: (context) => TkEditProfileScreen(),
          TkAddCardScreen.id: (context) => TkAddCardScreen(),
        },

        // Push the splash screen
        initialRoute: TkSplashScreen.id,
      ),
    );
  }
}
