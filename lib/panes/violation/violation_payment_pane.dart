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

  Widget _getCheckoutButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(
        title: kCheckout,
        onPressed: onDone,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
      ),
    );
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
                _getCheckoutButton(),
              ],
            );
    });
  }
}
