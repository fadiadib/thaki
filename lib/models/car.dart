import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
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

    make = int.tryParse(json[kCarMakeTag].toString());
    model = int.tryParse(json[kCarModelTag].toString());
    state = int.tryParse(json[kCarStateTag].toString()) == null
        ? 1
        : int.tryParse(json[kCarStateTag]?.toString()) ?? 1;
    preferred = json[kCarPreferredTag].toString() == '1';
    if (json[kCarColorTag] != null)
      color = int.tryParse(json[kCarColorTag].toString());
    if (json[kCarYearTag] != null) year = json[kCarYearTag];
    if (json[kCarApprovedTag] != null)
      isApproved = int.tryParse(json[kCarApprovedTag].toString());
  }

  Map<String, dynamic> toJson() {
    return {
      kCarNameTag: name,
      kCarPlateENTag: plateEN ?? '',
      kCarPlateARTag: plateAR ?? '',
      kCarMakeTag: make.toString(),
      kCarModelTag: model.toString(),
      kCarStateTag: state.toString(),
      kCarPreferredTag: preferred == true ? '1' : '0',
      kCarColorTag: color == null ? '' : color.toString(),
      kCarYearTag: year == null ? '' : year,
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

  String statusTitle(BuildContext context) {
    if (isApproved == 1) return S.of(context).kApproved;
    if (isApproved == 3) return S.of(context).kPending;
    if (isApproved == 2) return S.of(context).kRejected;
    return '';
  }

  Color get statusColor {
    if (isApproved == 1) return kGreenAccentColor;
    if (isApproved == 3) return kTertiaryColor;
    if (isApproved == 2) return kRedAccentColor;
    return kTransparentColor;
  }

  int id;
  String name;
  String plateEN;
  String plateAR;
  int make;
  int model;
  int color;
  String year;
  int state;
  bool preferred;
  int isApproved = 0;
}
