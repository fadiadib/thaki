import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/utilities/date_time_helper.dart';

class TkUserPackageTile extends StatelessWidget {
  TkUserPackageTile(
      {required this.package, this.isSelected = false, this.onTap});

  final TkPackage package;
  final bool isSelected;
  final Function? onTap;

  Widget _getTileImage() {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: package.color!.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset(
          kPackageIcon,
          color: package.color,
        ),
      ),
    );
  }

  Widget _getTileDetails(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  package.remaining.toString() +
                      '/' +
                      package.points.toString() +
                      ' ' +
                      S.of(context).kHourPackage,
                  style: kBoldStyle[kNormalSize],
                ),
                SizedBox(height: 15),
                Text(
                    S.of(context).kPurchaseDate +
                        ' ' +
                        TkDateTimeHelper.formatDate(package.startDate)!,
                    style: kRegularStyle[kSmallSize]),
                Text(
                  S.of(context).kExpiryDate +
                      ' ' +
                      TkDateTimeHelper.formatDate(package.endDate)!,
                  style: kBoldStyle[kSmallSize]!.copyWith(
                    color: kPrimaryColor,
                  ),
                )
              ],
            ),
            Positioned.directional(
              textDirection:
                  Provider.of<TkLangController>(context, listen: false)
                              .lang!
                              .languageCode ==
                          'ar'
                      ? TextDirection.rtl
                      : TextDirection.ltr,
              end: 10,
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
      onTap: onTap as void Function()?,
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
            _getTileDetails(context),
          ],
        ),
      ),
    );
  }
}
