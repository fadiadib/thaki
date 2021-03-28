import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/tiles/credit_card_tile.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkCreditCardsListScreen extends StatefulWidget {
  static const String id = 'credit_cards_screen';

  @override
  _TkCreditCardsListScreenState createState() =>
      _TkCreditCardsListScreenState();
}

class _TkCreditCardsListScreenState extends State<TkCreditCardsListScreen> {
  List<Widget> _getTiles(TkAccount account) {
    List<Widget> tiles = [];

    for (TkCredit card in account.user.cards) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: TkCreditCardTile(creditCard: card),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(
      builder: (context, account, _) {
        return Scaffold(
          appBar: TkAppBar(
            context: context,
            enableClose: true,
            enableNotifications: false,
            removeLeading: false,
            title: TkLogoBox(),
          ),
          body: TkScaffoldBody(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TkSectionTitle(
                    title: kMyCards,
                    icon: kAddCircleBtnIcon,
                    action: () =>
                        Navigator.of(context).pushNamed(TkAddCardScreen.id),
                  ),
                ),
                Column(children: _getTiles(account)),
              ],
            ),
          ),
        );
      },
    );
  }
}
