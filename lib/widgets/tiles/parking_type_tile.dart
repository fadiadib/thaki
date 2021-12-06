import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/parking_type.dart';

class TkParkingTypeTile extends StatelessWidget {
  TkParkingTypeTile({this.onTap, this.isSelected = false, this.parkingType});
  final TkParkingType? parkingType;
  final bool isSelected;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!();
      },
      child: Container(
        height: kTileHeight,
        // Form frame shadow
        decoration: BoxDecoration(
          color: kTileBgColor,
          boxShadow: kTileShadow,
          borderRadius: BorderRadius.circular(12.0),
          border: Border.all(
            color: isSelected ? kSecondaryColor : kTransparentColor,
          ),
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
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: Text(
                      parkingType!.title!.toUpperCase(),
                      style:
                          kBoldStyle[kNormalSize]!.copyWith(color: kBlackColor),
                    ),
                  ),
                  if (parkingType!.subTitle != null) Text(parkingType!.subTitle!),
                ],
              ),

              // Selected mark
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.0),
                  border: Border.all(
                    color: isSelected
                        ? kTransparentColor
                        : kMediumGreyColor.withOpacity(0.3),
                  ),
                ),
                child: Icon(
                  kSelectBtnIcon,
                  color: isSelected ? kSecondaryColor : kTransparentColor,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
