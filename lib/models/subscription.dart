import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkSubscription {
  static int colorIndex = 0;
  static Color getTileColor() {
    Color result = kTileColor[colorIndex];
    if (colorIndex < kTileColor.length - 1)
      colorIndex++;
    else
      colorIndex = 0;

    return result;
  }

  TkSubscription.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kSubscriptionIdTag].toString());
    name = json[kSubscriptionNameTag];
    price = double.tryParse(json[kSubscriptionPriceTag].toString());
    period = int.tryParse(json[kSubscriptionPeriodTag].toString());
    color = getTileColor();
  }

  int id;
  String name;
  double price;
  int period; // in days
  Color color;
}
