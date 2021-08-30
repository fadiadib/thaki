import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/date_time_helper.dart';

class TkViolationTile extends StatelessWidget {
  TkViolationTile(
      {@required this.violation, this.onTap, this.isSelected = false});
  final TkViolation violation;
  final Function onTap;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) onTap(violation);
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
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(violation.name, style: kBoldStyle[kNormalSize]),
                    Text(
                      TkDateTimeHelper.formatDate(
                              violation.dateTime.toString()) +
                          ' ' +
                          TkDateTimeHelper.formatTime(
                              context, violation.dateTime.toString()),
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
              ),

              // Preferred mark
              Container(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
