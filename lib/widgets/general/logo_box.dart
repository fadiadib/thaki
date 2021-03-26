import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkLogoBox extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'logo',
      child: Image(width: 200, image: AssetImage(kLogoPath)),
    );
  }
}
