import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/tiles/ticket_tile.dart';

class TkParkingSuccessPane extends TkPane {
  TkParkingSuccessPane({onDone})
      : super(paneTitle: '', onDone: onDone, allowNavigation: false);

  Widget _getCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 20.0),
      child: TkButton(title: S.of(context).kClose, onPressed: onDone),
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
                  SizedBox(height: 20),
                  if (booker.parkError == null)
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: TkTicketTile(
                        ticket: booker.newTicket,
                        langCode: Provider.of<TkLangController>(context,
                                listen: false)
                            .lang!
                            .languageCode,
                      ),
                    ),

                  // Result is dependent on the booker result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: booker.parkError == null
                          ? S.of(context).kParkSuccess
                          : booker.parkError,
                      subMessage: booker.parkError == null
                          ? S.of(context).kParkInstructions
                          : null,
                      result: booker.parkError == null,
                    ),
                  ),
                  _getCloseButton(context),
                ],
              );
      },
    );
  }
}
