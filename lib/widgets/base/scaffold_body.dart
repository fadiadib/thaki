import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';

class TkScaffoldBody extends StatelessWidget {
  TkScaffoldBody({
    @required this.child,
    this.image,
    this.colorOverlay,
    this.overlayOpacity = 0.83,
    this.enableSafeArea = true,
    this.color,
    this.enableGradient = true,
  });

  final Widget child;
  final ImageProvider image;
  final Color colorOverlay;
  final double overlayOpacity;
  final bool enableSafeArea;
  final Color color;
  final bool enableGradient;

  @override
  Widget build(BuildContext context) {
    // Just a container with the scaffold bg design according to settings
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        decoration: BoxDecoration(
          color: color,
          gradient: enableGradient ? kWhiteBgLinearGradient : null,
          image: image == null
              ? null
              : DecorationImage(image: image, fit: BoxFit.cover),
        ),

        // Encapsulate the child widget into a safe area
        child: Container(
          color: colorOverlay?.withOpacity(overlayOpacity),
          child: enableSafeArea ? SafeArea(child: child) : child,
        ),
      ),
    );
  }
}
