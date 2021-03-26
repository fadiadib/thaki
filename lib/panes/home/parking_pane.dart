import 'package:flutter/material.dart';
import 'package:thaki/globals/icons.dart';
import 'package:thaki/widgets/base/index.dart';

class TkParkingPane extends TkPane {
  TkParkingPane({onDone, onSelect})
      : super(
          paneTitle: 'Parking',
          navIconData: TkNavIconData(icon: kParkingBtnIcon),
        );

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
