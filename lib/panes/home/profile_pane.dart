import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/screens/cars_list_screen.dart';
import 'package:thaki/screens/credit_cards_list_screen.dart';
import 'package:thaki/screens/edit_profile_screen.dart';

import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/cards/credit_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/card.dart';
import 'package:thaki/widgets/general/carousel.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/cards/user_info_card.dart';

class TkProfilePane extends TkPane {
  TkProfilePane({onDone, onSelect})
      : super(
          paneTitle: kProfilePaneTitle,
          navIconData: TkNavIconData(icon: kProfileBtnIcon),
        );

  Widget _createPersonalInfo(TkAccount account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(title: kPersonalInfo),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TkUserInfoCard(user: account.user),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: TkButton(
            title: kEditPersonalInfo,
            onPressed: () {
              // Push edit profile page
              Navigator.pushNamed(context, TkEditProfileScreen.id);
            },
          ),
        )
      ],
    );
  }

  List<Widget> _getCarCards(TkAccount account, BuildContext context) {
    List<Widget> widgets = [];
    if (account.user.cars != null)
      for (TkCar car in account.user.cars) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TkCard(
              onTap: () => Navigator.of(context).pushNamed(TkCarsListScreen.id),
              titles: {
                TkCardSide.topLeft: kCarName,
                TkCardSide.bottomLeft: kCarPlate,
                TkCardSide.bottomRight: kCarState
              },
              data: {
                TkCardSide.topLeft: car.name,
                TkCardSide.bottomLeft: car.licensePlate,
                TkCardSide.bottomRight: car.state
              },
            ),
          ),
        );
      }

    return widgets;
  }

  Widget _createCars(TkAccount account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TkSectionTitle(
          title: kMyCars,
          icon: kAddCircleBtnIcon,
          // Open add car screen
          action: () => Navigator.of(context).pushNamed(TkAddCarScreen.id),
        ),

        // Add cars carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: kNoCars,
            children: _getCarCards(account, context),
          ),
        )
      ],
    );
  }

  List<Widget> _getCardCards(TkAccount account, BuildContext context) {
    List<Widget> widgets = [];
    if (account.user.cards != null)
      for (TkCredit card in account.user.cards) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TkCreditCard(
              bgColor: kLightPurpleColor,
              creditCard: card,
              onTap: () =>
                  Navigator.of(context).pushNamed(TkCreditCardsListScreen.id),
            ),
          ),
        );
      }

    return widgets;
  }

  Widget _createCards(TkAccount account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TkSectionTitle(
          title: kMyCards, icon: kAddCircleBtnIcon,
          // Open add card screen
          action: () => Navigator.pushNamed(context, TkAddCardScreen.id),
        ),

        // Add cards carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: kNoPaymentCards,
            children: _getCardCards(account, context),
            aspectRatio: 2,
          ),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(builder: (context, account, child) {
      return account.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                _createPersonalInfo(account, context),
                _createCars(account, context),
                _createCards(account, context),
              ],
            );
    });
  }
}
