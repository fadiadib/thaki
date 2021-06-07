import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkPackage {
  static int colorIndex = 0;
  static Color getTileColor() {
    Color result = kTileColor[colorIndex];
    if (colorIndex < kTileColor.length - 1)
      colorIndex++;
    else
      colorIndex = 0;

    return result;
  }

  TkPackage.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kPackageIdTag].toString());
    points = json[kPackagePointsTag];
    remaining = json[kPackageRemainingTag];
    price = double.tryParse(json[kPackagePriceTag].toString());
    validity = json[kPackageValidityTag];
    details = json[kPackageDetailsTag];
    color = getTileColor();
  }

  TkPackage.fromUserPackageJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kPackageIdTag].toString());
    points = json[kUserPackagePoints];
    remaining = json[kPackageRemainingTag];
    startDate = json[kUserPackageStartDateTag];
    endDate = json[kUserPackageEndDateTag];
    color = getTileColor();
  }

  int id;
  int points;
  int remaining;
  double price;
  int validity; // in days
  String details;
  Color color;
  String startDate;
  String endDate;
}
