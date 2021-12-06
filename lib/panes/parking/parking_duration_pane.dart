import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/general/warning.dart';

class TkParkingDurationPane extends TkPane {
  TkParkingDurationPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _createConfirmButtons(TkBooker booker, BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
          child: TkButton(
            title: S.of(context).kBookUsingBalance,
            onPressed: () {
              booker.creditMode = true;
              onDone!();
            },
            btnColor: kPrimaryColor,
            btnBorderColor: kPrimaryColor,
          ),
        ),
        if (kAllowOneTimeParking)
          Padding(
            padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
            child: TkButton(
              title: S.of(context).kBookUsingCard,
              onPressed: () {
                booker.creditMode = false;
                onDone!();
              },
              btnColor: kSecondaryColor,
              btnBorderColor: kSecondaryColor,
            ),
          ),
      ],
    );
  }

  Widget _createDurationPicker(TkBooker booker, BuildContext context) {
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
              S.of(context).kParkFor.toUpperCase(),
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
              S.of(context).kHours.toUpperCase(),
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
                  TkWarning(message: S.of(context).kBookingDisclaimer),
                  TkSectionTitle(title: S.of(context).kPickParkingTime),
                  _createDurationPicker(booker, context),
                  _createConfirmButtons(booker, context),
                ],
              );
      },
    );
  }
}
