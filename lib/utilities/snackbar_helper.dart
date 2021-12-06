import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';

class TkSnackBarHelper {
  static void show(
      GlobalKey<ScaffoldState>? scaffoldKey, BuildContext context, message) {
    if (scaffoldKey == null) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(fontFamily: kRTLFontFamily, fontSize: 14),
          ),
        ),
        backgroundColor: kGreenAccentColor,
      ),
    );

    // scaffoldKey.currentState!.showSnackBar(
    //   SnackBar(
    //     content: Padding(
    //       padding: const EdgeInsets.all(8.0),
    //       child: Text(
    //         message,
    //         textAlign: TextAlign.center,
    //         style: TextStyle(fontFamily: kRTLFontFamily, fontSize: 14),
    //       ),
    //     ),
    //     backgroundColor: kGreenAccentColor,
    //   ),
    // );
  }
}
