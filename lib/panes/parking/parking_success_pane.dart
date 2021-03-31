import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/base/index.dart';

class TkParkingSuccessPane extends TkPane {
  TkParkingSuccessPane({onDone})
      : super(paneTitle: kBookParking, onDone: onDone, allowNavigation: false);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
