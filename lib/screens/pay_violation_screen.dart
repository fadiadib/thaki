import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/panes/transaction/transaction_pane.dart';
import 'package:thaki/panes/transaction/transaction_success_pane.dart';
import 'package:thaki/providers/account.dart';

import 'package:thaki/providers/payer.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/violation/index.dart';

class TkPayViolationScreen extends TkMultiStepPage {
  static const id = 'pay_violation_screen';

  @override
  _TkPayViolationScreenState createState() => _TkPayViolationScreenState();
}

class _TkPayViolationScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    // Load available packages
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkViolationCarPane(onDone: () {
        Provider.of<TkPayer>(context, listen: false).loadViolations(
            Provider.of<TkAccount>(context, listen: false).user);

        loadNextPane();
      }),
      TkViolationListPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);

        if (kSaveCardMode) {
          if (account.user.cards != null && account.user.cards.isNotEmpty)
            Provider.of<TkPayer>(context, listen: false).selectedCard =
                Provider.of<TkAccount>(context, listen: false)
                    .user
                    .cards
                    ?.first;
        } else {
          TkTransactor transactor =
              Provider.of<TkTransactor>(context, listen: false);

          List<int> ids = [];
          for (TkViolation violation
              in Provider.of<TkPayer>(context, listen: false)
                  .selectedViolations) {
            ids.add(violation.id);
          }
          transactor.initTransaction(
              user: account.user, type: 'Violation', ids: ids);
        }

        loadNextPane();
      }),
      // TkViolationPaymentPane(onDone: () {
      //   Provider.of<TkPayer>(context, listen: false).paySelectedViolations();
      //   loadNextPane();
      // }),
      // TkViolationSuccessPane(onDone: () => loadNextPane()),
      TkTransactionPane(
        onDone: () => loadNextPane(),
        onClose: () async {
          if (await TkDialogHelper.gShowConfirmationDialog(
                context: context,
                message: S.of(context).kAreYouSureTransaction,
                type: gDialogType.yesNo,
              ) ??
              false) {
            Provider.of<TkTransactor>(context, listen: false)
                .stopTransactionChecker();

            Navigator.of(context).pop();
          }
        },
      ),
      TkTransactionSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
