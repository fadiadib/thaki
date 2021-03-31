import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/package_tile.dart';

class TkPackageSuccessPane extends TkPane {
  TkPackageSuccessPane({onDone})
      : super(
            paneTitle: kPurchasePackage,
            onDone: onDone,
            allowNavigation: false);

  Widget _getPackageTile(TkPurchaser purchaser) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
      child:
          TkPackageTile(package: purchaser.selectedPackage, isSelected: true),
    );
  }

  Widget _getCloseButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(title: kClose, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPurchaser>(
      builder: (context, purchaser, _) {
        return purchaser.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: kPurchasePackage),
                  ),

                  // Show the selected package
                  _getPackageTile(purchaser),

                  // Result is dependent on the purchaser result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: purchaser.purchaseError == null
                          ? kPurchaseSuccess
                          : purchaser.purchaseError,
                      result: purchaser.purchaseError == null,
                    ),
                  ),
                  _getCloseButton(),
                ],
              );
      },
    );
  }
}
