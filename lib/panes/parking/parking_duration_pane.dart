import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkParkingDurationPane extends TkPane {
  TkParkingDurationPane({onDone})
      : super(paneTitle: kBookParking, onDone: onDone);

  Widget _createConfirmButton(TkBooker booker) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: kConfirm,
        onPressed: onDone,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
      ),
    );
  }

  Widget _createDurationPicker(TkBooker booker) {
    List<Widget> items = [];
    for (int i = 1; i <= 100; i++) {
      items.add(Text(i.toString()));
    }
    return Container(
      height: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              kParkFor.toUpperCase(),
              style: kBoldStyle[kNormalSize],
            ),
          ),
          Container(
            width: 100,
            child: CupertinoPicker(
              children: items,
              useMagnifier: true,
              magnification: 1.5,
              itemExtent: 32,
              onSelectedItemChanged: (int index) {
                booker.bookDuration = index + 1;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              kHours.toUpperCase(),
              style: kBoldStyle[kNormalSize],
            ),
          ),
        ],
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
                  _createDurationPicker(booker),
                  _createConfirmButton(booker),
                ],
              );
      },
    );
  }
}
