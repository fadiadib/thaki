import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/providers/messenger.dart';

import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/lists/notification_list.dart';

class TkNotificationScreen extends StatefulWidget {
  static const id = 'notification_screen';

  @override
  _TkNotificationScreenState createState() => _TkNotificationScreenState();
}

class _TkNotificationScreenState extends State<TkNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TkMessenger>(builder: (context, messenger, _) {
      return Scaffold(
        appBar: TkAppBar(
          context: context,
          enableClose: true,
          enableNotifications: false,
          removeLeading: false,
          title: TkLogoBox(),
        ),
        body: TkScaffoldBody(
          child: TkNotificationList(notifications: messenger.notifications),
        ),
      );
    });
  }
}
