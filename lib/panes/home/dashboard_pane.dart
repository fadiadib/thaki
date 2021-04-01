import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/card.dart';
import 'package:thaki/widgets/general/carousel.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/screens/purchase_package_screen.dart';
import 'package:thaki/screens/resident_permit_screen.dart';

class TkDashboardPane extends TkPane {
  TkDashboardPane({onDone, onSelect})
      : super(
          paneTitle: kDashboardPaneTitle,
          navIconData: TkNavIconData(icon: kHomeBtnIcon),
        );

  List<Widget> _getTicketCards(TkBooker booker, BuildContext context) {
    List<Widget> widgets = [];
    if (booker.tickets != null)
      for (TkTicket ticket in booker.tickets) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TkCard(
              bgColor: kPrimaryColor.withOpacity(0.15),
              textColor: kDarkGreyColor,
              titles: {
                TkCardSide.topLeft: kCarPlate,
                TkCardSide.bottomLeft: kFrom,
                TkCardSide.bottomRight: kTo
              },
              data: {
                TkCardSide.topLeft: ticket.car.licensePlate,
                TkCardSide.bottomLeft:
                    TkDateTimeHelper.formatDate(ticket.start.toString()) +
                        '\n' +
                        TkDateTimeHelper.formatTime(ticket.start.toString()),
                TkCardSide.bottomRight:
                    TkDateTimeHelper.formatDate(ticket.end.toString()) +
                        '\n' +
                        TkDateTimeHelper.formatTime(ticket.end.toString()),
              },
            ),
          ),
        );
      }

    return widgets;
  }

  Widget _createBookings(TkBooker booker, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: kMyBookings),
        ),

        // Add bookings carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            aspectRatio: 2.0,
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: kNoBookings,
            children: _getTicketCards(booker, context),
          ),
        ),

        // Book your parking button
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: TkButton(
            title: kBookParking,
            onPressed: () {
              // TODO: Open booking page
            },
          ),
        )
      ],
    );
  }

  Widget _createBalance(TkBooker booker, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: kMyBalance),
        ),

        // Add bookings carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          child: TkCard(
            bgColor: kPrimaryColor.withOpacity(0.15),
            textColor: kDarkGreyColor,
            titles: {
              TkCardSide.topLeft: kCurrentBalance,
              TkCardSide.topRight: kValidTill,
            },
            data: {
              TkCardSide.topLeft:
                  booker.balance.points.toString() + ' ' + kHours,
              TkCardSide.topRight: TkDateTimeHelper.formatDate(
                  booker.balance.validity.toString()),
            },
          ),
        ),

        // Recharge button
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: TkButton(
            title: kRechargeBalance,
            onPressed: () => Navigator.of(context).pushNamed(
              TkPurchasePackageScreen.id,
            ),
          ),
        ),

        // Subscription button
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: TkButton(
            title: kApplySubscription,
            btnBorderColor: kSecondaryColor,
            btnColor: kSecondaryColor,
            onPressed: () => Navigator.of(context).pushNamed(
              TkResidentPermitScreen.id,
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(builder: (context, booker, child) {
      return booker.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                _createBookings(booker, context),
                _createBalance(booker, context),
              ],
            );
    });
  }
}
