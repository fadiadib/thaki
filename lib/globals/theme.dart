import 'package:flutter/material.dart';

import 'index.dart';

/// Font family
const String kMainFontFamily = 'BwModelica';

/// Special text styles (not included in the theme)
/// 1. Normal text styles
const kSmallSize = 14.0;
const kNormalSize = 16.0;
const kBigSize = 24.0;

Map<double, TextStyle> kHairlineStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w100,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w100,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w100,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kThinStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w200,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w200,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w200,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kLightStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w300,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w300,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w300,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kRegularStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w400,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kMediumStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w500,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kBoldStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w600,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kVeryBoldStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w700,
    fontSize: kBigSize,
  ),
};

Map<double, TextStyle> kBlackStyle = {
  kSmallSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w800,
    fontSize: kSmallSize,
  ),
  kNormalSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w800,
    fontSize: kNormalSize,
  ),
  kBigSize: TextStyle(
    color: kPrimaryTextColor,
    fontWeight: FontWeight.w800,
    fontSize: kBigSize,
  ),
};

/// 4. Specific styles
TextStyle kHintStyle =
    kRegularStyle[kSmallSize].copyWith(color: kHintTextColor);
TextStyle kTextEditStyle = kRegularStyle[kNormalSize];
TextStyle kOTPEditStyle = kBoldStyle[kNormalSize];
TextStyle kDisabledTextEditStyle =
    kMediumStyle[kNormalSize].copyWith(color: kDisabledTextColor);
TextStyle kDisclaimerStyle = kLightStyle[kSmallSize];
TextStyle kErrorStyle =
    kMediumStyle[kSmallSize].copyWith(color: kErrorTextColor);
TextStyle kSuccessStyle =
    kRegularStyle[kNormalSize].copyWith(color: kGreenAccentColor);
TextStyle kLinkStyle =
    kRegularStyle[kSmallSize].copyWith(decoration: TextDecoration.underline);
TextStyle kDisabledLinkStyle = kLinkStyle.copyWith(color: kDisabledTextColor);
TextStyle kRibbonTextStyle =
    kVeryBoldStyle[kSmallSize].copyWith(color: kWhiteColor);
TextStyle kEmphasisStyle = kBlackStyle[kNormalSize];
TextStyle kPageTitleStyle = kBoldStyle[kBigSize];

/// Styling theme for the application
final ThemeData gThemeData = ThemeData(
  // Fonts
  fontFamily: kMainFontFamily,

  // Colors Themes
  primaryIconTheme: IconThemeData(color: kPrimaryIconColor),
  canvasColor: kTransparentColor,
  backgroundColor: kPrimaryBgColor,
  scaffoldBackgroundColor: kPrimaryBgColor,
  primaryColor: kPrimaryColor,
  accentColor: kSecondaryColor,
  textSelectionColor: kSecondaryColor,
  textSelectionHandleColor: kPrimaryColor,

  inputDecorationTheme: InputDecorationTheme(
    enabledBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kAccentGreyColor),
      borderRadius: BorderRadius.circular(kDefaultTextEditRadius),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: kPrimaryColor),
      borderRadius: BorderRadius.circular(kDefaultTextEditRadius),
    ),
  ),
);
