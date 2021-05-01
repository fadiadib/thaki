import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/widgets/cards/license_card.dart';
import 'package:thaki/widgets/general/ribbon.dart';
import 'package:thaki/widgets/general/sliddable.dart';

class TkCarTile extends StatelessWidget {
  TkCarTile({
    @required this.car,
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.langCode = 'en',
    this.showRibbon = false,
  });
  final TkCar car;
  final Function onTap;
  final Function onDelete;
  final Function onEdit;
  final String langCode;
  final bool showRibbon;

  @override
  Widget build(BuildContext context) {
    return TkSlidableTile(
      onDelete: onDelete == null ? null : () => onDelete(car),
      onEdit: onEdit == null ? null : () => onEdit(car),
      child: GestureDetector(
        onTap: onTap == null ? null : () => onTap(car),
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
              overflow: Overflow.visible,
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
                        Text((langCode == 'en'
                                ? car.plateEN ?? '-'
                                : car.plateAR ?? '-') +
                            ' - ' +
                            car.make +
                            ' ' +
                            car.model),
                      ],
                    ),
                  ],
                ),
                if (showRibbon)
                  TkMarker(
                      title: car.statusTitle(context),
                      color: car.statusColor,
                      side: langCode == 'en'
                          ? TkCardRibbonSide.right
                          : TkCardRibbonSide.left),
                Align(
                  alignment: AlignmentDirectional.centerEnd,
                  child: // Preferred mark
                      Icon(
                    kStarCircleBtnIcon,
                    color: car.preferred ? kSecondaryColor : kTransparentColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
