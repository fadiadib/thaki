import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/globals/strings.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/register_screen.dart';

class TkWelcomeScreen extends StatefulWidget {
  static const String id = 'welcome_screen';

  @override
  _TkWelcomeScreenState createState() => _TkWelcomeScreenState();
}

class _TkWelcomeScreenState extends State<TkWelcomeScreen> {
  Widget _drawStack() {
    return Stack(
      children: [
        // Blue ball
        TkDrawHelper.drawBall(
          diameter: 519.0,
          x: -55,
          y: -273,
          tag: 'blue_ball',
          color: kWhiteColor,
        ),

        // Purple Ball
        TkDrawHelper.drawBall(
            diameter: 783.0,
            x: -217,
            y: 684,
            tag: 'purple_ball',
            color: kLightPurpleColor),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Hero(tag: 'logo', child: Image.asset(kLogoPath)),
          ),
        ),

        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Hero(
                    tag: kSignUpTag,
                    child: TkButton(
                      title: kSignUp,
                      btnColor: kWhiteColor,
                      titleColor: kLightPurpleColor,
                      btnWidth: 140.0,
                      onPressed: () =>
                          Navigator.pushNamed(context, TkRegisterScreen.id),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Hero(
                    tag: kLoginTag,
                    child: TkButton(
                      title: kLogin,
                      btnColor: kTransparentColor,
                      btnBorderColor: kWhiteColor,
                      btnWidth: 140.0,
                      onPressed: () =>
                          Navigator.pushNamed(context, TkLoginScreen.id),
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TkScaffoldBody(
        image: AssetImage(kOBBg),
        colorOverlay: kPrimaryColor,
        overlayOpacity: 0.5,
        enableSafeArea: false,
        child: _drawStack(),
      ),
    );
  }
}
