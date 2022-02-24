import 'package:flutter/material.dart';
import 'package:thaki/globals/colors.dart';

class TkProgressIndicator extends StatelessWidget {
  TkProgressIndicator(
      {this.strokeWidth = 4.0, this.size, this.color = kSecondaryColor});

  final double strokeWidth;
  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          color: color,
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
