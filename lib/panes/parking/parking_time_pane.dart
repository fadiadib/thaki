import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/parking_type_list.dart';

class TkParkingTimePane extends TkPane {
  TkParkingTimePane({onDone}) : super(paneTitle: kBookParking, onDone: onDone);

  Widget _createBookParkingButton(TkBooker booker) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: booker.bookNow ? kBookParkingNow : kPickParkingTime,
        onPressed: () {
          if (booker.bookNow || booker.bookDate != null) onDone();
        },
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
      ),
    );
  }

  Widget _createParkingList(TkBooker booker, BuildContext context) {
    return Column(
      children: [
        TkParkingTypeList(
          parkNow: booker.bookNow,
          onTap: () => booker.bookNow = !booker.bookNow,
        ),
        if (!booker.bookNow)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 7.0),
            child: TkDateField(
              value: booker.bookDate,
              context: context,
              type: TkInfoFieldType.DateTime,
              allowFuture: true,
              allowPast: false,
              validate: true,
              hintText: kSelectDateTime,
              validator: () => booker.bookDate != null,
              onChanged: (value) => booker.bookDate = value,
              errorMessage: kPleaseChoose + kDateTime,
            ),
          ),
      ],
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
                  _createParkingList(booker, context),
                  _createBookParkingButton(booker),
                ],
              );
      },
    );
  }
}
