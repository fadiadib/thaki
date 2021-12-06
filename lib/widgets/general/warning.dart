import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkWarning extends StatelessWidget {
  TkWarning({required this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: kRedAccentColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(4.0),
      ),
      margin: EdgeInsetsDirectional.fromSTEB(30, 20, 30, 0),
      padding: EdgeInsets.all(10),
      child: Text(
        message,
        style: kBoldStyle[kSmallSize]!.copyWith(color: kRedAccentColor),
      ),
    );
  }
}
