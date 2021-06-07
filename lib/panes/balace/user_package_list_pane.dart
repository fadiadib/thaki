import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/user_package_tile.dart';

class TkUserPackageListPane extends TkPane {
  TkUserPackageListPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getPackageTiles(TkPurchaser purchaser) {
    List<Widget> tiles = [];
    for (TkPackage package in purchaser.userPackages) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          child: TkUserPackageTile(package: package),
        ),
      );
    }
    return Column(children: tiles);
  }

  Widget _getCCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 50.0),
      child: TkButton(title: S.of(context).kClose, onPressed: onDone),
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
                  child: TkSectionTitle(title: S.of(context).kMyPackages),
                ),
                _getPackageTiles(purchaser),
                _getCCloseButton(context),
              ],
            );
    });
  }
}
