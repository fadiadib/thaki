import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';

class TkEditAction extends StatelessWidget {
  TkEditAction({@required this.onTap});
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return IconSlideAction(
      caption: S.of(context).kEdit,
      color: kSecondaryColor,
      icon: kEditBtIcon,
      onTap: onTap,
      foregroundColor: kWhiteColor,
    );
  }
}
