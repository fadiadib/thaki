import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';

class TkSubscriptionTile extends StatelessWidget {
  TkSubscriptionTile(
      {@required this.subscription, this.isSelected = false, this.onTap});
  final TkSubscription subscription;
  final bool isSelected;
  final Function onTap;

  Widget _getTileImage() {
    return Container(
      height: 100,
      width: 100,
      padding: EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: subscription.color.withOpacity(0.08),
          borderRadius: BorderRadius.circular(100.0),
        ),
        child: Image.asset(
          kPackageIcon,
          color: subscription.color,
        ),
      ),
    );
  }

  Widget _getTileDetails(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsetsDirectional.only(start: 10),
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(subscription.name, style: kBoldStyle[kNormalSize]),
                SizedBox(height: 15),
                Text(S.of(context).kValidFor +
                    ' ' +
                    subscription.period.toString() +
                    ' ' +
                    S.of(context).kDays),
                Text(
                  S.of(context).kSAR + ' ' + subscription.price.toString(),
                  style: kBoldStyle[kSmallSize].copyWith(color: kPrimaryColor),
                )
              ],
            ),
            Positioned.directional(
              textDirection:
                  Provider.of<TkLangController>(context, listen: false)
                              .lang
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
            _getTileDetails(context),
          ],
        ),
      ),
    );
  }
}
