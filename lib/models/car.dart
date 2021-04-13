import 'package:thaki/globals/index.dart';

class TkCar {
  TkCar.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCarIdTag].toString());
    name = json[kCarNameTag];
    plateEN = json[kCarPlateENTag];
    plateAR = json[kCarPlateARTag] ?? json[kCarPlateENTag];
    if (plateAR == null || plateAR.isEmpty) plateAR = plateEN;
    make = json[kCarMakeTag] ?? '';
    model = json[kCarModelTag] ?? '';
    state = json[kCarStateTag] == null
        ? 1
        : int.tryParse(json[kCarStateTag]?.toString()) ?? 1;
    preferred = json[kCarPreferredTag].toString() == '1';
  }

  Map<String, dynamic> toJson() {
    return {
      kCarNameTag: name,
      kCarPlateENTag: plateEN,
      // kCarPlateARTag: plateAR,
      kCarMakeTag: make,
      kCarModelTag: model,
      kCarStateTag: state.toString(),
      kCarPreferredTag: preferred == true ? '1' : '0',
    };
  }

  int id;
  String name;
  String plateEN;
  String plateAR;
  String make;
  String model;
  int state;
  bool preferred;
}
