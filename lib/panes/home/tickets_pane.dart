import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/utilities/dialog_helper.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/tabs.dart';
import 'package:thaki/widgets/lists/ticket_list.dart';

class TkTicketsPane extends TkPane {
  TkTicketsPane({onDone, onSelect})
      : super(
          paneTitle: '',
          navIconData: TkNavIconData(icon: AssetImage(kTicketsIcon)),
          onSelect: onSelect,
        );

  Widget _buildTabs(BuildContext context, TkBooker booker) {
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    return TkTabs(
      length: kAllowDeleteTicket
          ? kAllowPendingTicket ? 4 : 3
          : kAllowPendingTicket ? 3 : 2,
      titles: [
        S.of(context).kUpcoming.toUpperCase(),
        S.of(context).kCompleted.toUpperCase(),
        if (kAllowPendingTicket) S.of(context).kPending.toUpperCase(),
        if (kAllowDeleteTicket) S.of(context).kCancelled.toUpperCase()
      ],
      children: [
        TkTicketList(
          langCode: langController.lang.languageCode,
          tickets: booker.upcomingTickets,
          onDelete: !kAllowDeleteTicket
              ? null
              : (TkTicket ticket) async {
                  TkPurchaser purchaser =
                      Provider.of<TkPurchaser>(context, listen: false);
                  TkAccount account =
                      Provider.of<TkAccount>(context, listen: false);

                  if (await TkDialogHelper.gShowConfirmationDialog(
                        context: context,
                        message: S.of(context).kAreYouSureTicket,
                        type: gDialogType.yesNo,
                      ) ??
                      false)
                    booker.cancelTicket(
                      account.user,
                      ticket,
                    );
                  purchaser.loadBalance(account.user);
                },
        ),
        TkTicketList(
          langCode: langController.lang.languageCode,
          tickets: booker.completedTickets,
          ribbon: S.of(context).kCompleted,
          ribbonColor: kGreenAccentColor,
        ),
        if (kAllowPendingTicket)
          TkTicketList(
            langCode: langController.lang.languageCode,
            tickets: booker.pendingTickets,
            ribbon: S.of(context).kPending,
            ribbonColor: kSecondaryColor,
          ),
        if (kAllowDeleteTicket)
          TkTicketList(
            langCode: langController.lang.languageCode,
            tickets: booker.cancelledTickets,
            ribbon: S.of(context).kCancelled,
            ribbonColor: kTertiaryColor,
          ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(builder: (context, booker, _) {
      return booker.isLoading
          ? TkProgressIndicator()
          : _buildTabs(context, booker);
    });
  }
}
