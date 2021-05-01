import 'dart:math';
import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

enum TkCardRibbonSide { right, left }

/// Shows a colored ribbon on either side of a card
/// Must be a child of a Stack widget
class TkCardRibbon extends StatelessWidget {
  TkCardRibbon({
    this.title,
    this.color,
    this.side = TkCardRibbonSide.right,
    this.height = 20.0,
    this.width = 100.0,
  });

  final Color color;
  final String title;
  final TkCardRibbonSide side;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: side == TkCardRibbonSide.right ? -36 : null,
      left: side == TkCardRibbonSide.left ? -36 : null,
      top: -4,

      // Rotate the ribbon 45 or -45 degrees according
      // to on which side it is shown
      child: Transform.rotate(
        angle: side == TkCardRibbonSide.right ? pi / 4 : -pi / 4,
        child: ClipPath(
          // Create the trapezoidal clipper
          clipper: RibbonClipper(),

          // Insert a colored container with the text
          child: Container(
            height: height,
            width: width,
            color: color,
            child: Center(
              child: Text(
                title.toUpperCase(),
                style: kBoldStyle[kSmallSize]
                    .copyWith(color: kWhiteColor, fontSize: 8.0),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

/// Trapezoidal clipping mask
class RibbonClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, 0.0);
    path.lineTo(size.width - 20, 0.0);
    path.lineTo(size.width, size.height);
    path.lineTo(0.0, size.height);
    path.lineTo(20, 0.0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class TkMarker extends StatelessWidget {
  TkMarker({
    this.title,
    this.color,
    this.side = TkCardRibbonSide.right,
  });

  final Color color;
  final String title;
  final TkCardRibbonSide side;

  @override
  Widget build(BuildContext context) {
    return Positioned(
      right: side == TkCardRibbonSide.right ? -5 : null,
      left: side == TkCardRibbonSide.left ? -5 : null,
      top: 10,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Text(
          title.toUpperCase(),
          style:
              kBoldStyle[kSmallSize].copyWith(color: kWhiteColor, fontSize: 10),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
