import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/panes/home/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkHomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _TkHomeScreenState createState() => _TkHomeScreenState();
}

class _TkHomeScreenState extends State<TkHomeScreen> {
  List<TkPane> _panes = [];
  int _activePane = 2;

  List<Icon> _getIcons() {
    List<Icon> icons = [];
    for (TkPane pane in _panes) {
      icons.add(
        Icon(
          pane.navIconData.icon,
          size: 24,
          color: kWhiteColor,
        ),
      );
    }

    return icons;
  }

  @override
  void initState() {
    super.initState();

    // TODO: Load user profile here
    TkUser user = Provider.of<TkAccount>(context, listen: false).user;

    // Load user tickets and balance
    TkBooker booker = Provider.of<TkBooker>(context, listen: false);
    booker.loadTickets(user);
    booker.loadBalance(user);

    _panes = [
      TkViolationsPane(),
      TkParkingPane(),
      TkDashboardPane(),
      TkTicketsPane(),
      TkProfilePane(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      /// Appbar
      appBar: TkAppBar(
        context: context,
        enableClose: false,
        removeLeading: false,
        title: TkLogoBox(),
      ),

      /// Bottom Navigation Menu Bar
      bottomNavigationBar: CurvedNavigationBar(
        index: _activePane,
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: kLightGreyColor,
        color: kPrimaryColor,
        buttonBackgroundColor: kSecondaryColor,
        height: 60.0,
        items: _getIcons(),
        onTap: (index) => setState(() => _activePane = index),
      ),

      /// Scaffold body: Active pane
      body: TkScaffoldBody(
        child: _panes[_activePane],
      ),
    );
  }
}
