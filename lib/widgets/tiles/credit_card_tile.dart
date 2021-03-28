import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/utilities/index.dart';

class TkCreditCardTile extends StatelessWidget {
  TkCreditCardTile({@required this.creditCard});
  final TkCredit creditCard;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: kTileHeight,
      // Form frame shadow
      decoration: BoxDecoration(
        color: kTileBgColor,
        boxShadow: kTileShadow,
        borderRadius: BorderRadius.circular(4.0),
        border: Border.all(
            color: creditCard.preferred ? kSecondaryColor : kTransparentColor),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Brand logo
            Image.asset(kCCLogos[creditCard.type]),

            // Card number/expiration
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 5.0),
                  child: Text(
                    TkCreditCardHelper.obscure(creditCard.number),
                    style: kBoldStyle[kNormalSize].copyWith(color: kBlackColor),
                  ),
                ),
                Text(kCardExpires + ' ' + creditCard.expiry),
              ],
            ),

            // Preferred mark
            Icon(
              kStarCircleBtnIcon,
              color: creditCard.preferred ? kSecondaryColor : kTransparentColor,
            )
          ],
        ),
      ),
    );
  }
}
