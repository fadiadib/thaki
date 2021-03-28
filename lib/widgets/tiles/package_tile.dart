import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkPackageTile extends StatelessWidget {
  TkPackageTile({@required this.package, this.isSelected = false, this.onTap});
  final TkPackage package;
  final bool isSelected;
  final Function onTap;

  static int colorIndex = 0;
  static Color getTileColor(bool advance) {
    Color result = kTileColor[colorIndex];
    if (advance) {
      if (colorIndex < kTileColor.length - 1)
        colorIndex++;
      else
        colorIndex = 0;
    }

    return result;
  }

  Widget _getTileImage() {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: getTileColor(false).withOpacity(0.08),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset(
          kPackageIcon,
          color: getTileColor(true),
        ),
      ),
    );
  }

  Widget _getTileDetails() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.points.toString() + ' ' + kHourPackage,
                  style: kBoldStyle[kNormalSize],
                ),
                SizedBox(height: 15),
                Text(kValidFor +
                    ' ' +
                    package.validity.toString() +
                    ' ' +
                    kDays),
                Text(kSAR + ' ' + package.price.toString())
              ],
            ),
            Positioned(
              right: 10,
              bottom: -5,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: kMediumGreyColor.withOpacity(0.2)),
                  borderRadius: BorderRadius.circular(25.0),
                ),
                child: Icon(
                  kSelectBtnIcon,
                  size: 20,
                  color: isSelected ? kSecondaryColor : kTransparentColor,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: kTileBgColor,
          boxShadow: kTileShadow,
          borderRadius: BorderRadius.circular(4.0),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _getTileImage(),
            Container(
              width: 1,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: kMediumGreyColor.withOpacity(0.2)),
              ),
            ),
            _getTileDetails(),
          ],
        ),
      ),
    );
  }
}
