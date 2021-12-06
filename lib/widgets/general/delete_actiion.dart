import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';

class TkDeleteAction extends StatelessWidget {
  TkDeleteAction({required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return SlidableAction(
      label: S.of(context).kDelete,
      backgroundColor: kRedAccentColor,
      icon: kDeleteBtnIcon,
      onPressed: onTap as void Function(BuildContext)?,
    );
  }
}
