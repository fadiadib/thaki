import 'package:flutter/material.dart';

import 'colors.dart';

/// Styling theme for the application
final ThemeData gThemeData = ThemeData.light().copyWith(
  // Colors Themes
  primaryIconTheme: IconThemeData(color: kPrimaryIconColor),
  canvasColor: kTransparentColor,
  backgroundColor: kBgColor,
  scaffoldBackgroundColor: kBgColor,
  primaryColor: kPrimaryColor,
  accentColor: kPrimaryColor,
  textSelectionColor: kPrimaryColor,
  textSelectionHandleColor: kPrimaryColor,
);
