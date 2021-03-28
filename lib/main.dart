import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/server.dart';

import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/onboarding_screen.dart';
import 'package:thaki/screens/purchase_package_screen.dart';
import 'package:thaki/screens/register_screen.dart';
import 'package:thaki/screens/splash_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/screens/edit_profile_screen.dart';
import 'package:thaki/screens/forgot_password_screen.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/cars_list_screen.dart';
import 'package:thaki/screens/credit_cards_list_screen.dart';

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
        ChangeNotifierProvider<TkBooker>(
          create: (context) => new TkBooker(),
        ),
        ChangeNotifierProvider<TkPurchaser>(
          create: (context) => new TkPurchaser(),
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
          TkCreditCardsListScreen.id: (context) => TkCreditCardsListScreen(),
          TkAddCarScreen.id: (context) => TkAddCarScreen(),
          TkCarsListScreen.id: (context) => TkCarsListScreen(),
          TkPurchasePackageScreen.id: (context) => TkPurchasePackageScreen(),
        },

        // Push the splash screen
        initialRoute: TkSplashScreen.id,
      ),
    );
  }
}
