import 'package:thaki/globals/index.dart';

class TkCar {
  TkCar.fromJson(Map<String, dynamic> json) {
    name = json[kCarNameTag];
    licensePlate = json[kCarLicenseTag];
    make = json[kCarMakeTag];
    model = json[kCarModelTag];
    state = json[kCarStateTag];
  }

  String name;
  String licensePlate;
  String make;
  String model;
  String state;
}
