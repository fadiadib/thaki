import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/license_field.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkViolationCarPane extends TkPane {
  TkViolationCarPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _createFormButton(TkPayer payer, BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: Hero(
        tag: kViolationsListTag,
        child: TkButton(
          title: S.of(context).kContinue,
          onPressed: () {
            if (payer.validateCar(context)) onDone();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPayer>(
      builder: (context, payer, _) {
        return payer.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20.0),
                    child: TkSectionTitle(title: S.of(context).kEnterLRP),
                  ),
                  TkViolationCarForm(payer),
                  _createFormButton(payer, context),
                  TkError(message: payer.validationCarError),
                ],
              );
      },
    );
  }
}

class TkViolationCarForm extends StatefulWidget {
  final TkPayer payer;

  TkViolationCarForm(this.payer);

  @override
  _TkViolationCarFormState createState() => _TkViolationCarFormState();
}

class _TkViolationCarFormState extends State<TkViolationCarForm> {
  TkPayer payer;

  List<String> _getInitialValuesEN(TkPayer payer) {
    if (payer.selectedCar == null ||
        payer.selectedCar.plateEN == null ||
        payer.selectedCar.plateEN.isEmpty) return ['', ''];

    final RegExp nExp = RegExp(r"\d{1,4}");
    final String nums = nExp.stringMatch(payer.selectedCar.plateEN) ?? '';

    final RegExp cExp = RegExp(r"[A-Za-z]{2,3}");
    final String chars = cExp.stringMatch(payer.selectedCar.plateEN) ?? '';

    return [nums, chars];
  }

  @override
  void initState() {
    super.initState();
    payer = widget.payer;
  }

  @override
  Widget build(BuildContext context) {
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    return Consumer<TkAttributesController>(builder: (context, states, _) {
      return Column(
        children: [
          // Car license number
          if (payer.allowChange)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TkSectionTitle(
                    title: S.of(context).kCarState, uppercase: false),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 30.0),
                  child: TkDropDownField(
                    context: context,
                    values: states.stateNames(langController),
                    value: states.stateName(
                        payer.selectedCar.state, langController),
                    hintText: S.of(context).kCarState,
                    onChanged: (value) {
                      setState(() =>
                          payer.selectedCar.state = states.stateId(value));
                    },
                    errorMessage:
                        S.of(context).kPleaseChoose + S.of(context).kCarState,
                  ),
                ),
              ],
            ),

          TkSectionTitle(title: S.of(context).kCarPlateEN, uppercase: false),

          if (payer.selectedCar.state != 1)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: TkTextField(
                enabled: payer.allowChange,
                height: kDefaultLicensePlateTextEditHeight,
                hintText: S.of(context).kCarPlateEN,
                initialValue: payer.selectedCar.plateEN,
                maxLengthEnforced: payer.selectedCar.state != 1,
                maxLength: payer.selectedCar.state != 1 ? 7 : null,
                keyboardType: TextInputType.number,
                onChanged: (String value) {
                  payer.selectedCar.plateEN = value;
                },
              ),
            ),
          if (payer.selectedCar.state == 1)
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
              child: kSeparatedLicenseField
                  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: TkSeparatedLicenseField(
                        langCode: 'en',
                        onChanged: (value) => payer.selectedCar.plateEN = value,
                        values: _getInitialValuesEN(payer),
                        validate: false,
                        enabled: payer.allowChange,
                        reverseLabelAlign: Provider.of<TkLangController>(
                                    context,
                                    listen: false)
                                .lang
                                .languageCode ==
                            'ar',
                      ),
                    )
                  : TkLicenseField(
                      langCode:
                          Provider.of<TkLangController>(context, listen: false)
                              .lang
                              .languageCode,
                      onChanged: (value) => payer.selectedCar.plateEN = value,
                      values: _getInitialValuesEN(payer),
                      validate: false,
                      enabled: payer.allowChange,
                    ),
            )
        ],
      );
    });
  }
}
