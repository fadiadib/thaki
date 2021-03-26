import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:store_redirect/store_redirect.dart';

import 'package:thaki/globals/index.dart';

enum gDialogType {
  confirmCancel,
  yesNo,
  confirm,
  upgrade,
  agree,
  agreeDisagree,
}

const Map<gDialogType, Set<String>> gDialogBtnText = {
  gDialogType.confirmCancel: {kConfirm, kCancel},
  gDialogType.yesNo: {kYes, kNo},
  gDialogType.confirm: {kConfirm},
  gDialogType.upgrade: {kUpgradeNow},
  gDialogType.agree: {kAgree},
  gDialogType.agreeDisagree: {kAgree, kDisagree},
};

class TkDialogHelper {
  static List<Widget> _getButtons(BuildContext context, gDialogType type) {
    List<Widget> widgets = [];

    if (type == gDialogType.upgrade) {
      widgets.add(
        MaterialButton(
          child: Text(kUpgradeNow, style: kRegularStyle[kNormalSize]),
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
          child: Text(gDialogBtnText[type].first,
              style: kRegularStyle[kNormalSize]),
          onPressed: () => Navigator.pop(context, true),
        ),
      );

      if (addCancelBtn) {
        widgets.add(
          MaterialButton(
            child: Text(gDialogBtnText[type].last,
                style: kRegularStyle[kNormalSize]),
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
          title: Center(child: Text(message, style: kBoldStyle[kNormalSize])),

          // Content if applicable
          content: content != null
              ? Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(content,
                      style: kRegularStyle[kSmallSize], textAlign: align),
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
      message: kUnsupportedVersion,
      content: kUpgradeRequiredMessage,
      type: gDialogType.upgrade,
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
