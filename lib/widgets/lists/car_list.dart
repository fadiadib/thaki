import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/car_tile.dart';

class TkCarList extends StatelessWidget {
  TkCarList({
    this.cars,
    this.onTap,
    this.onDelete,
    this.onEdit,
    this.langCode,
    this.showRibbon = false,
  });
  final List<TkCar>? cars;
  final Function? onTap;
  final Function? onDelete;
  final Function? onEdit;
  final String? langCode;
  final bool showRibbon;

  List<Widget> _getCarTiles(BuildContext context) {
    List<Widget> tiles = [];

    if (cars == null || cars!.isEmpty) {
      tiles.add(Center(child: Text(S.of(context).kNoCars, style: kHintStyle)));
    } else {
      for (TkCar car in cars!) {
        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: TkCarTile(
              langCode: langCode,
              car: car,
              onTap: onTap,
              onDelete: onDelete,
              onEdit: onEdit,
              showRibbon: showRibbon,
            ),
          ),
        );
      }
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _getCarTiles(context));
  }
}
