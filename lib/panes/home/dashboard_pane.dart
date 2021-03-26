import 'package:flutter/material.dart';
import 'package:thaki/globals/icons.dart';
import 'package:thaki/widgets/base/index.dart';

class TkDashboardPane extends TkPane {
  TkDashboardPane({onDone, onSelect})
      : super(
          paneTitle: 'Dashboard',
          navIconData: TkNavIconData(icon: kHomeBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
