import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/screens/pay_violation_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/car_list.dart';

class TkViolationsPane extends TkPane {
  TkViolationsPane({onDone, onSelect})
      : super(
          paneTitle: 'Violations',
          navIconData: TkNavIconData(icon: kViolationBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(builder: (context, account, child) {
      return account.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: TkSectionTitle(title: kPayViolations),
                ),
                TkCarList(
                  cars: account.user.cars,
                  onTap: (TkCar car) {
                    // Select the car in the payer provider
                    Provider.of<TkPayer>(context, listen: false).selectedCar =
                        car;

                    // Push the pay violations screen
                    Navigator.of(context).pushNamed(TkPayViolationScreen.id);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GestureDetector(
                    onTap: () {
                      // Push the pay violations screen
                      Navigator.of(context).pushNamed(TkPayViolationScreen.id);
                    },
                    child: Center(
                        child: Text(
                      kCheckForLPR,
                      style: kRegularStyle[kNormalSize].copyWith(
                        color: kPrimaryColor,
                      ),
                    )),
                  ),
                )
              ],
            );
    });
  }
}
