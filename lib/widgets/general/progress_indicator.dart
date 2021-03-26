import 'package:flutter/material.dart';

class TkProgressIndicator extends StatelessWidget {
  TkProgressIndicator({this.strokeWidth = 4.0, this.size});

  final double strokeWidth;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        height: size,
        width: size,
        child: CircularProgressIndicator(
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}
