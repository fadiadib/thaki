import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/tiles/package_tile.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPackageListPane extends TkPane {
  TkPackageListPane({onDone})
      : super(paneTitle: kPurchasePackage, onDone: onDone);

  Widget _getPackageTiles(TkPurchaser purchaser) {
    List<Widget> tiles = [];
    for (TkPackage package in purchaser.packages) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          child: TkPackageTile(
            package: package,
            isSelected: purchaser.selectedPackage == package,
            onTap: () {
              // Save the selected package in the model provider
              purchaser.selectedPackage = package;
            },
          ),
        ),
      );
    }
    return Column(children: tiles);
  }

  Widget _getContinueButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
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
                _getPackageTiles(purchaser),
                _getContinueButton(),
              ],
            );
    });
  }
}
