import 'package:flutter/material.dart';

import 'colors.dart';

/// Special text styles (not included in the theme)
/// 1. Normal text styles
const TextStyle kBlackStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w900,
  fontSize: 16.0,
);
const TextStyle kNormalStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 16.0,
);
const TextStyle kBoldStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 16.0,
);
const TextStyle kSmallNormalStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 14.0,
);
const TextStyle kSmallBoldStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 14.0,
);
const TextStyle kVerySmallStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 10.0,
  fontWeight: FontWeight.w300,
);

/// 2. Titles styles
const TextStyle kBigTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 44.0,
);
const TextStyle kBigBoldTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 44.0,
  fontWeight: FontWeight.w400,
);
const TextStyle kMediumTitleStyle = TextStyle(
  fontSize: 30.0,
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
);
const TextStyle kMediumBoldTitleStyle = TextStyle(
  fontSize: 30.0,
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w700,
);
const TextStyle kPaneTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 24.0,
);
const TextStyle kPaneTitleBoldStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 24.0,
);
const TextStyle kNormalTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
  fontSize: 24.0,
);
const TextStyle kBoldTitleStyle = TextStyle(
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w700,
  fontSize: 24.0,
);
const TextStyle kPageTitleStyle = kBoldStyle;
const TextStyle kSubtitleStyle = TextStyle(
  fontSize: 18.0,
  color: kPrimaryTextColor,
  fontWeight: FontWeight.w400,
);

/// 3. Text edit styles
const TextStyle kHintStyle = TextStyle(
  color: kHintTextColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
const TextStyle kTextEditStyle = kNormalStyle;
const TextStyle kOTPEditStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 36.0,
  fontWeight: FontWeight.w700,
);
const TextStyle kDisabledTextEditStyle = TextStyle(
  color: kDisabledTextColor,
  fontSize: 16.0,
  fontWeight: FontWeight.w500,
);

/// 4. Specific styles
const TextStyle kDisclaimerStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w300,
);
const TextStyle kErrorStyle = TextStyle(
  color: kErrorTextColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
);
const TextStyle kLinkStyle = TextStyle(
  color: kPrimaryTextColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.underline,
);
const TextStyle kDisabledLinkStyle = TextStyle(
  color: kDisabledTextColor,
  fontSize: 14.0,
  fontWeight: FontWeight.w400,
  decoration: TextDecoration.underline,
);
const TextStyle kRibbonTextStyle = TextStyle(
  color: kWhiteColor,
  fontSize: 12.0,
  fontWeight: FontWeight.w700,
);
const TextStyle kEmphasisStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 16.0,
  fontWeight: FontWeight.w900,
);
const TextStyle kEmphasisTitleStyle = TextStyle(
  color: kPrimaryColor,
  fontSize: 24.0,
  fontWeight: FontWeight.w700,
);
const TextStyle kSuccessStyle = TextStyle(
  color: kGreenAccentColor,
  fontSize: 24.0,
  fontWeight: FontWeight.w700,
);

/// Styling theme for the application
final ThemeData gThemeData = ThemeData.light().copyWith(
  // Colors Themes
  primaryIconTheme: IconThemeData(color: kPrimaryIconColor),
  canvasColor: kTransparentColor,
  backgroundColor: kPrimaryBgColor,
  scaffoldBackgroundColor: kPrimaryBgColor,
  primaryColor: kPrimaryColor,
  accentColor: kPrimaryColor,
  textSelectionColor: kPrimaryColor,
  textSelectionHandleColor: kPrimaryColor,
);
