import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';

class TkScaffoldBody extends StatelessWidget {
  TkScaffoldBody({@required this.child, this.image});

  final Widget child;
  final ImageProvider image;

  @override
  Widget build(BuildContext context) {
    // Just a container with the scaffold bg design according to settings
    return GestureDetector(
      onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
      child: Container(
        decoration: BoxDecoration(
          gradient: kBgLinearGradient,
          image: image == null
              ? null
              : DecorationImage(image: image, fit: BoxFit.cover),
        ),

        // Encapsulate the child widget into a safe area
        child: SafeArea(child: child),
      ),
    );
  }
}
