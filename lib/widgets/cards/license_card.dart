import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkLicenseCard extends StatelessWidget {
  TkLicenseCard({this.car});
  final TkCar car;

  String _getARLetterPlate() {
    String result = RegExp(r"([\u0621-\u064A]\s){2,3}", unicode: true)
            .stringMatch(car.plateAR) ??
        RegExp(r"[\u0621-\u064A]{2,3}", unicode: true)
            .stringMatch(car.plateAR) ??
        RegExp(r"[A-Z]{2,3}", unicode: true).stringMatch(car.plateAR) ??
        '-';
    return result.split('').join(' ');
  }

  Widget _getWidget() {
    if (car.state == 1) {
      return Row(
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
                    RegExp(r"[A-Z]{2,3}").stringMatch(car.plateEN) ?? '-',
                    style: kBoldStyle[kSmallSize].copyWith(fontSize: 12),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(),
                child: Center(
                  child: Text(_getARLetterPlate(),
                      style: kBoldStyle[kSmallSize].copyWith(fontSize: 10)),
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
                    bottom: BorderSide(color: kPrimaryColor),
                  ),
                ),
                child: Center(
                  child: Text(
                    RegExp(r"[\d]+").stringMatch(car.plateEN) ?? '-',
                    style: kBoldStyle[kSmallSize].copyWith(fontSize: 12),
                  ),
                ),
              ),
              Container(
                height: 20,
                width: 40,
                decoration: BoxDecoration(
                  border: Border(),
                ),
                child: Center(
                  child: Text(
                    RegExp(r"[\u0660-\u0669\d]+", unicode: true)
                            .stringMatch(car.plateAR) ??
                        '-',
                    style: kBoldStyle[kSmallSize].copyWith(fontSize: 12),
                  ),
                ),
              ),
            ],
          )
        ],
      );
    } else {
      return Column(children: [
        Container(
          height: 20,
          width: 80,
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: kPrimaryColor)),
          ),
          child: Center(
            child: Text(
              RegExp(r"\d+").stringMatch(car.plateEN) ?? '-',
              style: kBoldStyle[kSmallSize].copyWith(fontSize: 12),
            ),
          ),
        ),
        Container(
          height: 20,
          width: 80,
          decoration: BoxDecoration(),
          child: Center(
            child: Text(
              RegExp(r"[\u0660-\u0669]+", unicode: true)
                      .stringMatch(car.plateAR) ??
                  '-',
              style: kBoldStyle[kSmallSize].copyWith(fontSize: 12),
            ),
          ),
        ),
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      decoration: BoxDecoration(
        color: kTileBgColor,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(color: kPrimaryColor),
      ),
      child: _getWidget(),
    );
  }
}
