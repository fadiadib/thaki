import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/screens/add_card_screen.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/lists/payment_list.dart';

class TkViolationPaymentPane extends TkPane {
  TkViolationPaymentPane({onDone}) : super(paneTitle: '', onDone: onDone);

  void _openCVVDrawer(BuildContext context) {
    TkPayer payer = Provider.of<TkPayer>(context, listen: false);

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
                      TkValidationHelper.validateNotEmpty(payer.cvv),
                  onChanged: (String value) => payer.cvv = value,
                ),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                    start: 50.0, end: 50.0, bottom: 50.0),
                child: TkButton(
                  title: S.of(context).kCheckout,
                  onPressed: () {
                    if (payer.cvv != null && payer.cvv.isNotEmpty) {
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

  Widget _getCheckoutButton(TkPayer payer, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: S.of(context).kCheckout,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        onPressed: () {
          if (payer.validatePayment(context)) _openCVVDrawer(context);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkPayer, TkAccount>(builder: (context, payer, account, _) {
      return payer.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                TkPaymentList(
                  cards: account.user.cards,
                  onTap: (TkCredit card) => payer.selectedCard = card,
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
                _getCheckoutButton(payer, context),
                TkError(message: payer.validationPaymentError),
              ],
            );
    });
  }
}
