import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/general/error.dart';

import 'dialog_helper.dart';

class TkQRHelper {
  static void showQRCode(
      {required BuildContext context, required TkTicket ticket, Function? loadCallback}) async {
    TkBooker booker = Provider.of<TkBooker>(context, listen: false);
    if (ticket.cancelled == false) {
      booker.loadQRError = null;

      if (ticket.code == null) {
        if (loadCallback != null) loadCallback(true);
        await booker.loadQR(
            Provider.of<TkAccount>(context, listen: false).user!, ticket);
        if (loadCallback != null) loadCallback(false);
      }

      TkDialogHelper.gOpenDrawer(
        context: context,
        drawer: ClipRRect(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(20.0),
            topLeft: Radius.circular(20.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: kWhiteBgLinearGradient,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(20.0),
                topLeft: Radius.circular(20.0),
              ),
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: booker.loadQRError == null
                    ? ticket.code != null
                        ? Container(
                            padding: EdgeInsets.all(10.0),
                            decoration: BoxDecoration(
                              color: kFormBgColor,
                              boxShadow: kTileShadow,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: QrImage(
                              data: ticket.code!,
                              version: QrVersions.auto,
                              size: 380.0,
                            ),
                          )
                        : TkError(message: kUnknownError)
                    : TkError(message: booker.loadQRError),
              ),
            ),
          ),
        ),
      );
    }
  }
}
