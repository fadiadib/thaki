import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/utilities/dialog_helper.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/payment_list.dart';
import 'package:thaki/widgets/tiles/subscription_tile.dart';

class TkSubscriptionPaymentPane extends TkPane {
  TkSubscriptionPaymentPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getSubscriptionTile(TkSubscriber subscriber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
      child: TkSubscriptionTile(
          subscription: subscriber.selectedSubscription, isSelected: true),
    );
  }

  void _openCVVDrawer(BuildContext context) {
    TkSubscriber subscriber = Provider.of<TkSubscriber>(context, listen: false);

    TkDialogHelper.gOpenDrawer(
      context: context,
      drawer: ClipRRect(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(20.0),
          topLeft: Radius.circular(20.0),
        ),
        child: Container(
          decoration: BoxDecoration(
            color: kWhiteColor,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.0),
              topLeft: Radius.circular(20.0),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: TkTextField(
                  hintText: S.of(context).kCardCVV,
                  errorMessage:
                      S.of(context).kPleaseEnter + ' ' + S.of(context).kCardCVV,
                  validator: () =>
                      TkValidationHelper.validateNotEmpty(subscriber.cvv),
                  validate: true,
                  onChanged: (String value) => subscriber.cvv = value,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 50.0, end: 50.0, bottom: 50.0),
                child: TkButton(
                  title: S.of(context).kCheckout,
                  onPressed: () {
                    if (subscriber.cvv != null && subscriber.cvv.isNotEmpty) {
                      Navigator.of(context).pop();
                      onDone();
                    }
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _getCheckoutButton(TkSubscriber subscriber, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: S.of(context).kCheckout,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        onPressed: () {
          if (subscriber.validatePayment(context)) _openCVVDrawer(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkSubscriber, TkAccount>(
        builder: (context, subscriber, account, _) {
      return subscriber.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TkSectionTitle(title: S.of(context).kBuySubscription),
                ),
                _getSubscriptionTile(subscriber),
                TkPaymentList(
                  cards: account.user.cards,
                  onTap: (TkCredit card) => subscriber.selectedCard = card,
                  selected: subscriber.selectedCard,
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TkAddCardScreen.id),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(kAddCircleBtnIcon, size: 16, color: kPrimaryColor),
                        SizedBox(width: 5),
                        Text(S.of(context).kAddCard,
                            style: kBoldStyle[kSmallSize]
                                .copyWith(color: kPrimaryColor)),
                      ],
                    ),
                  ),
                ),
                _getCheckoutButton(subscriber, context),
                TkError(message: subscriber.validationPaymentError),
              ],
            );
    });
  }
}
