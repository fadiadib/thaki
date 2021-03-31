import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/lists/car_list.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkCarsListScreen extends StatefulWidget {
  static const String id = 'cars_screen';

  @override
  _TkCarsListScreenState createState() => _TkCarsListScreenState();
}

class _TkCarsListScreenState extends State<TkCarsListScreen> {
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
                TkCarList(cars: account.user.cars),
              ],
            ),
          ),
        );
      },
    );
  }
}
