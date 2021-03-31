import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkLicenseCard extends StatelessWidget {
  TkLicenseCard({this.car});
  final TkCar car;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 42,
        decoration: BoxDecoration(
          color: kTileBgColor,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(color: kPrimaryColor),
        ),
        child: Row(
          children: [
            Column(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: kPrimaryColor)),
                  ),
                  child: Center(
                      child: Text(
                    car.licensePlate.split(' ').first,
                    style: kBoldStyle[kSmallSize],
                  )),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Text(
                      // TODO: needs translation
                      car.licensePlate.split(' ').last,
                      style: kBoldStyle[kSmallSize],
                    ),
                  ),
                ),
              ],
            ),
            Column(
              children: [
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: kPrimaryColor),
                      bottom: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  child: Center(
                      child: Text(
                    car.licensePlate.split(' ').last,
                    style: kBoldStyle[kSmallSize],
                  )),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border(
                      left: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  child: Center(
                    // TODO: needs translation
                    child: Text(
                      car.licensePlate.split(' ').first,
                      style: kBoldStyle[kSmallSize],
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
