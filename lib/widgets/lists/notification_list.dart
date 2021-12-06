import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/notification_tile.dart';

class TkNotificationList extends StatelessWidget {
  TkNotificationList({this.notifications, this.langCode = 'en'});
  final List<TkNotification>? notifications;
  final String langCode;

  Widget _getNotificationsList(BuildContext context) {
    List<Widget> tiles = [];
    TkMessenger messenger = Provider.of<TkMessenger>(context, listen: false);

    if (notifications == null || notifications!.isEmpty) {
      return Center(
        child: Text(S.of(context).kNoNotifications, style: kHintStyle),
      );
    } else {
      tiles.add(
        Padding(
          padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
          child: TkSectionTitle(
            title: S.of(context).kMyNotifications,
            icon: kDeleteCircleBtnIcon,
            action: () async {
              if (await TkDialogHelper.gShowConfirmationDialog(
                    context: context,
                    message: S.of(context).kAreYouSureAllNotification,
                    type: gDialogType.yesNo,
                  ) ??
                  false) messenger.clearNotifications();
            },
          ),
        ),
      );
      for (TkNotification notification in notifications!) {
        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: TkNotificationTile(
                langCode: langCode, notification: notification),
          ),
        );
      }
    }

    return ListView(children: tiles);
  }

  @override
  Widget build(BuildContext context) {
    return _getNotificationsList(context);
  }
}
