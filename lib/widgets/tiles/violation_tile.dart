import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/utilities/date_time_helper.dart';
import 'package:thaki/widgets/general/ribbon.dart';

class TkViolationTile extends StatelessWidget {
  TkViolationTile(
      {required this.violation, this.onTap, this.isSelected = false});
  final TkViolation violation;
  final Function? onTap;
  final bool isSelected;

  Widget _buildViolationDetails(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(violation.name!, style: kBoldStyle[kNormalSize]),
          Text(
            TkDateTimeHelper.formatDate(violation.dateTime.toString())! +
                ' ' +
                TkDateTimeHelper.formatTime(
                    context, violation.dateTime.toString())!,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Text(
              violation.location,
              style: kBoldStyle[kNormalSize],
            ),
          ),
          Text(
            S.of(context).kSAR + ' ' + violation.fine.toString(),
          )
        ],
      ),
    );
  }

  Widget _buildSelectionButton() {
    // Selection mark
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        border: Border.all(
          color: isSelected ? kTransparentColor : kSecondaryColor,
        ),
      ),
      child: Icon(
        kSelectBtnIcon,
        color: isSelected ? kSecondaryColor : kTransparentColor,
      ),
    );
  }

  Widget _buildMarker(BuildContext context) {
    return TkMarker(
      isStack: false,
      title: violation.isPaid ? S.of(context).kPaid : S.of(context).kCancelled,
      color: violation.isPaid ? kGreenAccentColor : kRedAccentColor,
      side: Provider.of<TkLangController>(context, listen: false).isRTL
          ? TkCardRibbonSide.left
          : TkCardRibbonSide.right,
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap!(violation);
      },
      child: Container(
        decoration: BoxDecoration(
          color: kTileBgColor,
          boxShadow: kTileShadow,
          borderRadius: BorderRadius.circular(4.0),
          border: Border.all(
            color: isSelected ? kSecondaryColor : kTransparentColor,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: violation.isUnpaid
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            children: [
              _buildViolationDetails(context),
              violation.isUnpaid
                  ? _buildSelectionButton()
                  : _buildMarker(context),
            ],
          ),
        ),
      ),
    );
  }
}
