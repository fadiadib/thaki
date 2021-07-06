import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/lang_controller.dart';
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
          color: kLightPurpleColor.withOpacity(kBallsTransparency),
        ),

        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.only(top: 50.0),
            child: Hero(
                tag: 'logo',
                child: Image.asset(
                  kLogoPath,
                  height: 140,
                )),
          ),
        ),

        Align(
          child: Padding(
            padding: const EdgeInsets.only(top: 200.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        tag: kSignUpTag,
                        child: TkButton(
                          title: S.of(context).kSignUp,
                          btnColor: kWhiteColor,
                          titleColor: kLightPurpleColor,
                          btnWidth: 140.0,
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, TkRegisterScreen.id),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Hero(
                        tag: kLoginTag,
                        child: TkButton(
                          title: S.of(context).kLogin,
                          btnColor: kTransparentColor,
                          btnBorderColor: kWhiteColor,
                          btnWidth: 140.0,
                          onPressed: () => Navigator.pushReplacementNamed(
                              context, TkLoginScreen.id),
                        ),
                      ),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () {
                    Provider.of<TkLangController>(context, listen: false)
                        .switchLang();
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: Text(
                      S.of(context).kSwitchLanguage,
                      style: kBoldStyle[kSmallSize].copyWith(
                        color: kWhiteColor,
                        decoration: TextDecoration.underline,
                        fontFamily: Provider.of<TkLangController>(context,
                                        listen: false)
                                    .lang
                                    .languageCode ==
                                'ar'
                            ? kLTRFontFamily
                            : kRTLFontFamily,
                      ),
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
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: TkScaffoldBody(
          image: AssetImage(kOBBg),
          colorOverlay: kPrimaryColor,
          overlayOpacity: 0.5,
          enableSafeArea: false,
          child: _drawStack(),
        ),
      ),
    );
  }
}
