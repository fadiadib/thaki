import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/ticket_tile.dart';

class TkParkingSuccessPane extends TkPane {
  TkParkingSuccessPane({onDone})
      : super(paneTitle: kBookParking, onDone: onDone, allowNavigation: false);

  Widget _getCloseButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(title: kClose, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(
      builder: (context, booker, _) {
        return booker.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: ''),
                  ),
                  if (booker.parkError == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TkTicketTile(ticket: booker.newTicket),
                    ),

                  // Result is dependent on the booker result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: booker.parkError == null
                          ? kParkSuccess
                          : booker.parkError,
                      result: booker.parkError == null,
                    ),
                  ),
                  _getCloseButton(),
                ],
              );
      },
    );
  }
}
