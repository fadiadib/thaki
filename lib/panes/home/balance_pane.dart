import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/base/index.dart';

class TkBalancePane extends TkPane {
  TkBalancePane({onDone, onSelect})
      : super(
          paneTitle: 'Balance',
          navIconData: TkNavIconData(icon: kCalendarBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
