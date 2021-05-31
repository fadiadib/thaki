import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/screens/cars_list_screen.dart';
import 'package:thaki/screens/credit_cards_list_screen.dart';
import 'package:thaki/screens/edit_profile_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';

import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/cards/credit_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/card.dart';
import 'package:thaki/widgets/general/carousel.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/cards/user_info_card.dart';

import '../../providers/lang_controller.dart';

class TkProfilePane extends TkPane {
  TkProfilePane({onDone, onSelect})
      : super(
            paneTitle: '',
            navIconData: TkNavIconData(icon: AssetImage(kProfileIcon)),
            onSelect: onSelect);

  Widget _createPersonalInfo(TkAccount account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(
            title: S.of(context).kPersonalInfo, icon: kEditCircleBtnIcon,
            // Open add car screen
            action: () =>
                Navigator.of(context).pushNamed(TkEditProfileScreen.id),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TkUserInfoCard(user: account.user),
        ),
        if (kShowEditBtnInProfile)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child: TkButton(
              title: S.of(context).kEditPersonalInfo,
              onPressed: () {
                // Push edit profile page
                Navigator.pushNamed(context, TkEditProfileScreen.id);
              },
            ),
          ),
        if (kShowLogoutInProfile)
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: GestureDetector(
                    onTap: () async {
                      if (await account.logout())
                        Navigator.pushReplacementNamed(
                            context, TkWelcomeScreen.id);
                    },
                    child: Text(S.of(context).kLogOut,
                        style: kMediumStyle[kSmallSize])),
              ),
              TkError(message: account.logoutError)
            ],
          ),
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
              onTap: () async {
                await Navigator.of(context).pushNamed(TkCarsListScreen.id);
                account.load();
              },
              titles: {
                TkCardSide.topLeft: S.of(context).kCarName,
                TkCardSide.bottomLeft: S.of(context).kCarPlate,
                TkCardSide.bottomRight: S.of(context).kCarState
              },
              data: {
                TkCardSide.topLeft: car.name,
                TkCardSide.bottomLeft:
                    Provider.of<TkLangController>(context, listen: false)
                                .lang
                                .languageCode ==
                            'en'
                        ? car.plateEN
                        : car.plateAR,
                TkCardSide.bottomRight:
                    Provider.of<TkAttributesController>(context).stateName(
                        car.state,
                        Provider.of<TkLangController>(context, listen: false))
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
          title: S.of(context).kMyCars,
          icon: kAddCircleBtnIcon,
          // Open add car screen
          action: () async {
            await Navigator.of(context).pushNamed(TkAddCarScreen.id);
            account.load();
          },
        ),

        // Add cars carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            height: 130,
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: S.of(context).kNoCars,
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
              langCode: Provider.of<TkLangController>(context, listen: false)
                  .lang
                  .languageCode,
              bgColor: kLightPurpleColor,
              creditCard: card,
              onTap: () async {
                await Navigator.of(context)
                    .pushNamed(TkCreditCardsListScreen.id);
                account.load();
              },
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
          title: S.of(context).kMyCards, icon: kAddCircleBtnIcon,
          // Open add card screen
          action: () async {
            await Navigator.pushNamed(context, TkAddCardScreen.id);
            account.load();
          },
        ),

        // Add cards carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: S.of(context).kNoPaymentCards,
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
