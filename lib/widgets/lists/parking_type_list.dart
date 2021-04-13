import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/parking_type.dart';
import 'package:thaki/widgets/tiles/parking_type_tile.dart';

class TkParkingTypeList extends StatelessWidget {
  TkParkingTypeList({this.onTap, this.parkNow = true});
  final Function onTap;
  final bool parkNow;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
        child: TkParkingTypeTile(
          isSelected: parkNow,
          onTap: onTap,
          parkingType: TkParkingType(
              title: S.of(context).kImmediateParking,
              subTitle: S.of(context).kParkNow),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
        child: TkParkingTypeTile(
          isSelected: !parkNow,
          onTap: onTap,
          parkingType: TkParkingType(
              title: S.of(context).kScheduleParking,
              subTitle: S.of(context).kScheduleYourParking),
        ),
      ),
    ]);
  }
}
