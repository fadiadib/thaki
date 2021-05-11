import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thaki/widgets/general/delete_actiion.dart';
import 'package:thaki/widgets/general/edit_action.dart';
import 'package:thaki/widgets/general/seen_action.dart';

class TkSlidableTile extends StatelessWidget {
  TkSlidableTile(
      {@required this.child, this.onDelete, this.onEdit, this.onSeen});
  final Widget child;
  final Function onDelete;
  final Function onEdit;
  final Function onSeen;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: child,
      actions: onEdit == null
          ? onSeen == null ? null : [TkSeenAction(onTap: onSeen)]
          : [TkEditAction(onTap: onEdit)],
      secondaryActions:
          onDelete == null ? null : [TkDeleteAction(onTap: onDelete)],
    );
  }
}
