import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/scaffold_body.dart';

class TkOnBoardingScreen extends StatefulWidget {
  static const String id = 'on_boarding_screen';

  @override
  _TkOnBoardingScreenState createState() => _TkOnBoardingScreenState();
}

const List<double> kCyanBallLocations = [-123, -352, -87, -299, -49, -273];
const List<double> kMagentaBallLocations = [-157, 694, -152, 674, -184, 684];

class _TkOnBoardingScreenState extends State<TkOnBoardingScreen> {
  int _current = 0;
  int _count = 3;

  /// Create circular navigation indicators
  List<Widget> _drawDots() {
    // Returns a list of circular indicators, one for each slide
    List<Widget> indicators = [];

    // Create a dot for each slide
    for (int slide = 0; slide < _count; slide++) {
      indicators.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: GestureDetector(
            onTap: () => setState(() => _current = slide),
            child: Container(
              height: 4,
              width: _current == slide ? 18 : 4,
              decoration: BoxDecoration(
                color: _current == slide
                    ? kCarouselSelectedDotColor
                    : kCarouselUnselectedDotColor,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
        ),
      );
    }

    return indicators;
  }

  void _updateCurrent() {
    if (_current < _count - 1)
      setState(() => _current++);
    else
      Navigator.pushReplacementNamed(context, TkWelcomeScreen.id);
  }

  Widget _drawStack(int index) {
    return GestureDetector(
      onTap: _updateCurrent,
      child: Stack(
        children: [
          Positioned.fill(child: Container(color: kTransparentColor)),

          // Blue ball
          TkDrawHelper.drawBall(
              diameter: 473.0,
              x: kCyanBallLocations[index * 2],
              y: kCyanBallLocations[index * 2 + 1],
              tag: 'blue_ball',
              color: kCyanColor),

          // Purple Ball
          TkDrawHelper.drawBall(
              diameter: 783.0,
              x: kMagentaBallLocations[index * 2],
              y: kMagentaBallLocations[index * 2 + 1],
              tag: 'purple_ball',
              color: kLightPurpleColor),

          Align(
              alignment: Alignment.center,
              child: Container(
                width: 300,
                child: Text(
                  _current == 0
                      ? S.of(context).kOnBoardingMessage1
                      : _current == 1
                          ? S.of(context).kOnBoardingMessage2
                          : S.of(context).kOnBoardingMessage3,
                  style: kBoldStyle[kBigSize].copyWith(
                    color: kWhiteColor,
                    fontFamily: kRTLFontFamily,
                  ),
                  textAlign: TextAlign.center,
                ),
              )),

          Align(
            alignment: Alignment.bottomCenter,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _drawDots()),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomLeft,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
                child: GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, TkWelcomeScreen.id),
                  child: Text(
                    S.of(context).kSkip,
                    style:
                        kRegularStyle[kSmallSize].copyWith(color: kWhiteColor),
                  ),
                ),
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomRight,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.only(right: 20.0, bottom: 10.0),
                child: GestureDetector(
                  onTap: _updateCurrent,
                  child: Text(
                    S.of(context).kNext,
                    style:
                        kRegularStyle[kSmallSize].copyWith(color: kWhiteColor),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
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
        child: _drawStack(_current),
      ),
    );
  }
}
