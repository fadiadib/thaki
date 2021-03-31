import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/package_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/package_tile.dart';

class TkPackageDetailsPane extends TkPane {
  TkPackageDetailsPane({onDone})
      : super(paneTitle: kPurchasePackage, onDone: onDone);

  Widget _getPackageTile(TkPurchaser purchaser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
      child:
          TkPackageTile(package: purchaser.selectedPackage, isSelected: true),
    );
  }

  Widget _getPackageCard(TkPurchaser purchaser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
      child: TkPackageCard(package: purchaser.selectedPackage),
    );
  }

  Widget _getContinueButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(title: kContinue, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPurchaser>(builder: (context, purchaser, _) {
      return purchaser.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TkSectionTitle(title: kPurchasePackage),
                ),
                _getPackageTile(purchaser),
                _getPackageCard(purchaser),
                _getContinueButton(),
              ],
            );
    });
  }
}
