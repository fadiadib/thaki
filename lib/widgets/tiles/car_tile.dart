import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/widgets/cards/license_card.dart';

class TkCarTile extends StatelessWidget {
  TkCarTile({@required this.car, this.onTap});
  final TkCar car;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap(car);
      },
      child: Container(
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
          child: Stack(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // Car license widget
                  Padding(
                    padding: const EdgeInsetsDirectional.only(end: 10.0),
                    child: TkLicenseCard(car: car),
                  ),

                  // Card number/expiration
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 4.0),
                        child: Text(
                          car.name,
                          style: kBoldStyle[kNormalSize]
                              .copyWith(color: kBlackColor),
                        ),
                      ),
                      Text(car.licensePlate +
                          ' - ' +
                          car.make +
                          ' ' +
                          car.model),
                    ],
                  ),
                ],
              ),
              Align(
                alignment: Alignment.centerRight,
                child: // Preferred mark
                    Icon(
                  kStarCircleBtnIcon,
                  color: car.preferred ? kSecondaryColor : kTransparentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
