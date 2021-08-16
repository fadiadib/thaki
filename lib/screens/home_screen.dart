import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:thaki/drawers/menu_drawer.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/panes/home/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/messenger.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/providers/tab_selector.dart';
import 'package:thaki/screens/notification_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkHomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _TkHomeScreenState createState() => _TkHomeScreenState();
}

class _TkHomeScreenState extends State<TkHomeScreen> {
  List<TkPane> _panes = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  List<Image> _getIcons() {
    List<Image> icons = [];
    for (TkPane pane in _panes) {
      icons.add(
        Image(
          image: pane.navIconData.icon,
          height: 24,
          color: kWhiteColor,
        ),
      );
    }

    return icons;
  }

  Future<void> initModel() async {
    // Load user profile here
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    TkBooker booker = Provider.of<TkBooker>(context, listen: false);
    TkPurchaser purchaser = Provider.of<TkPurchaser>(context, listen: false);
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);
    TkAttributesController attributes =
        Provider.of<TkAttributesController>(context, listen: false);

    await attributes.load(langController);
    await booker.loadTickets(account.user);
    await purchaser.loadBalance(account.user);
    await account.loadCars();
    if (kSaveCardMode) await account.loadCards();
  }

  @override
  void initState() {
    super.initState();
    initModel();

    _panes = [
      TkViolationsPane(),
      TkParkingPane(),
      TkDashboardPane(),
      TkTicketsPane(
        onSelect: () =>
            Provider.of<TkBooker>(context, listen: false).cancelError = null,
      ),
      TkProfilePane(scaffoldKey: () => scaffoldKey),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: initModel,
      child: Consumer3<TkTabSelector, TkAccount, TkMessenger>(
        builder: (context, selector, account, messenger, _) {
          return WillPopScope(
            onWillPop: () async {
              if (selector.activeTab == 2) return true;
              selector.activeTab = 2;
              return false;
            },
            child: Scaffold(
              key: scaffoldKey,

              /// Appbar
              appBar: TkAppBar(
                context: context,
                enableClose: false,
                removeLeading: false,
                hasNotifications: messenger.hasNewNotifications,
                onNotificationClick: () =>
                    Navigator.of(context).pushNamed(TkNotificationScreen.id),
                title: TkLogoBox(),
              ),

              /// Bottom Navigation Menu Bar
              bottomNavigationBar: CurvedNavigationBar(
                index: selector.activeTab,
                animationDuration: Duration(milliseconds: 300),
                backgroundColor: kLightGreyColor,
                color: kPrimaryColor,
                buttonBackgroundColor: kSecondaryColor,
                height: 60.0,
                items: _getIcons(),
                onTap: (index) {
                  setState(() => selector.activeTab = index);
                  if (_panes[index].onSelect != null) _panes[index].onSelect();
                },
              ),

              /// Scaffold body: Active pane
              body: TkScaffoldBody(child: _panes[selector.activeTab]),

              // Create the side drawer
              drawer: TkMenuDrawer(
                popParentCallback: () => Navigator.of(context)
                    .pushReplacementNamed(TkWelcomeScreen.id),
              ),
            ),
          );
        },
      ),
    );
  }
}
