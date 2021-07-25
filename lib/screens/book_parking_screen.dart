import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/panes/parking/index.dart';
import 'package:thaki/panes/transaction/transaction_pane.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/utilities/dialog_helper.dart';
import 'package:thaki/widgets/base/index.dart';

class TkBookParkingScreen extends TkMultiStepPage {
  static const id = 'book_parking_screen';

  @override
  _TkBookParkingScreenState createState() => _TkBookParkingScreenState();
}

class _TkBookParkingScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    Provider.of<TkBooker>(context, listen: false).clearBooking();
  }

  @override
  List<TkPane> getPanes() {
    List<TkPane> panes = [
      TkParkingTimePane(onDone: () => loadNextPane()),
      TkParkingDurationPane(onDone: () {
        // Book parking
        TkBooker booker = Provider.of<TkBooker>(context, listen: false);
        if (booker.creditMode) {
          booker.reserveParking(
              Provider.of<TkAccount>(context, listen: false).user);
        }

        if (!booker.creditMode && !kSaveCardMode) {
          TkTransactor transactor =
              Provider.of<TkTransactor>(context, listen: false);

          transactor.initTransaction(
            user: Provider.of<TkAccount>(context, listen: false).user,
            type: 'Booking',
            car: booker.selectedCar,
            dateTime: booker.bookDate,
            duration: booker.bookDuration,
          );
        }

        // Load next screen
        loadNextPane(advance: booker.creditMode);
      }),
    ];

    if (kSaveCardMode) {
      panes.add(TkParkingPaymentPane(onDone: () {
        // Book parking
        TkBooker booker = Provider.of<TkBooker>(context, listen: false);
        booker.reserveParking(
            Provider.of<TkAccount>(context, listen: false).user);

        // Load next screen
        loadNextPane();
      }));
      panes.add(
        TkParkingSuccessPane(
          onDone: () {
            Provider.of<TkPurchaser>(context, listen: false).loadBalance(
                Provider.of<TkAccount>(context, listen: false).user);
            loadNextPane();
          },
        ),
      );
    } else {
      panes.add(
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
      );
      panes.add(
        TkParkingSuccessPane(
          onDone: () {
            Provider.of<TkPurchaser>(context, listen: false).loadBalance(
                Provider.of<TkAccount>(context, listen: false).user);
            loadNextPane();
          },
        ),
      );
    }

    return panes;
  }
}
