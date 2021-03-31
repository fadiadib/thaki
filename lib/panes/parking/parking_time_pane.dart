import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkParkingTimePane extends TkPane {
  TkParkingTimePane({onDone}) : super(paneTitle: kBookParking, onDone: onDone);

  Widget _createBookParkingButton() {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(30.0, 20.0, 30.0, 0),
      child: TkButton(
        title: kBookParkingNow,
        onPressed: onDone,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkBooker>(
      builder: (context, booker, _) {
        return booker.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TkSectionTitle(title: kPickParkingTime),
                  ),
                  // _createParkingList(),
                  _createBookParkingButton(),
                ],
              );
      },
    );
  }
}
