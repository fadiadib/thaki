import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/credit.dart';

class TkCreditCard extends StatelessWidget {
  TkCreditCard({
    this.textColor = kCardTextColor,
    this.bgColor = kCardBgColor,
    this.borderColor = kCardBorderColor,
    this.borderRadius = kCardBorderRadius,
    @required this.creditCard,
  });
  final Color bgColor;
  final Color borderColor;
  final Color textColor;
  final double borderRadius;
  final TkCredit creditCard;

  String _obscureCC(String number) {
    return number.substring(0, 4) + ' XXXX XXXX ' + number.substring(12);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius),
        color: bgColor,
        border: Border.all(color: borderColor, width: 1.0),
      ),
      child: Container(
        child: Stack(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Image.asset(kCardPath1),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(kCardPath2),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Image.asset(kCardPath3),
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                _obscureCC(creditCard.number),
                style: kMediumStyle[kBigSize].copyWith(color: textColor),
              ),
            ),
            Positioned(
              bottom: 30.0,
              left: 30.0,
              child: Text(
                creditCard.expiry,
                style: kMediumStyle[kNormalSize].copyWith(color: textColor),
              ),
            ),
            // Positioned(
            //   bottom: 30.0,
            //   right: 30.0,
            //   child: Image.network(creditCard.brandPath),
            // ),
          ],
        ),
      ),
    );
  }
}
