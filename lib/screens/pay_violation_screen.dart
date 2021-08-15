import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
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
    // Load available packages
  }

  @override
  List<TkPane> getPanes() {
    final user = Provider.of<TkAccount>(context, listen: false).user;
    final langController =
        Provider.of<TkLangController>(context, listen: false);

    return [
      TkViolationCarPane(onDone: () {
        Provider.of<TkPayer>(context, listen: false)
            .loadViolations(user, langController, guest: guest);

        loadNextPane();
      }),
      TkViolationListPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);
        TkTransactor transactor =
            Provider.of<TkTransactor>(context, listen: false);

        List<int> ids = [];
        for (TkViolation violation
            in Provider.of<TkPayer>(context, listen: false)
                .selectedViolations) {
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
