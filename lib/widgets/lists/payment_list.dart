import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/credit_card_tile.dart';

class TkPaymentList extends StatelessWidget {
  TkPaymentList({
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.selected,
    this.cards,
    this.enableTitle = true,
  });
  final bool enableTitle;
  final TkCredit selected;
  final List<TkCredit> cards;
  final Function onTap;
  final Function onDelete;
  final Function onEdit;

  Widget _getPaymentList(BuildContext context) {
    List<Widget> tiles = [];

    if (enableTitle) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: TkSectionTitle(title: S.of(context).kPaymentMethod),
        ),
      );
    }

    if (cards == null || cards.isEmpty) {
      tiles.add(Center(
          child: Text(S.of(context).kNoPaymentCards, style: kHintStyle)));
    } else {
      for (TkCredit creditCard in cards) {
        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: TkCreditCardTile(
              creditCard: creditCard,
              onTap: onTap,
              onDelete: onDelete,
              onEdit: onEdit,
              isSelected: selected == null ? null : creditCard == selected,
            ),
          ),
        );
      }
    }

    return Column(children: tiles);
  }

  @override
  Widget build(BuildContext context) {
    return _getPaymentList(context);
  }
}
