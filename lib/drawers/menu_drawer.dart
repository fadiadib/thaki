import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/versioner.dart';
import 'package:thaki/widgets/general/list_menu_item.dart';

/// Home Side drawer
/// Has two parts, a header that shows basic profile information
/// and a list of menu items such as settings..etc.
class TkMenuDrawer extends StatelessWidget {
  TkMenuDrawer({this.popParentCallback, this.subscriptionCallback});
  final Function popParentCallback;
  final Function subscriptionCallback;

  String _getSubscriptionBtnTitle(TkUser user, BuildContext context) {
    if (user.isApproved == 0) return S.of(context).kApplySubscription;
    if (user.isApproved == 1) return S.of(context).kBuySubscription;
    if (user.isApproved == 2) return S.of(context).kYourRequestIsPending;
    return S.of(context).kYourRequestIsDeclined;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkVersioner, TkAccount>(
      builder: (context, versioner, account, _) {
        return Drawer(
          child: Container(
            decoration: BoxDecoration(
              gradient: kWhiteBgLinearGradient,
              image: DecorationImage(
                  image: AssetImage(kFooter), fit: BoxFit.cover),
            ),

            // Create a list view, to allow for scrolling
            child: ListView(
              // Remove any padding the drawer
              padding: EdgeInsets.only(top: 0.0),
              children: <Widget>[
                // Create the header (shows basic profile info)
                DrawerHeader(
                  decoration: BoxDecoration(
                    gradient: kWhiteBgLinearGradient,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      decoration: BoxDecoration(
                        color: kFormBgColor,
                        boxShadow: kTileShadow,
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Image(width: 200, image: AssetImage(kLogoPath)),
                      ),
                    ),
                  ),
                ),

                Divider(thickness: 0.5, height: 1),

                // Switch language menu item
                TkListMenuItem(
                  pop: false,
                  title: S.of(context).kSwitchLanguage,
                  child: Icon(kCarouselForwardBtnIcon,
                      color: kMediumGreyColor, size: 10),
                  textStyle: kRegularStyle[kNormalSize]
                      .copyWith(fontFamily: kRTLFontFamily),
                  action: () {
                    TkAccount account =
                        Provider.of<TkAccount>(context, listen: false);
                    Provider.of<TkLangController>(context, listen: false)
                        .switchLang();
                    account.user.lang =
                        Provider.of<TkLangController>(context, listen: false)
                            .lang;
                    account.load();
                    Provider.of<TkBooker>(context, listen: false)
                        .loadTickets(account.user);

                    Navigator.of(context).pop();
                  },
                ),

                // Logout menu item
                TkListMenuItem(
                  pop: false,
                  title: S.of(context).kLogOut,
                  // child: Icon(kCarouselForwardBtnIcon,
                  //     color: kMediumGreyColor, size: 10),
                  textStyle: kRegularStyle[kNormalSize],
                  action: () async {
                    if (await account.logout()) popParentCallback();
                  },
                ),

                // Subscription menu item
                TkListMenuItem(
                  pop: false,
                  title: _getSubscriptionBtnTitle(account.user, context),
                  child: Icon(kCarouselForwardBtnIcon,
                      color: kMediumGreyColor, size: 10),
                  textStyle: account.user.isApproved == 0 ||
                          account.user.isApproved == 1
                      ? kRegularStyle[kNormalSize]
                      : kRegularStyle[kNormalSize]
                          .copyWith(color: kDarkGreyColor.withOpacity(0.5)),
                  action: subscriptionCallback,
                ),

                // Support menu item
                TkListMenuItem(
                  title: S.of(context).kSupport,
                  child: Icon(kCarouselForwardBtnIcon,
                      color: kMediumGreyColor, size: 10),
                  textStyle: kRegularStyle[kNormalSize],
                  action: () {},
                ),

                // Privacy menu item
                TkListMenuItem(
                  title: S.of(context).kPrivacyPolicy,
                  child: Icon(kCarouselForwardBtnIcon,
                      color: kMediumGreyColor, size: 10),
                  textStyle: kRegularStyle[kNormalSize],
                  action: () {},
                ),

                // Copyright and version
                if (versioner.version != null && versioner.build != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 30),
                    child: Column(
                      children: [
                        Text(
                          '©' +
                              DateTime.now().year.toString() +
                              ' ' +
                              S.of(context).kAppTitle,
                          style: kBoldStyle[kNormalSize]
                              .copyWith(color: kPrimaryColor),
                        ),
                        Text(
                          S.of(context).kAllRightsReserved,
                          style: kRegularStyle[kSmallSize],
                        ),
                        Text(
                          '${S.of(context).kVersion} ${versioner.version} (${versioner.build})',
                          style: kRegularStyle[kSmallSize],
                        )
                      ],
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}