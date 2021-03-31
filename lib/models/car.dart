import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkCar {
  TkCar.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCarIdTag].toString());
    name = json[kCarNameTag];
    licensePlate = json[kCarLicenseTag];
    make = json[kCarMakeTag];
    model = json[kCarModelTag];
    state = json[kCarStateTag];
    preferred = json[kCarPreferredTag] == true;
    // violations = [];
    // if (json[kViolationsTag] != null) {
    //   for (Map<String, dynamic> vJson in json[kViolationsTag])
    //     violations.add(TkViolation.fromJson(vJson));
    // }
  }

  int id;
  String name;
  String licensePlate;
  String make;
  String model;
  String state;
  bool preferred;
  // List<TkViolation> violations;
}
