import 'package:flutter/material.dart';

/// Base Colors
const Color kWhiteColor = Colors.white;
const Color kBlackColor = Colors.black;
const Color kTransparentColor = Colors.transparent;
const Color kLightGreyColor = Color(0xFFF7F9FC);
const Color kSemiGreyColor = Color(0x55444444);
const Color kMediumGreyColor = Color(0xFF71809C);
const Color kDarkGreyColor = Color(0xFF444444);
const Color kAccentGreyColor = Color(0xFFDCE0E7);
const Color kLightPurpleColor = Color(0xFFA530C7);
const Color kMediumPurpleColor = Color(0xFF5E2D9B);
const Color kDarkPurpleColor = Color(0xFF402F8B);
const Color kOrangeColor = Color(0xFFE77301);
const Color kCyanColor = Color(0xFF22D4D7);
const Color kGreenAccentColor = Colors.lightGreen;
const Color kRedAccentColor = Colors.redAccent;

/// Color scheme
const Color kPrimaryColor = kMediumPurpleColor;
const Color kSecondaryColor = kCyanColor;
const Color kTertiaryColor = kOrangeColor;

/// Named colors
const Color kPrimaryBgColor = kWhiteColor;
const Color kFormBgColor = kWhiteColor;
const Color kPrimaryIconColor = kDarkGreyColor;

/// Tiles colors
const Color kTileBgColor = kWhiteColor;
const List<Color> kTileColor = [
  kPrimaryColor,
  kLightPurpleColor,
  kSecondaryColor,
];

/// Text colors
const Color kLightTextColor = kLightGreyColor;
const Color kDarkTextColor = kDarkGreyColor;
const Color kPrimaryTextColor = kDarkTextColor;
const Color kDisabledTextColor = kSemiGreyColor;
const Color kHintTextColor = kMediumGreyColor;
const Color kErrorTextColor = kTertiaryColor;

/// Buttons
const Color kDefaultButtonBgColor = kPrimaryColor;
const Color kDefaultButtonTextColor = kWhiteColor;
const Color kDefaultButtonDisabledTextColor = kLightPurpleColor;

/// Gradients
// General white background color gradient
const LinearGradient kWhiteBgLinearGradient = LinearGradient(
  begin: Alignment(-1.0, -1.0),
  end: Alignment(1.0, 1.0),
  colors: [kWhiteColor, kLightGreyColor],
);

/// Shadows
const List<BoxShadow> kFormShadow = [
  BoxShadow(
    color: Color(0x18000000),
    offset: Offset(5.0, 15.0),
    blurRadius: 30.0,
  ),
];
const List<BoxShadow> kTileShadow = [
  BoxShadow(
    color: Color(0x22000000),
    offset: Offset(0.0, 2.0),
    blurRadius: 10.0,
  ),
];

/// Carousel Colors
const Color kCarouselSelectedDotColor = kWhiteColor;
const Color kCarouselUnselectedDotColor = kGreenAccentColor;
const Color kCarouselArrowColor = kWhiteColor;
const Color kCarouselArrowBgColor = kTransparentColor;

/// Card Colors
const Color kCardBgColor = kPrimaryColor;
const Color kCardBorderColor = kTransparentColor;
const Color kCardTextColor = kWhiteColor;
