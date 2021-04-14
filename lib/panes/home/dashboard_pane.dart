import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/tab_selector.dart';
import 'package:thaki/screens/buy_subscription_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/card.dart';
import 'package:thaki/widgets/general/carousel.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/screens/purchase_package_screen.dart';
import 'package:thaki/screens/apply_subscription_screen.dart';

class TkDashboardPane extends TkPane {
  TkDashboardPane({onDone, onSelect})
      : super(
          paneTitle: '',
          navIconData: TkNavIconData(icon: AssetImage(kDashboardIcon)),
        );

  List<Widget> _getTicketCards(TkBooker booker, BuildContext context) {
    List<Widget> widgets = [];
    if (booker.upcomingTickets != null)
      for (TkTicket ticket in booker.upcomingTickets) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TkCard(
              bgColor: kPrimaryColor.withOpacity(0.15),
              textColor: kDarkGreyColor,
              titles: {
                TkCardSide.topLeft: S.of(context).kCarPlate,
                TkCardSide.bottomLeft: S.of(context).kFrom,
                TkCardSide.bottomRight: S.of(context).kTo
              },
              data: {
                TkCardSide.topLeft: ticket.car.plateEN,
                TkCardSide.bottomLeft:
                    TkDateTimeHelper.formatDate(ticket.start.toString()) +
                        '\n' +
                        TkDateTimeHelper.formatTime(
                            context, ticket.start.toString()),
                TkCardSide.bottomRight: TkDateTimeHelper.formatDate(
                        ticket.end.toString()) +
                    '\n' +
                    TkDateTimeHelper.formatTime(context, ticket.end.toString()),
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
          child: TkSectionTitle(title: S.of(context).kMyBookings),
        ),

        // Add bookings carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            aspectRatio: 2.0,
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: S.of(context).kNoBookingsYet,
            children: _getTicketCards(booker, context),
          ),
        ),

        // Book your parking button
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: TkButton(
            title: S.of(context).kBookParkingNow,
            onPressed: () {
              // Open booking page
              Provider.of<TkTabSelector>(context, listen: false).activeTab = 1;
            },
          ),
        )
      ],
    );
  }

  String _getSubscriptionBtnTitle(TkUser user, BuildContext context) {
    if (user.isApproved == 0) return S.of(context).kApplySubscription;
    if (user.isApproved == 1) return S.of(context).kBuySubscription;
    if (user.isApproved == 2) return S.of(context).kYourRequestIsPending;
    return S.of(context).kYourRequestIsDeclined;
  }

  Function _getSubscriptionBtnAction(TkUser user, BuildContext context) {
    if (user.isApproved == 0)
      return () => Navigator.of(context).pushNamed(TkBuySubscriptionScreen.id);
    if (user.isApproved == 1)
      return () =>
          Navigator.of(context).pushNamed(TkApplyForSubscriptionScreen.id);
    return null;
  }

  Widget _createBalance(
      TkPurchaser purchaser, TkAccount account, BuildContext context) {
    TkUser user = account.user;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: S.of(context).kMyBalance),
        ),

        // Add bookings carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 30.0, right: 30.0),
          child: TkCard(
            bgColor: kPrimaryColor.withOpacity(0.15),
            textColor: kDarkGreyColor,
            titles: {
              TkCardSide.topLeft: S.of(context).kCurrentBalance,
              TkCardSide.topRight: S.of(context).kValidTill,
            },
            data: {
              TkCardSide.topLeft: purchaser.balance?.points.toString() +
                  ' ' +
                  S.of(context).kHours,
              TkCardSide.topRight: TkDateTimeHelper.formatDate(
                  purchaser.balance?.validity.toString()),
            },
          ),
        ),

        // Recharge button
        Padding(
          padding: const EdgeInsets.only(top: 20, left: 50, right: 50),
          child: TkButton(
            title: S.of(context).kRechargeBalance,
            onPressed: () => Navigator.of(context).pushNamed(
              TkPurchasePackageScreen.id,
            ),
          ),
        ),

        // Subscription button
        Padding(
          padding:
              const EdgeInsets.only(top: 20, left: 50, right: 50, bottom: 20),
          child: TkButton(
            title: _getSubscriptionBtnTitle(user, context),
            btnBorderColor: kSecondaryColor,
            btnColor: kSecondaryColor,
            disabledTitleColor: kWhiteColor.withOpacity(0.5),
            enabled: user.isApproved == 1 || user.isApproved == 0,
            onPressed: _getSubscriptionBtnAction(user, context),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<TkPurchaser, TkBooker, TkAccount>(
        builder: (context, purchaser, booker, account, child) {
      return purchaser.isLoading || booker.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                _createBookings(booker, context),
                _createBalance(purchaser, account, context),
              ],
            );
    });
  }
}
