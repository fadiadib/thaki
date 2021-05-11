import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/utilities/index.dart';
import 'package:thaki/widgets/general/sliddable.dart';

class TkNotificationTile extends StatelessWidget {
  TkNotificationTile({@required this.notification, this.langCode = 'en'});
  final TkNotification notification;
  final String langCode;

  @override
  Widget build(BuildContext context) {
    return Consumer<TkMessenger>(
      builder: (context, messenger, _) {
        return TkSlidableTile(
          onDelete: () async {
            if (await TkDialogHelper.gShowConfirmationDialog(
                    context: context,
                    message: S.of(context).kAreYouSureNotification,
                    type: gDialogType.yesNo) ??
                false) messenger.deleteNotification(notification);
          },
          onSeen: () {
            messenger.updateSeen(notification, !notification.isSeen);
            messenger.showBody(notification, value: false);
          },
          child: GestureDetector(
            onTap: () {
              messenger.showBody(notification);
              if (notification.isSeen == false)
                messenger.updateSeen(notification, true);
            },
            child: AnimatedContainer(
              duration: Duration(milliseconds: 600),

              // Form frame shadow
              decoration: BoxDecoration(
                color: kTileBgColor,
                boxShadow: kTileShadow,
                borderRadius: BorderRadius.circular(4.0),
                border: Border.all(
                    color: !notification.isSeen
                        ? kSecondaryColor
                        : kTransparentColor),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 20.0, vertical: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Card number/expiration
                    Expanded(
                      flex: 5,
                      child: Padding(
                        padding: EdgeInsetsDirectional.only(start: 20.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 5.0),
                              child: Text(
                                notification.title,
                                style: kBoldStyle[kSmallSize]
                                    .copyWith(color: kBlackColor),
                              ),
                            ),
                            Text(
                              notification.short,
                              style: kBoldStyle[kSmallSize]
                                  .copyWith(color: kSemiGreyColor),
                            ),
                            if (notification.showBody &&
                                notification.body.isNotEmpty)
                              Divider(color: kAccentGreyColor, thickness: 1.0),
                            if (notification.showBody &&
                                notification.body.isNotEmpty)
                              Text(
                                notification.body,
                                style: kBoldStyle[kSmallSize],
                              )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
