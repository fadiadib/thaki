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
                      RegExp(r"\[A-Z]{3}").stringMatch(car.plateEN) ?? '-',
                      style: kBoldStyle[kSmallSize].copyWith(fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(),
                  child: Center(
                    child: Text(
                      RegExp(r"[\u0660-\u0669]+", unicode: true)
                              .stringMatch(car.plateAR) ??
                          '-',
                      style: kBoldStyle[kSmallSize].copyWith(fontSize: 10),
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
                      right: BorderSide(color: kPrimaryColor),
                      bottom: BorderSide(color: kPrimaryColor),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      RegExp(r"\d+").stringMatch(car.plateEN) ?? '-',
                      style: kBoldStyle[kSmallSize].copyWith(fontSize: 10),
                    ),
                  ),
                ),
                Container(
                  height: 20,
                  width: 40,
                  decoration: BoxDecoration(
                    border: Border(
                        left: BorderSide(color: kPrimaryColor),
                        right: BorderSide(color: kPrimaryColor)),
                  ),
                  child: Center(
                    child: Text(
                      RegExp(r"[\u0621-\u064A]{3}", unicode: true)
                              .stringMatch(car.plateAR) ??
                          '-',
                      style: kBoldStyle[kSmallSize].copyWith(fontSize: 10),
                    ),
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
