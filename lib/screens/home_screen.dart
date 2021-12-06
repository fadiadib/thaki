import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

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
import 'package:thaki/drawers/menu_drawer.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';

class TkHomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _TkHomeScreenState createState() => _TkHomeScreenState();
}

class _TkHomeScreenState extends State<TkHomeScreen> {
  List<TkPane> _panes = [];
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  /// Returns the bottom navigation menu icons
  List<Image> _getIcons() {
    List<Image> icons = [];
    for (TkPane pane in _panes) {
      icons.add(
        Image(image: pane.navIconData!.icon!, height: 24, color: kWhiteColor),
      );
    }

    return icons;
  }

  /// Initializes the model by calling the APIs
  /// also used in the refresh indicator
  Future<void> initModel({bool refresh = true}) async {
    // Load user profile here
    final TkAccount account = Provider.of<TkAccount>(context, listen: false);
    final TkBooker booker = Provider.of<TkBooker>(context, listen: false);
    final TkPurchaser purchaser =
        Provider.of<TkPurchaser>(context, listen: false);
    final TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);
    final TkAttributesController attributes =
        Provider.of<TkAttributesController>(context, listen: false);

    if (refresh == false) {
      // Init mode
      await attributes.load(langController);
      account.load();
      booker.loadTickets(account.user!);
      purchaser.loadBalance(account.user!);
      account.loadCars();
      if (kSaveCardMode) account.loadCards();
    } else {
      // Refresh mode
      final TkTabSelector selector =
          Provider.of<TkTabSelector>(context, listen: false);

      if (selector.isProfile) {
        // Load user, cars and cards
        account.load();
        account.loadCars();
        if (kSaveCardMode) account.loadCards();
      }
      if (selector.isDashboard) {
        // Load tickets and balance
        booker.loadTickets(account.user!);
        purchaser.loadBalance(account.user!);
      }
      if (selector.isBooking || selector.isViolations) {
        // Load cars
        account.loadCars();
      }
    }
  }

  /// Start a loading dialog, called as a callback from
  /// the side menu drawer
  void startLoading(String message) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          content: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 15.0),
                child: Text(
                  message,
                  style: kBoldStyle[kNormalSize]!.copyWith(
                    fontFamily:
                        Provider.of<TkLangController>(context, listen: false)
                            .fontFamily,
                  ),
                ),
              ),
              TkProgressIndicator()
            ],
          ),
        );
      },
    );
  }

  /// Pops the loading dialog, called as a callback from
  /// the side menu drawer
  void stopLoading() => Navigator.of(context).pop();

  @override
  void initState() {
    super.initState();
    initModel(refresh: false);

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
      backgroundColor: kWhiteColor,
      onRefresh: initModel,
      child: Consumer3<TkTabSelector, TkAccount, TkMessenger>(
        builder: (context, selector, account, messenger, _) {
          return WillPopScope(
            onWillPop: () async {
              if (selector.isDashboard) return true;
              selector.selectDashboard();
              return false;
            },
            child: Scaffold(
              key: scaffoldKey,

              // Appbar
              appBar: TkAppBar(
                context: context,
                enableClose: false,
                removeLeading: false,
                hasNotifications: messenger.hasNewNotifications,
                onNotificationClick: () =>
                    Navigator.of(context).pushNamed(TkNotificationScreen.id),
                title: TkLogoBox(),
              ),

              // Bottom Navigation Menu Bar
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
                  if (_panes[index].onSelect != null) _panes[index].onSelect!();
                },
              ),

              // Scaffold body: Active pane
              body: TkScaffoldBody(child: _panes[selector.activeTab]),

              // Create the side drawer
              drawer: TkMenuDrawer(
                popParentCallback: () => Navigator.of(context)
                    .pushReplacementNamed(TkWelcomeScreen.id),
                startLoadingCallback: startLoading,
                stopLoadingCallback: stopLoading,
              ),
            ),
          );
        },
      ),
    );
  }
}
