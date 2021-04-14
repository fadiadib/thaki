import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';

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
      padding: const EdgeInsetsDirectional.fromSTEB(
          kCardPadding, kCardPadding / 2, kCardPadding, kCardPadding / 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (title != null && title.isNotEmpty)
            Text(
              title,
              style: kLightStyle[kSmallSize].copyWith(color: textColor),
            ),
          if (details != null && details.isNotEmpty)
            Text(
              details,
              style: kBoldStyle[kNormalSize].copyWith(color: textColor),
            ),
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _getSideWidget(TkCardSide.topLeft),
                  _getSideWidget(TkCardSide.topRight)
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
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
