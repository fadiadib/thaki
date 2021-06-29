import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';

import '../../globals/colors.dart';
import '../../globals/index.dart';

enum TkCardSide { topLeft, topRight, bottomLeft, bottomRight }

class TkCard extends StatelessWidget {
  TkCard({
    this.borderRadius = kCardBorderRadius,
    this.bgColor = kCardBgColor,
    this.borderColor = kCardBorderColor,
    this.textColor = kCardTextColor,
    this.titles,
    this.data,
    this.onTap,
  });
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final Map<TkCardSide, String> titles;
  final Map<TkCardSide, String> data;
  final Function onTap;

  Widget _getSideWidget(TkCardSide side) {
    String title = titles == null ? null : titles[side];
    String details = data == null ? null : data[side];
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(kCardPadding * 2,
          kCardPadding / 2, kCardPadding * 2, kCardPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          (title != null && title.isNotEmpty)
              ? Text(
                  title,
                  style: kLightStyle[kSmallSize].copyWith(color: textColor),
                )
              : Container(),
          (details != null && details.isNotEmpty)
              ? Text(
                  details,
                  style: kBoldStyle[kSmallSize].copyWith(color: textColor),
                )
              : Container(),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 800,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          color: bgColor,
          border: Border.all(color: borderColor, width: 1.0),
        ),
        padding: EdgeInsets.symmetric(vertical: kCardPadding / 2),

        // Two quadrants
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getSideWidget(TkCardSide.topLeft),
                  _getSideWidget(TkCardSide.topRight)
                ],
              ),
            ),
            FittedBox(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getSideWidget(TkCardSide.bottomLeft),
                  _getSideWidget(TkCardSide.bottomRight)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
