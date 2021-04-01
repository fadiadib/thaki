import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/ticket_list.dart';

class TkTicketsPane extends TkPane {
  TkTicketsPane({onDone, onSelect})
      : super(
          paneTitle: kTicketsPaneTitle,
          navIconData: TkNavIconData(icon: kCalendarBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(builder: (context, booker, _) {
      return booker.isLoading
          ? TkProgressIndicator()
          : DefaultTabController(
              length: 3,
              child: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TabBar(
                        labelStyle: kMediumStyle[kNormalSize],
                        indicatorWeight: 4.0,
                        labelColor: kPrimaryColor,
                        indicatorColor: kPrimaryColor,
                        unselectedLabelColor: kMediumGreyColor.withOpacity(0.5),
                        tabs: [
                          Tab(text: kUpcoming.toUpperCase()),
                          Tab(text: kCompleted.toUpperCase()),
                          Tab(text: kCancelled.toUpperCase()),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                      children: [
                        TkTicketList(tickets: booker.upcomingTickets),
                        TkTicketList(tickets: booker.completedTickets),
                        TkTicketList(tickets: booker.cancelledTickets),
                      ],
                    ),
                  ),
                ],
              ),
            );
    });
  }
}
