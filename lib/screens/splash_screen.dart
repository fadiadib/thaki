import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info/package_info.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/onboarding_controller.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/server.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/onboarding_screen.dart';

class TkSplashScreen extends StatefulWidget {
  static const String id = 'splash_screen';

  @override
  _TkSplashScreenState createState() => _TkSplashScreenState();
}

/// The splash screen is displayed for a few seconds, then a new
/// screen is pushed. If the user has an active session (stored in
/// the shard preferences) then the profile page is pushed into
/// context otherwise the on-boarding screen is pushed instead.
class _TkSplashScreenState extends State<TkSplashScreen> {
  // This variables makes sure that while loading the next screen
  // whether its the on-boarding screen or the profile, that there
  // aren't any intermittent calls to the same function, which might
  // cause the same screen to be pushed to the navigator multiple
  // times
  bool _loadingNextScreen = false;
  String _startupError;

  // Animations controllers
  double _logoRadius = 0;
  List<double> _blueBallCoords = [-412, -390];
  List<double> _purpleBallCoords = [138, 900];

  /// Called on initState, so it is the first function to be called in
  /// the application. It checks if the user has an active session and
  /// therefore loads the home page or loads the on boarding page and
  /// welcome page to allow the user to login.
  /// This function checks the connectivity of the device first, if no
  /// connection, then it halts operation.
  Future _loadNextScreen({int delay = kSplashDelay}) async {
    // Avoid multiple calls
    if (_loadingNextScreen) return;
    _loadingNextScreen = true;

    // Wait for kSplashDelay seconds
    await Future.delayed(Duration(seconds: delay));

    // Check internet connection
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      // No Internet connectivity
      setState(() => _startupError = S.of(context).kConnectionError);
      _loadingNextScreen = false;
    } else {
      // Get the providers
      TkServer server = Provider.of<TkServer>(context, listen: false);
      TkAccount account = Provider.of<TkAccount>(context, listen: false);

      // Get the device info
      PackageInfo packageInfo = await PackageInfo.fromPlatform();

      // Check server is alive
      if (!await server.check(
        packageInfo.version,
        Platform.operatingSystem,
      )) {
        // Server is not alive
        setState(() => _startupError = S.of(context).kServerError);

        _loadingNextScreen = false;
      } else if (server.needUpgrade) {
        // Server is alive but needs the app to upgrade
        setState(() => _startupError = S.of(context).kVersionError);

        await TkDialogHelper.gShowUpgradeDialog(context: context);
        _loadingNextScreen = false;
      } else {
        setState(() => _startupError = null);

        // Check for logged session
        bool loggedIn = await account.isLoggedIn();

        if (loggedIn && await account.load()) {
          await Navigator.pushReplacementNamed(context, TkHomeScreen.id);
          _loadingNextScreen = false;
        } else {
          TkOnBoardingController onBoardingController =
              Provider.of<TkOnBoardingController>(context, listen: false);
          await onBoardingController
              .load(Provider.of<TkLangController>(context, listen: false));

          if (onBoardingController.onBoardingList.isEmpty) {
            // No login session, display on-boarding
            await Navigator.pushReplacementNamed(context, TkWelcomeScreen.id);
          } else {
            // No login session, display on-boarding
            await Navigator.pushReplacementNamed(
                context, TkOnBoardingScreen.id);
          }
          _loadingNextScreen = false;
        }
      }
    }
  }

  /// Method that creates a clickable error message saying that
  /// the device has no Internet connection and allows the user
  /// to click to reload
  Widget _getErrorWidget() {
    return Positioned(
      width: MediaQuery.of(context).size.width,
      bottom: 30,
      child: GestureDetector(
        // On tap, try again to load next screen
        onTap: () {
          setState(() => _startupError = null);

          _loadNextScreen(delay: 1);
        },

        // Container with top shadow
        child: Container(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          color: kBlackColor,

          // Row showing the error icon message
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              // Show error icon
              Icon(
                kWarningBtnIcon,
                color: kLightPurpleColor,
                size: 30.0,
              ),
              SizedBox(width: 10.0),

              // Show error message
              RichText(
                textAlign: TextAlign.start,
                text: TextSpan(
                  text: _startupError,
                  style: kBoldStyle[kSmallSize].copyWith(
                      color: kLightPurpleColor, fontFamily: kRTLFontFamily),
                  children: [
                    TextSpan(
                      text: S.of(context).kTryAgain,
                      style: kLinkStyle.copyWith(color: kWhiteColor),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _drawStack() {
    return Stack(
      children: [
        // Blue ball
        TkDrawHelper.drawBall(
          diameter: 473.0,
          x: _blueBallCoords[0],
          y: _blueBallCoords[1],
          tag: 'blue_ball',
          color: kCyanColor.withOpacity(kBallsTransparency),
        ),

        // Purple Ball
        TkDrawHelper.drawBall(
          diameter: 783.0,
          x: _purpleBallCoords[0],
          y: _purpleBallCoords[1],
          tag: 'purple_ball',
          color: kLightPurpleColor.withOpacity(kBallsTransparency),
        ),

        // Orange Ball 1
        TweenAnimationBuilder(
          curve: Curves.easeIn,
          tween: Tween<double>(begin: 1, end: 0),
          duration: Duration(milliseconds: 600),
          builder: (context, angle, child) {
            return Transform.rotate(
              origin: Offset(268 + 203.0, -600),
              angle: angle,
              child: child,
            );
          },
          child: Stack(children: [
            TkDrawHelper.drawBall(
                diameter: 34.0, x: 268, y: 96, color: kOrangeColor),
          ]),
        ),

        // Hollow Ball 1
        TkDrawHelper.drawBall(
            diameter: 316.0,
            x: 203,
            y: -186,
            color: kTransparentColor,
            borderColor: kBlackColor.withOpacity(0.3)),

        // Orange Ball 2
        TweenAnimationBuilder(
          curve: Curves.easeIn,
          tween: Tween<double>(begin: 1, end: 0),
          duration: Duration(milliseconds: 600),
          builder: (context, angle, child) {
            return Transform.rotate(
              origin: Offset(-50, 300),
              angle: angle,
              child: child,
            );
          },
          child: Stack(children: [
            TkDrawHelper.drawBall(
                diameter: 18.0, x: 56, y: 101, color: kOrangeColor),
          ]),
        ),

        // Hollow Ball 2
        TkDrawHelper.drawBall(
            diameter: 316.0,
            x: -84,
            y: 111,
            color: kTransparentColor,
            borderColor: kBlackColor.withOpacity(0.3)),

        // Logo Ball
        Align(
          alignment: Alignment.center,
          child: Hero(
            tag: 'logo',
            child: AnimatedContainer(
              duration: Duration(milliseconds: 900),
              height: _logoRadius * 2,
              width: _logoRadius * 2,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(_logoRadius),
                image: DecorationImage(
                  image: AssetImage(kSloganPath),
                  fit: BoxFit.scaleDown,
                ),
              ),
            ),
          ),
        ),

        // Splash screen title message (show according to const settings)
        _startupError != null ? _getErrorWidget() : Container()
      ],
    );
  }

  Future<void> _updateGraphics() async {
    await Future.delayed(Duration(milliseconds: 600));
    setState(() {
      _logoRadius = 180;
      _blueBallCoords = [-194, -327];
      _purpleBallCoords = [-123, 704];
    });
  }

  @override
  void initState() {
    super.initState();

    // TODO: enable messenger to receive notifications
    // TkMessenger messenger = Provider.of<TkMessenger>(context, listen: false);

    // Update the logo radius
    _updateGraphics();

    // Check user model and load home page in case there is an
    // active session or the on boarding screen in case there
    // is no active session
    _loadNextScreen();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TkScaffoldBody(
        image: AssetImage(kSplashBg),
        colorOverlay: kPrimaryColor,
        enableSafeArea: false,
        child: _drawStack(),
      ),
    );
  }
}
