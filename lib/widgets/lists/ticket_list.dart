import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/ticket_tile.dart';

class TkTicketList extends StatelessWidget {
  TkTicketList(
      {this.tickets,
      this.onTap,
      this.onDelete,
      this.onRefresh,
      this.ribbon,
      this.ribbonColor,
      this.langCode = 'en'});
  final List<TkTicket?>? tickets;
  final Function? onTap;
  final Function? onDelete;
  final String? ribbon;
  final Color? ribbonColor;
  final String langCode;
  final Function? onRefresh;

  List<Widget> _getTicketTiles(BuildContext context) {
    List<Widget> tiles = [];

    tiles.add(SizedBox(height: 20));

    if (tickets != null && tickets!.isNotEmpty) {
      for (TkTicket? ticket in tickets!) {
        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: TkTicketTile(
              langCode: langCode,
              ticket: ticket,
              onTap: onTap,
              onDelete: onDelete,
              ribbon: ribbon,
              ribbonColor: ribbonColor,
            ),
          ),
        );
      }
    } else {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child:
              Center(child: Text(S.of(context).kNoBookings, style: kHintStyle)),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    final Widget tickets = ListView(
      children: _getTicketTiles(context),
    );
    return onRefresh == null
        ? tickets
        : RefreshIndicator(
            backgroundColor: kWhiteColor, onRefresh: onRefresh as Future<void> Function(), child: tickets);
  }
}
