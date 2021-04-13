import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkError extends StatelessWidget {
  TkError({this.message});
  final String message;

  @override
  Widget build(BuildContext context) {
    return message != null
        ? Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 10.0),
                decoration: BoxDecoration(
                  color: kTileBgColor,
                  boxShadow: kTileShadow,
                  borderRadius: BorderRadius.circular(4.0),
                ),
                child: Text(
                  message.isEmpty ? kUnknownError : message,
                  style: kErrorStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          )
        : Container();
  }
}
