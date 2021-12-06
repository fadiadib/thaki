import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/pay_violation_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/car_list.dart';

class TkViolationsPane extends TkPane {
  TkViolationsPane({onDone, onSelect})
      : super(
          paneTitle: '',
          navIconData: TkNavIconData(icon: AssetImage(kViolationsIcon)),
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
                  child: TkSectionTitle(
                      title: S.of(context).kChooseCarToPayViolations),
                ),
                TkCarList(
                  langCode:
                      Provider.of<TkLangController>(context, listen: false)
                          .lang!
                          .languageCode,
                  cars: account.user!.cars,
                  onTap: (TkCar car) {
                    // Select the car in the payer provider
                    TkPayer payer =
                        Provider.of<TkPayer>(context, listen: false);
                    payer.selectedCar = car;
                    payer.allowChange = false;

                    // Push the pay violations screen
                    Navigator.of(context).pushNamed(TkPayViolationScreen.id);
                  },
                ),
                GestureDetector(
                  onTap: () =>
                      Navigator.of(context).pushNamed(TkAddCarScreen.id),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(kAddCircleBtnIcon, size: 16, color: kPrimaryColor),
                        SizedBox(width: 5),
                        Text(S.of(context).kAddCar,
                            style: kBoldStyle[kSmallSize]!
                                .copyWith(color: kPrimaryColor)),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 50.0, vertical: 20.0),
                  child: TkButton(
                    title: S.of(context).kCheckForLPR,
                    onPressed: () {
                      // Select an empty car in the payer provider
                      TkPayer payer =
                          Provider.of<TkPayer>(context, listen: false);
                      payer.selectedCar = TkCar.fromJson({});
                      payer.allowChange = true;

                      // Push the pay violations screen
                      Navigator.of(context).pushNamed(TkPayViolationScreen.id);
                    },
                  ),
                ),
              ],
            );
    });
  }
}
