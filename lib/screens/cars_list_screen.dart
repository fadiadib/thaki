import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/models/car.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/tiles/car_tile.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkCarsListScreen extends StatefulWidget {
  static const String id = 'cars_screen';

  @override
  _TkCarsListScreenState createState() => _TkCarsListScreenState();
}

class _TkCarsListScreenState extends State<TkCarsListScreen> {
  List<Widget> _getTiles(TkAccount account) {
    List<Widget> tiles = [];

    for (TkCar car in account.user.cars) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
          child: TkCarTile(car: car),
        ),
      );
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(
      builder: (context, account, _) {
        return Scaffold(
          appBar: TkAppBar(
            context: context,
            enableClose: true,
            enableNotifications: false,
            removeLeading: false,
            title: TkLogoBox(),
          ),
          body: TkScaffoldBody(
            child: ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TkSectionTitle(
                    title: kMyCars,
                    icon: kAddCircleBtnIcon,
                    action: () =>
                        Navigator.of(context).pushNamed(TkAddCarScreen.id),
                  ),
                ),
                Column(children: _getTiles(account)),
              ],
            ),
          ),
        );
      },
    );
  }
}
