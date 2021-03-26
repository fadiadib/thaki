import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

import 'package:thaki/globals/colors.dart';
import 'package:thaki/panes/home/index.dart';
import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/pane.dart';
import 'package:thaki/widgets/base/scaffold.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkHomeScreen extends StatefulWidget {
  static const String id = 'home_screen';

  @override
  _TkHomeScreenState createState() => _TkHomeScreenState();
}

class _TkHomeScreenState extends State<TkHomeScreen> {
  List<TkPane> _panes = [];
  int _activePane = 0;

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

    _panes = [
      TkViolationsPane(),
      TkParkingPane(),
      TkDashboardPane(),
      TkBalancePane(),
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
        animationDuration: Duration(milliseconds: 300),
        backgroundColor: kTransparentColor,
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
