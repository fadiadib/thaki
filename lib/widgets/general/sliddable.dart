import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thaki/widgets/general/delete_actiion.dart';
import 'package:thaki/widgets/general/edit_action.dart';

class TkSlidableTile extends StatelessWidget {
  TkSlidableTile({@required this.child, this.onDelete, this.onEdit});
  final Widget child;
  final Function onDelete;
  final Function onEdit;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      actionPane: SlidableDrawerActionPane(),
      actionExtentRatio: 0.25,
      child: child,
      actions: onEdit == null ? null : [TkEditAction(onTap: onEdit)],
      secondaryActions:
          onDelete == null ? null : [TkDeleteAction(onTap: onDelete)],
    );
  }
}
