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
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/lists/ticket_list.dart';

class TkTicketsPane extends TkPane {
  TkTicketsPane({onDone, onSelect})
      : super(
          paneTitle: '',
          navIconData: TkNavIconData(icon: AssetImage(kTicketsIcon)),
          onSelect: onSelect,
        );

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(builder: (context, booker, _) {
      return booker.isLoading
          ? TkProgressIndicator()
          : DefaultTabController(
              length: kAllowDeleteTicket ? 4 : 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TabBar(
                        isScrollable: true,
                        labelStyle: kBoldStyle[kSmallSize].copyWith(
                            fontFamily: Provider.of<TkLangController>(context,
                                    listen: false)
                                .fontFamily,
                            fontSize: Provider.of<TkLangController>(context,
                                        listen: false)
                                    .isRTL
                                ? 18.0
                                : 12.0),
                        indicatorWeight: 4.0,
                        labelColor: kPrimaryColor,
                        indicatorColor: kPrimaryColor,
                        unselectedLabelColor: kMediumGreyColor.withOpacity(0.5),
                        tabs: [
                          Tab(text: S.of(context).kUpcoming.toUpperCase()),
                          Tab(text: S.of(context).kCompleted.toUpperCase()),
                          Tab(text: S.of(context).kPending.toUpperCase()),
                          if (kAllowDeleteTicket)
                            Tab(text: S.of(context).kCancelled.toUpperCase()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TkTicketList(
                          langCode: Provider.of<TkLangController>(context,
                                  listen: false)
                              .lang
                              .languageCode,
                          tickets: booker.upcomingTickets,
                          onDelete: !kAllowDeleteTicket
                              ? null
                              : (TkTicket ticket) async {
                                  if (await TkDialogHelper
                                          .gShowConfirmationDialog(
                                        context: context,
                                        message:
                                            S.of(context).kAreYouSureTicket,
                                        type: gDialogType.yesNo,
                                      ) ??
                                      false)
                                    booker.cancelTicket(
                                      Provider.of<TkAccount>(context,
                                              listen: false)
                                          .user,
                                      ticket,
                                    );
                                  Provider.of<TkPurchaser>(context,
                                          listen: false)
                                      .loadBalance(Provider.of<TkAccount>(
                                              context,
                                              listen: false)
                                          .user);
                                },
                        ),
                        TkTicketList(
                            langCode: Provider.of<TkLangController>(context,
                                    listen: false)
                                .lang
                                .languageCode,
                            tickets: booker.completedTickets,
                            ribbon: S.of(context).kCompleted,
                            ribbonColor: kGreenAccentColor),
                        TkTicketList(
                          langCode: Provider.of<TkLangController>(context,
                                  listen: false)
                              .lang
                              .languageCode,
                          tickets: booker.pendingTickets,
                          ribbon: S.of(context).kPending,
                          ribbonColor: kSecondaryColor,
                        ),
                        if (kAllowDeleteTicket)
                          TkTicketList(
                              langCode: Provider.of<TkLangController>(context,
                                      listen: false)
                                  .lang
                                  .languageCode,
                              tickets: booker.cancelledTickets,
                              ribbon: S.of(context).kCancelled,
                              ribbonColor: kTertiaryColor),
                      ],
                    ),
                  ),
                  TkError(message: booker.cancelError)
                ],
              ),
            );
    });
  }
}
