import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/firebase_controller.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/versioner.dart';
import 'package:thaki/screens/balance_screen.dart';
import 'package:thaki/screens/buy_subscription_screen.dart';

import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/notification_screen.dart';
import 'package:thaki/screens/onboarding_screen.dart';
import 'package:thaki/screens/otp_screen.dart';
import 'package:thaki/screens/pay_violation_screen.dart';
import 'package:thaki/screens/buy_package_screen.dart';
import 'package:thaki/screens/register_screen.dart';
import 'package:thaki/screens/apply_subscription_screen.dart';
import 'package:thaki/screens/splash_screen.dart';
import 'package:thaki/screens/subscription_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/screens/edit_profile_screen.dart';
import 'package:thaki/screens/forgot_password_screen.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/cars_list_screen.dart';
import 'package:thaki/screens/credit_cards_list_screen.dart';
import 'package:thaki/screens/book_parking_screen.dart';

class TkThakiApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<TkLangController>(
      builder: (context, controller, _) {
        // Initialize language
        if (controller.lang == null) controller.initLang();

        // Initialize version
        if (Provider.of<TkVersioner>(context, listen: false).version == null)
          Provider.of<TkVersioner>(context, listen: false).initVersion();

        // Initialize FlutterFire
        Provider.of<TkFirebaseController>(context, listen: false)
            .initializeFlutterFire();

        return MaterialApp(
          locale: controller.lang,
          localizationsDelegates: [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
            DefaultCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,

          // Remove debug banner
          debugShowCheckedModeBanner: false,

          // Setup the application title
          title: kAppTitle,

          // Setup the application theme
          theme: ThemeData(
            // Fonts
            fontFamily: controller.fontFamily,

            // Colors Themes
            primaryIconTheme: IconThemeData(color: kPrimaryIconColor),
            canvasColor: kTransparentColor,
            backgroundColor: kPrimaryBgColor,
            scaffoldBackgroundColor: kPrimaryBgColor,
            primaryColor: kPrimaryColor,
            accentColor: kSecondaryColor,
            textSelectionColor: kSecondaryColor,
            textSelectionHandleColor: kPrimaryColor,

            inputDecorationTheme: InputDecorationTheme(
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kAccentGreyColor),
                borderRadius: BorderRadius.circular(kDefaultTextEditRadius),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: kPrimaryColor),
                borderRadius: BorderRadius.circular(kDefaultTextEditRadius),
              ),
            ),
          ),

          // Application screen routes map
          routes: {
            TkSplashScreen.id: (context) => TkSplashScreen(),
            TkOnBoardingScreen.id: (context) => TkOnBoardingScreen(),
            TkWelcomeScreen.id: (context) => TkWelcomeScreen(),
            TkLoginScreen.id: (context) => TkLoginScreen(),
            TkRegisterScreen.id: (context) => TkRegisterScreen(),
            TkForgotPasswordScreen.id: (context) => TkForgotPasswordScreen(),
            TkOTPScreen.id: (context) => TkOTPScreen(),
            TkHomeScreen.id: (context) => TkHomeScreen(),
            TkEditProfileScreen.id: (context) => TkEditProfileScreen(),
            TkAddCardScreen.id: (context) => TkAddCardScreen(),
            TkCreditCardsListScreen.id: (context) => TkCreditCardsListScreen(),
            TkAddCarScreen.id: (context) => TkAddCarScreen(),
            TkCarsListScreen.id: (context) => TkCarsListScreen(),
            TkBuyPackageScreen.id: (context) => TkBuyPackageScreen(),
            TkApplyForSubscriptionScreen.id: (context) =>
                TkApplyForSubscriptionScreen(),
            TkBuySubscriptionScreen.id: (context) => TkBuySubscriptionScreen(),
            TkPayViolationScreen.id: (context) => TkPayViolationScreen(),
            TkBookParkingScreen.id: (context) => TkBookParkingScreen(),
            TkSubscriptionScreen.id: (context) => TkSubscriptionScreen(),
            TkNotificationScreen.id: (context) => TkNotificationScreen(),
            TkBalanceScreen.id: (context) => TkBalanceScreen(),
          },

          // Push the splash screen
          initialRoute: TkSplashScreen.id,
        );
      },
    );
  }
}
