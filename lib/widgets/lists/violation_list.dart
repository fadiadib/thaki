import 'package:flutter/material.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/tiles/violation_tile.dart';

class TkViolationList extends StatelessWidget {
  TkViolationList({@required this.violations, this.onTap, this.selection});
  final List<TkViolation> violations;
  final List<TkViolation> selection;
  final Function onTap;

  List<Widget> _getViolationTiles() {
    List<Widget> tiles = [];

    for (TkViolation violation in violations) {
      TkViolation found = selection.firstWhere(
          (element) => element.id == violation.id,
          orElse: () => null);

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

    return tiles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: _getViolationTiles());
  }
}
