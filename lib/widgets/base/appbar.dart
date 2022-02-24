import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/lang_controller.dart';

/// AppBar subclass that removes elevation, bg color and leading widget
/// adds a close button that does a navigation pop
class TkAppBar extends AppBar {
  TkAppBar({
    @required this.context,
    this.enableNotifications = true,
    this.hasNotifications = false,
    this.enableClose = true,
    this.removeLeading = true,
    this.leading,
    this.closeCallback,
    this.title,
    this.onNotificationClick,
  }) : super(
          centerTitle: true,
          backgroundColor: kTransparentColor,
          foregroundColor: kDarkGreyColor,
          title: title,
          elevation: 0,
          automaticallyImplyLeading: !removeLeading,
          leading: !removeLeading
              ? null
              : leading == null
                  ? Container()
                  : leading,
          actions: <Widget>[
            enableClose
                ? IconButton(
                    icon: Icon(kCloseBtnIcon),
                    color: kPrimaryIconColor,
                    iconSize: kAppbarIconsSize,
                    onPressed: closeCallback ?? () => Navigator.pop(context),
                  )
                : Container(),
            enableNotifications
                ? Stack(
                    children: [
                      IconButton(
                        icon: Icon(kNotificationBtnIcon),
                        color: kPrimaryIconColor,
                        iconSize: kAppbarIconsSize,
                        onPressed: onNotificationClick,
                      ),
                      hasNotifications
                          ? Positioned(
                              // Show an indicator with the number or notifications
                              top: 12.0,
                              right: Provider.of<TkLangController>(context,
                                          listen: false)
                                      .isRTL
                                  ? null
                                  : 12.0,
                              left: Provider.of<TkLangController>(context,
                                          listen: false)
                                      .isRTL
                                  ? 12.0
                                  : null,
                              child: Container(
                                decoration: BoxDecoration(
                                    color: kTertiaryColor,
                                    shape: BoxShape.circle),
                                child:
                                    Padding(padding: const EdgeInsets.all(5)),
                              ),
                            )
                          : Container(),
                    ],
                  )
                : Container(),
          ],
        );

  final BuildContext context;
  final bool enableClose;
  final bool enableNotifications;
  final bool hasNotifications;
  final bool removeLeading;
  final Function closeCallback;
  final Widget leading;
  final Widget title;
  final Function onNotificationClick;
}
