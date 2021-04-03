import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/lists/payment_list.dart';

class TkViolationPaymentPane extends TkPane {
  TkViolationPaymentPane({onDone})
      : super(paneTitle: kPayViolations, onDone: onDone);

  Widget _getCheckoutButton(TkPayer payer) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: kCheckout,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        onPressed: () {
          if (payer.validatePayment()) onDone();
        },
      ),
    );
  }

  Widget _getErrorMessage(TkPayer payer) {
    if (payer.validationPaymentError != null)
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
        child: Text(
          payer.validationPaymentError,
          style: kErrorStyle,
          textAlign: TextAlign.center,
        ),
      );
    return Container();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPayer>(builder: (context, payer, _) {
      return payer.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                TkPaymentList(
                  onSelect: (TkCredit card) {
                    payer.selectedCard = card;
                  },
                  selected: payer.selectedCard,
                ),
                _getCheckoutButton(payer),
                _getErrorMessage(payer),
              ],
            );
    });
  }
}
