import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/lists/parking_type_list.dart';

class TkParkingTimePane extends TkPane {
  TkParkingTimePane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _createBookParkingButton(TkBooker booker, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(
        title: booker.bookNow
            ? S.of(context).kBookParkingNow
            : S.of(context).kPickParkingTime,
        onPressed: () {
          if (booker.bookNow ||
              (booker.bookDate != null &&
                  DateTime.now().isBefore(booker.bookDate))) onDone();
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
              locale:
                  Provider.of<TkLangController>(context, listen: false).isRTL
                      ? LocaleType.ar
                      : LocaleType.en,
              value: booker.bookDate == null
                  ? null
                  : booker.bookDate.isBefore(DateTime.now())
                      ? DateTime.now().add(Duration(minutes: 1))
                      : booker.bookDate,
              context: context,
              type: TkInfoFieldType.DateTime,
              allowFuture: true,
              allowPast: false,
              validate: true,
              hintText: S.of(context).kSelectDateTime,
              validator: () => (booker.bookDate != null &&
                  DateTime.now().isBefore(booker.bookDate)),
              onChanged: (value) => booker.bookDate = value,
              errorMessage: booker.bookDate == null
                  ? S.of(context).kPleaseEnterAValid + S.of(context).kDateTime
                  : S.of(context).kDateTime + S.of(context).kIsPast,
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
                    child:
                        TkSectionTitle(title: S.of(context).kPickParkingTime),
                  ),
                  _createParkingList(booker, context),
                  _createBookParkingButton(booker, context),
                ],
              );
      },
    );
  }
}
