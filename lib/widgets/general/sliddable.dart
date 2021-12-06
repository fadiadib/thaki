import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:thaki/widgets/general/delete_actiion.dart';
import 'package:thaki/widgets/general/edit_action.dart';
import 'package:thaki/widgets/general/seen_action.dart';

class TkSlidableTile extends StatelessWidget {
  TkSlidableTile(
      {required this.child, this.onDelete, this.onEdit, this.onSeen});

  final Widget child;
  final Function? onDelete;
  final Function? onEdit;
  final Function? onSeen;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: onEdit == null && onSeen == null
          ? null
          : ActionPane(
              motion: const ScrollMotion(),
              children: [
                if (onEdit != null)
                  TkEditAction(onTap: onEdit!)
                // SlidableAction(label:'Edit', onPressed: onEdit as void Function(BuildContext)?)
                else if (onSeen != null)
                  TkSeenAction(onTap: onSeen!)
                // SlidableAction(label:'Seen', onPressed: onSeen as void Function(BuildContext)?)
              ],
            ),
      endActionPane: onDelete != null
          ? ActionPane(
              motion: ScrollMotion(),
              children: [
                TkDeleteAction(onTap: onDelete!)
                // SlidableAction(label:'Delete', onPressed: onDelete as void Function(BuildContext)?)
              ],
            )
          : null,
      // actionPane: SlidableDrawerActionPane(),
      // actionExtentRatio: 0.25,
      child: child,
      // actions: onEdit == null
      //     ? onSeen == null
      //         ? null
      //         : [TkSeenAction(onTap: onSeen)]
      //     : [TkEditAction(onTap: onEdit)],
      // secondaryActions:
      //     onDelete == null ? null : [TkDeleteAction(onTap: onDelete)],
    );
  }
}
