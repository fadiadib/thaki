import 'package:thaki/globals/index.dart';

class TkCar {
  TkCar.fromJson(Map<String, dynamic> json) {
    id = int.tryParse(json[kCarIdTag].toString());
    name = json[kCarNameTag];
    plateEN = json[kCarPlateENTag];
    plateAR = json[kCarPlateARTag] ?? json[kCarPlateENTag];

    // Temporary solution
    if (plateAR == null || plateAR.isEmpty) plateAR = plateEN;
    if (plateEN == null || plateEN.isEmpty) plateEN = plateAR;

    make = json[kCarMakeTag] ?? '';
    model = json[kCarModelTag] ?? '';
    state = json[kCarStateTag] == null
        ? 1
        : int.tryParse(json[kCarStateTag]?.toString()) ?? 1;
    preferred = json[kCarPreferredTag].toString() == '1';
    if (json[kCarColorTag] != null) color = json[kCarColorTag];
    if (json[kCarYearTag] != null) year = json[kCarYearTag];
    if (json[kCarApprovedTag] != null)
      isApproved = int.tryParse(json[kCarApprovedTag].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      kCarNameTag: name,
      kCarPlateENTag: plateEN ?? '',
      kCarPlateARTag: plateAR ?? '',
      kCarMakeTag: make,
      kCarModelTag: model,
      kCarStateTag: state.toString(),
      kCarPreferredTag: preferred == true ? '1' : '0',
      kCarColorTag: color ?? '',
      kCarYearTag: year ?? '',
      kCarApprovedTag: isApproved ?? '',
    };
  }

  TkCar createCopy() {
    return TkCar.fromJson({})
      ..id = id
      ..name = name
      ..state = state
      ..plateAR = plateAR
      ..plateEN = plateEN
      ..make = make
      ..model = model
      ..year = year
      ..color = color
      ..preferred = preferred
      ..isApproved = isApproved;
  }

  void copyValue(TkCar car) {
    id = car.id;
    name = car.name;
    state = car.state;
    plateAR = car.plateAR;
    plateEN = car.plateEN;
    make = car.make;
    model = car.model;
    year = car.year;
    color = car.color;
    preferred = car.preferred;
    isApproved = car.isApproved;
  }

  int id;
  String name;
  String plateEN;
  String plateAR;
  String make;
  String model;
  String color;
  String year;
  int state;
  bool preferred;
  int isApproved = 0;
}
