import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/transaction_tile.dart';

class TkTransactionList extends StatelessWidget {
  TkTransactionList({this.transactions});
  final List<TkTransaction>? transactions;

  List<Widget> _getTiles(BuildContext context) {
    List<Widget> tiles = [];

    tiles.add(SizedBox(height: 20));

    if (transactions != null && transactions!.isNotEmpty) {
      for (TkTransaction transaction in transactions!) {
        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
            child: TkTransactionTile(transaction: transaction),
          ),
        );
      }
    } else {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: Center(
              child: Text(S.of(context).kNoTransactions, style: kHintStyle)),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) => ListView(children: _getTiles(context));
}
