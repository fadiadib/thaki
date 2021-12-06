import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkDrawHelper {
  static Widget drawBall({
    required double diameter,
    double? x,
    double? y,
    String? tag,
    Color? color,
    Color? borderColor,
    Widget? child,
  }) {
    Widget ball = AnimatedContainer(
      duration: Duration(milliseconds: 900),
      curve: Curves.easeOut,
      height: diameter,
      width: diameter,
      decoration: BoxDecoration(
        border: Border.all(color: borderColor ?? kTransparentColor, width: 1),
        color: color,
        borderRadius: BorderRadius.circular(diameter / 2.0),
      ),
    );

    return AnimatedPositioned(
      duration: Duration(milliseconds: 900),
      curve: Curves.easeOut,
      top: y,
      left: x,
      child: tag == null ? ball : Hero(tag: tag, child: ball),
    );
  }
}
