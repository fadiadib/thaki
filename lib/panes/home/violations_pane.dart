import 'package:flutter/material.dart';
import 'package:thaki/globals/icons.dart';
import 'package:thaki/widgets/base/index.dart';

class TkViolationsPane extends TkPane {
  TkViolationsPane({onDone, onSelect})
      : super(
          paneTitle: 'Violations',
          navIconData: TkNavIconData(icon: kViolationBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
