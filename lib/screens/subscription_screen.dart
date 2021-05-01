import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/screens/apply_subscription_screen.dart';
import 'package:thaki/screens/buy_subscription_screen.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/car_list.dart';

class TkSubscriptionScreen extends StatefulWidget {
  static const id = 'subscription_screen';

  @override
  _TkSubscriptionScreenState createState() => _TkSubscriptionScreenState();
}

class _TkSubscriptionScreenState extends State<TkSubscriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer2<TkAccount, TkSubscriber>(
      builder: (context, account, subscriber, _) {
        return Scaffold(
          appBar: TkAppBar(
            context: context,
            enableNotifications: false,
            enableClose: true,
            removeLeading: false,
            title: TkLogoBox(),
          ),
          body: TkScaffoldBody(
            child: ListView(children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20.0),
                child:
                    TkSectionTitle(title: S.of(context).kChooseCarToSubscribe),
              ),
              TkCarList(
                showRibbon: true,
                langCode: Provider.of<TkLangController>(context, listen: false)
                    .lang
                    .languageCode,
                cars: account.user.cars,
                onTap: (TkCar car) async {
                  if (car.isApproved == 0) {
                    // No subscription, so apply
                    subscriber.selectedCar = car;
                    await Navigator.pushNamed(
                        context, TkApplyForSubscriptionScreen.id);
                    Navigator.of(context).pop();
                  } else if (car.isApproved == 1) {
                    // Subscription approved, so buy
                    subscriber.selectedCar = car;
                    await Navigator.pushNamed(
                        context, TkBuySubscriptionScreen.id);
                    Navigator.of(context).pop();
                  }
                },
              ),
            ]),
          ),
        );
      },
    );
  }
}
