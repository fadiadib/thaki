import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/car.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/add_car_screen.dart';
import 'package:thaki/screens/book_parking_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/car_list.dart';

class TkParkingPane extends TkPane {
  TkParkingPane({onDone, onSelect})
      : super(
          paneTitle: '',
          navIconData: TkNavIconData(icon: AssetImage(kParkingIcon)),
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
                  child: TkSectionTitle(title: S.of(context).kChooseCarToBook),
                ),
                TkCarList(
                  langCode:
                      Provider.of<TkLangController>(context, listen: false)
                          .lang!
                          .languageCode,
                  cars: account.user!.cars,
                  onTap: (TkCar car) {
                    // Select the car in the payer provider
                    Provider.of<TkBooker>(context, listen: false).selectedCar =
                        car;

                    // Push book parking screen
                    Navigator.of(context).pushNamed(TkBookParkingScreen.id);
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
                        Icon(
                          kAddCircleBtnIcon,
                          size: 16,
                          color: kPrimaryColor,
                        ),
                        SizedBox(width: 5),
                        Text(S.of(context).kAddCar,
                            style: kBoldStyle[kSmallSize]!
                                .copyWith(color: kPrimaryColor)),
                      ],
                    ),
                  ),
                )
              ],
            );
    });
  }
}
