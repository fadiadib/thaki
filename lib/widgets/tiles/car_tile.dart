import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';

class TkCarTile extends StatelessWidget {
  TkCarTile({@required this.car});
  final TkCar car;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTileHeight,
      // Form frame shadow
      decoration: BoxDecoration(
        color: kTileBgColor,
        boxShadow: kTileShadow,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            color: car.preferred ? kSecondaryColor : kTransparentColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Card number/expiration
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0),
                  child: Text(
                    car.name,
                    style: kBoldStyle[kNormalSize].copyWith(color: kBlackColor),
                  ),
                ),
                Text(car.licensePlate + ' - ' + car.make + ' ' + car.model),
              ],
            ),

            // Preferred mark
            Icon(
              kStarCircleBtnIcon,
              color: car.preferred ? kSecondaryColor : kTransparentColor,
            )
          ],
        ),
      ),
    );
  }
}
