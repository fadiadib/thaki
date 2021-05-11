import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/lang_controller.dart';

enum gDialogType {
  confirmCancel,
  yesNo,
  confirm,
  upgrade,
  agree,
  agreeDisagree,
}

class TkDialogHelper {
  static String _getButtonText(
      BuildContext context, gDialogType type, int idx) {
    switch (type) {
      case gDialogType.confirm:
      case gDialogType.confirmCancel:
        return idx == 0 ? S.of(context).kConfirm : S.of(context).kCancel;
      case gDialogType.yesNo:
        return idx == 0 ? S.of(context).kYes : S.of(context).kNo;
      case gDialogType.upgrade:
        return S.of(context).kUpgradeNow;
      case gDialogType.agree:
      case gDialogType.agreeDisagree:
        return idx == 0 ? S.of(context).kAgree : S.of(context).kDisagree;
    }

    return '';
  }

  static List<Widget> _getButtons(BuildContext context, gDialogType type) {
    List<Widget> widgets = [];

    if (type == gDialogType.upgrade) {
      widgets.add(
        MaterialButton(
          child: Text(S.of(context).kUpgradeNow,
              style: kRegularStyle[kNormalSize].copyWith(color: kBlackColor)),
          onPressed: () {
            Navigator.pop(context, true);
            StoreRedirect.redirect(
                androidAppId: kAndroidAppId, iOSAppId: kIOSAppId);
          },
        ),
      );
    } else {
      bool addCancelBtn = true;
      switch (type) {
        case gDialogType.confirm:
        case gDialogType.agree:
          addCancelBtn = false;
          break;
        default:
          addCancelBtn = true;
          break;
      }

      widgets.add(
        MaterialButton(
          child: Text(_getButtonText(context, type, 0),
              style: kRegularStyle[kNormalSize].copyWith(color: kBlackColor)),
          onPressed: () => Navigator.pop(context, true),
        ),
      );

      if (addCancelBtn) {
        widgets.add(
          MaterialButton(
            child: Text(_getButtonText(context, type, 1),
                style: kRegularStyle[kNormalSize].copyWith(color: kBlackColor)),
            onPressed: () => Navigator.pop(context, false),
          ),
        );
      }
    }

    return widgets;
  }

  static Future<bool> gShowConfirmationDialog({
    @required BuildContext context,
    @required String message,
    String content,
    gDialogType type = gDialogType.confirmCancel,
    TextAlign align = TextAlign.center,
    bool barrierDismissible = true,
  }) async {
    return await showDialog(
      barrierDismissible: barrierDismissible,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          // Title message
          title: Center(
            child: Text(
              message,
              style: kBoldStyle[kNormalSize].copyWith(
                  fontFamily:
                      Provider.of<TkLangController>(context, listen: false)
                          .fontFamily),
            ),
          ),

          // Content if applicable
          content: content != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(content,
                      style: kRegularStyle[kSmallSize].copyWith(
                          fontFamily: Provider.of<TkLangController>(context,
                                  listen: false)
                              .fontFamily),
                      textAlign: align),
                )
              : Container(),

          // Action buttons
          actions: _getButtons(context, type),
        );
      },
    );
  }

  static Future<bool> gShowUpgradeDialog(
      {@required BuildContext context}) async {
    return gShowConfirmationDialog(
      context: context,
      message: S.of(context).kUnsupportedVersion,
      content: S.of(context).kUpgradeRequiredMessage,
      type: gDialogType.upgrade,
      barrierDismissible: false,
    );
  }

  static Future<bool> gOpenDrawer({
    @required BuildContext context,
    @required Widget drawer,
  }) async {
    // Create a modal bottom sheet
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(ctx).viewInsets.bottom),

          // Create the drawer child widget
          child: drawer,
        ),
      ),
    );
  }
}
