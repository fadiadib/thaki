import 'package:thaki/globals/index.dart';

class TkCar {
  TkCar.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCarIdTag].toString());
    name = json[kCarNameTag];
    licensePlate = json[kCarLicenseTag];
    make = json[kCarMakeTag];
    model = json[kCarModelTag];
    state = json[kCarStateTag];
    preferred = json[kCarPreferredTag] == true;
  }

  int id;
  String name;
  String licensePlate;
  String make;
  String model;
  String state;
  bool preferred;
}
