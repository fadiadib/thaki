import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/panes/transaction/transaction_pane.dart';
import 'package:thaki/panes/transaction/transaction_success_pane.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/utilities/dialog_helper.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/package/index.dart';

class TkBuyPackageScreen extends TkMultiStepPage {
  static const id = 'purchase_package_screen';

  @override
  _TkBuyPackageScreenState createState() => _TkBuyPackageScreenState();
}

class _TkBuyPackageScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    // Load available packages
    Provider.of<TkPurchaser>(context, listen: false)
        .loadPackages(Provider.of<TkAccount>(context, listen: false).user);
  }

  @override
  List<TkPane> getPanes() {
    List<TkPane> panes = [
      TkPackageListPane(onDone: () => loadNextPane()),
      TkPackageDetailsPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);

        if (kSaveCardMode) {
          if (account.user.cards != null && account.user.cards.isNotEmpty)
            Provider.of<TkPurchaser>(context, listen: false).selectedCard =
                account.user.cards?.first;
        } else {
          TkTransactor transactor =
              Provider.of<TkTransactor>(context, listen: false);
          transactor.initTransaction(
              user: account.user,
              type: 'Package',
              id: Provider.of<TkPurchaser>(context, listen: false)
                  .selectedPackage
                  .id);
        }

        loadNextPane();
      })
    ];

    if (kSaveCardMode) {
      panes.add(
        TkPackagePaymentPane(
          onDone: () {
            // Perform purchase by calling the API
            Provider.of<TkPurchaser>(context, listen: false)
                .purchaseSelectedPackage(
                    Provider.of<TkAccount>(context, listen: false).user);

            // Load next pane
            loadNextPane();
          },
        ),
      );
      panes.add(TkPackageSuccessPane(onDone: () => loadNextPane()));
    } else {
      panes.add(
        TkTransactionPane(
          onDone: () {
            // Update balance
            Provider.of<TkPurchaser>(context, listen: false).loadBalance(
                Provider.of<TkAccount>(context, listen: false).user);
            loadNextPane();
          },
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
      );
      panes.add(TkTransactionSuccessPane(onDone: () => loadNextPane()));
    }

    return panes;
  }
}
