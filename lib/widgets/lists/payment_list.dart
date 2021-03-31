import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/credit_card_tile.dart';

class TkPaymentList extends StatelessWidget {
  TkPaymentList({this.onSelect, this.selected});
  final Function onSelect;
  final TkCredit selected;

  Widget _getPaymentList(BuildContext context) {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    List<Widget> tiles = [];

    tiles.add(Padding(
      padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
      child: TkSectionTitle(title: kPaymentMethod),
    ));

    for (TkCredit creditCard in account.user.cards) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: TkCreditCardTile(
            creditCard: creditCard,
            onTap: () {
              if (onSelect != null) onSelect(creditCard);
            },
            isSelected: creditCard == selected,
          ),
        ),
      );
    }

    return Column(children: tiles);
  }

  @override
  Widget build(BuildContext context) {
    return _getPaymentList(context);
  }
}
