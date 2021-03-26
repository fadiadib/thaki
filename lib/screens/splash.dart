import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:connectivity/connectivity.dart';
import 'package:package_info/package_info.dart';

import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/server.dart';
import 'package:thaki/screens/home.dart';
import 'package:thaki/screens/onboarding.dart';

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
  double _logoRadius = 0;

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
      setState(() => _startupError = kConnectionError);
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
        setState(() => _startupError = kServerError);
        _loadingNextScreen = false;
      } else if (server.needUpgrade) {
        // Server is alive but needs the app to upgrade
        setState(() => _startupError = kVersionError);

        await TkDialogHelper.gShowUpgradeDialog(context: context);
        _loadingNextScreen = false;
      } else {
        setState(() => _startupError = null);

        // Check for logged session
        bool loggedIn = await account.isLoggedIn();

        if (loggedIn) {
          await Navigator.pushReplacementNamed(context, TkHomeScreen.id);
          _loadingNextScreen = false;
        } else {
          // No login session, display on-boarding
          await Navigator.pushReplacementNamed(context, TkOnBoardingScreen.id);
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
                textAlign: TextAlign.left,
                text: TextSpan(
                  text: _startupError,
                  style:
                      kBoldStyle[kSmallSize].copyWith(color: kLightPurpleColor),
                  children: [
                    TextSpan(
                      text: kTryAgain,
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
          x: -194,
          y: -327,
          tag: 'blue_ball',
          color: kCyanColor,
        ),

        // Purple Ball
        TkDrawHelper.drawBall(
            diameter: 783.0,
            x: -123,
            y: 704,
            tag: 'purple_ball',
            color: kLightPurpleColor),

        // Orange Ball 1
        TkDrawHelper.drawBall(
            diameter: 34.0, x: 268, y: 96, color: kOrangeColor),

        // Orange Ball 2
        TkDrawHelper.drawBall(
            diameter: 18.0, x: 56, y: 101, color: kOrangeColor),

        // Hollow Ball 1
        TkDrawHelper.drawBall(
            diameter: 316.0,
            x: 203,
            y: -186,
            color: kTransparentColor,
            borderColor: kBlackColor.withOpacity(0.3)),

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
              duration: Duration(milliseconds: 300),
              height: _logoRadius * 2,
              width: _logoRadius * 2,
              // curve: Curves.decelerate,
              decoration: BoxDecoration(
                color: kWhiteColor,
                borderRadius: BorderRadius.circular(_logoRadius),
                image: DecorationImage(
                  image: AssetImage(kLogoPath),
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
    await Future.delayed(Duration(microseconds: 100));
    setState(() {
      _logoRadius = 180;
    });
  }

  @override
  void initState() {
    super.initState();

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
