import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/violation_tile.dart';

class TkViolationList extends StatelessWidget {
  TkViolationList({required this.violations, this.onTap, this.selection});
  final List<TkViolation> violations;
  final List<TkViolation>? selection;
  final Function? onTap;

  List<Widget> _getViolationTiles(BuildContext context) {
    List<Widget> tiles = [];

    if (violations != null && violations.isNotEmpty)
      for (TkViolation violation in violations) {
        TkViolation? found = selection?.firstWhereOrNull(
            (element) => element.id == violation.id);

        tiles.add(
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7),
            child: TkViolationTile(
              violation: violation,
              onTap: onTap,
              isSelected: found != null,
            ),
          ),
        );
      }
    else {
      tiles.add(Center(
        child: Text(
          S.of(context).kNoViolations,
          style: kHintStyle,
        ),
      ));
    }

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _getViolationTiles(context));
  }
}
