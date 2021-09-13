import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/panes/transaction/transaction_pane.dart';
import 'package:thaki/panes/transaction/transaction_success_pane.dart';
import 'package:thaki/panes/violation/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/base/index.dart';

class TkPayViolationScreen extends TkMultiStepPage {
  static const id = 'pay_violation_screen';
  TkPayViolationScreen({this.guest = false});
  final bool guest;

  @override
  _TkPayViolationScreenState createState() =>
      _TkPayViolationScreenState(guest: guest);
}

class _TkPayViolationScreenState extends TkMultiStepPageState {
  _TkPayViolationScreenState({this.guest = false});
  final bool guest;

  @override
  void initData() async {
    final TkPayer payer = Provider.of<TkPayer>(context, listen: false);

    if (!payer.allowChange)
      payer.loadViolations(Provider.of<TkAccount>(context, listen: false).user,
          Provider.of<TkLangController>(context, listen: false),
          guest: guest, all: kShowAllViolations);
  }

  @override
  List<TkPane> getPanes() {
    final TkAccount account = Provider.of<TkAccount>(context, listen: false);
    final TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);
    final TkPayer payer = Provider.of<TkPayer>(context, listen: false);
    final TkTransactor transactor =
        Provider.of<TkTransactor>(context, listen: false);

    return [
      if (payer.allowChange)
        TkViolationCarPane(onDone: () {
          payer.loadViolations(account.user, langController,
              guest: guest, all: kShowAllViolations);

          loadNextPane();
        }),
      TkViolationListPane(onDone: () {
        List<int> ids = [];
        for (TkViolation violation in payer.selectedViolations) {
          ids.add(violation.id);
        }
        transactor.initTransaction(
          user: account.user,
          type: 'Violation',
          ids: ids,
          langController: langController,
          guest: guest,
        );

        loadNextPane();
      }),
      TkTransactionPane(
        guest: guest,
        onDone: () => loadNextPane(),
        onClose: () async {
          if (await TkDialogHelper.gShowConfirmationDialog(
                context: context,
                message: S.of(context).kAreYouSureTransaction,
                type: gDialogType.yesNo,
              ) ??
              false) {
            transactor.stopTransactionChecker();

            Navigator.of(context).pop();
          }
        },
      ),
      TkTransactionSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
