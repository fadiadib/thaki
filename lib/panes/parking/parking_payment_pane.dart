import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/credit.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/lists/payment_list.dart';

class TkParkingPaymentPane extends TkPane {
  TkParkingPaymentPane({onDone}) : super(paneTitle: '', onDone: onDone);
  void _openCVVDrawer(BuildContext context, TkBooker booker) {
    booker.cvv = null;

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
                  validate: true,
                  validator: () =>
                      TkValidationHelper.validateNotEmpty(booker.cvv),
                  onChanged: (String value) => booker.cvv = value,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 50.0, end: 50.0, bottom: 50.0),
                child: TkButton(
                  title: S.of(context).kCheckout,
                  onPressed: () {
                    if (booker.cvv != null && booker.cvv!.isNotEmpty) {
                      Navigator.of(context).pop();
                      onDone!();
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

  Widget _getCheckoutButton(TkBooker booker, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: S.of(context).kCheckout,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        onPressed: () {
          if (booker.validatePayment(context)) _openCVVDrawer(context, booker);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkBooker, TkAccount>(
        builder: (context, booker, account, _) {
      return booker.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                TkPaymentList(
                  langCode:
                      Provider.of<TkLangController>(context, listen: false)
                          .lang!
                          .languageCode,
                  cards: account.user!.cards,
                  onTap: (TkCredit card) => booker.selectedCard = card,
                  selected: booker.selectedCard,
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
                            style: kBoldStyle[kSmallSize]!
                                .copyWith(color: kPrimaryColor)),
                      ],
                    ),
                  ),
                ),
                _getCheckoutButton(booker, context),
                TkError(message: booker.validationPaymentError),
              ],
            );
    });
  }
}
