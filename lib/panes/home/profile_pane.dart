import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/attributes_controller.dart';

import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/screens/cars_list_screen.dart';
import 'package:thaki/screens/credit_cards_list_screen.dart';
import 'package:thaki/screens/edit_profile_screen.dart';

import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/cards/credit_card.dart';
import 'package:thaki/widgets/general/card.dart';
import 'package:thaki/widgets/general/carousel.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/cards/user_info_card.dart';

class TkProfilePane extends TkPane {
  TkProfilePane({@required this.scaffoldKey, onDone, onSelect})
      : super(
            paneTitle: '',
            navIconData: TkNavIconData(icon: AssetImage(kProfileIcon)),
            onSelect: onSelect);

  final Function scaffoldKey;

  Widget _createPersonalInfo(TkAccount account, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(
            title: S.of(context).kPersonalInfo, icon: kEditCircleBtnIcon,
            // Open add car screen
            action: () async {
              if (await Navigator.of(context)
                      .pushNamed(TkEditProfileScreen.id) ==
                  true) {
                TkSnackBarHelper.show(this.scaffoldKey(), context,
                    S.of(context).kUserProfileUpdated);
              }
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TkUserInfoCard(user: account.user),
        ),
      ],
    );
  }

  List<Widget> _getCarCards(TkAccount account,
      TkAttributesController attributesController, BuildContext context) {
    List<Widget> widgets = [];
    if (account.user.cars != null)
      for (TkCar car in account.user.cars) {
        widgets.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: TkCard(
              onTap: () async {
                await Navigator.of(context).pushNamed(TkCarsListScreen.id);
                //account.load();
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
                        : TkLicenseHelper.formatARLicensePlate(car.plateAR),
                TkCardSide.bottomRight: attributesController.stateName(
                  car.state,
                  Provider.of<TkLangController>(context, listen: false),
                )
              },
            ),
          ),
        );
      }

    return widgets;
  }

  Widget _createCars(TkAccount account,
      TkAttributesController attributesController, BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TkSectionTitle(
          title: S.of(context).kMyCars,
          icon: kAddCircleBtnIcon,
          // Open add car screen
          action: () async {
            await Navigator.of(context).pushNamed(TkAddCarScreen.id);
            //account.load();
          },
        ),

        // Add cars carousel
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkCarousel(
            height: 120,
            dotColor: kPrimaryColor.withOpacity(0.5),
            selectedDotColor: kPrimaryColor,
            emptyMessage: S.of(context).kNoCars,
            children: _getCarCards(account, attributesController, context),
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
                //account.load();
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
            //account.load();
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
    return Consumer2<TkAccount, TkAttributesController>(
        builder: (context, account, attributesController, child) {
      return account.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                _createPersonalInfo(account, context),
                _createCars(account, attributesController, context),
                if (kSaveCardMode) _createCards(account, context),
              ],
            );
    });
  }
}
