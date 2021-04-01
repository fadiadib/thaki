import 'package:flutter/material.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/ticket_tile.dart';

class TkTicketList extends StatelessWidget {
  TkTicketList({this.tickets, this.onTap});
  final List<TkTicket> tickets;
  final Function onTap;

  List<Widget> _getTicketTiles() {
    List<Widget> tiles = [];

    for (TkTicket ticket in tickets) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: TkTicketTile(ticket: ticket, onTap: onTap),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return ListView(children: _getTicketTiles());
  }
}
