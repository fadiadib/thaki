import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/general/sliddable.dart';

class TkCreditCardTile extends StatelessWidget {
  TkCreditCardTile({
    @required this.creditCard,
    this.onTap,
    this.isSelected,
    this.onEdit,
    this.onDelete,
    this.langCode = 'en',
  });
  final TkCredit creditCard;
  final Function onTap;
  final Function onDelete;
  final Function onEdit;
  final bool isSelected;
  final String langCode;

  @override
  Widget build(BuildContext context) {
    return TkSlidableTile(
      onDelete: onDelete == null ? null : () => onDelete(creditCard),
      onEdit: onEdit == null ? null : () => onEdit(creditCard),
      child: GestureDetector(
        onTap: () {
          if (onTap != null) onTap(creditCard);
        },
        child: Container(
          height: kTileHeight,
          // Form frame shadow
          decoration: BoxDecoration(
            color: kTileBgColor,
            boxShadow: kTileShadow,
            borderRadius: BorderRadius.circular(4.0),
            border: Border.all(
                color: isSelected != null
                    ? isSelected ? kSecondaryColor : kTransparentColor
                    : creditCard.preferred
                        ? kSecondaryColor
                        : kTransparentColor),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Brand logo
                creditCard.type != null
                    ? Expanded(child: Image.asset(kCCLogos[creditCard.type]))
                    : Expanded(child: Container()),

                // Card number/expiration
                Expanded(
                  flex: 5,
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(start: 20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(bottom: 5.0),
                          child: Text(
                            TkCreditCardHelper.obscure(
                                creditCard.number, langCode),
                            style: kBoldStyle[kNormalSize]
                                .copyWith(color: kBlackColor),
                          ),
                        ),
                        Text(S.of(context).kCardExpires +
                            ' ' +
                            creditCard.expiry),
                      ],
                    ),
                  ),
                ),

                // Preferred mark
                Icon(
                  isSelected != null ? kSelectBtnIcon : kStarCircleBtnIcon,
                  color: isSelected != null
                      ? isSelected ? kSecondaryColor : kTransparentColor
                      : creditCard.preferred
                          ? kSecondaryColor
                          : kTransparentColor,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
