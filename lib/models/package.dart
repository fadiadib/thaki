import 'package:thaki/globals/index.dart';

class TkPackage {
  TkPackage.fromJson(Map<String, dynamic> json) {
    points = json[kPackagePointsTag];
    price = json[kPackagePriceTag];
    validity = json[kPackageValidityTag];
    details = json[kPackageDetailsTag];
  }

  int points;
  double price;
  int validity; // in days
  String details;
}
