import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/state_controller.dart';
import 'package:thaki/utilities/form_builder.dart';
import 'package:thaki/utilities/formfield_validator.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkAddCarScreen extends StatefulWidget {
  static const id = 'add_car_screen';

  TkAddCarScreen({this.editMode = false, this.car});
  final bool editMode;
  final TkCar car;

  @override
  _TkAddCarScreenState createState() => _TkAddCarScreenState();
}

class _TkAddCarScreenState extends State<TkAddCarScreen>
    with TkFormFieldValidatorMixin {
  TkCar _car;

  @override
  bool validateField(TkFormField field, dynamic value) {
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    switch (field) {
      case TkFormField.carName:
        return TkValidationHelper.validateNotEmpty(_car.name);
      case TkFormField.carState:
        return TkValidationHelper.validateNotEmpty(_car.state.toString());
      case TkFormField.carPlateEN:
        return langController.lang.languageCode == 'ar' ||
            TkValidationHelper.validateLicense(
                _car.plateEN, _car.state, langController.lang.languageCode);
      case TkFormField.carPlateAR:
        return langController.lang.languageCode == 'en' ||
            TkValidationHelper.validateLicense(
                _car.plateAR, _car.state, langController.lang.languageCode);
      case TkFormField.carMake:
        return TkValidationHelper.validateNotEmpty(_car.make);
      case TkFormField.carModel:
        return TkValidationHelper.validateNotEmpty(_car.model);
      default:
        return true;
    }
  }

  Widget _createForm(TkAccount account) {
    TkStateController states =
        Provider.of<TkStateController>(context, listen: false);
    TkUser user = Provider.of<TkAccount>(context, listen: false).user;
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    return Column(
      children: [
        // Car nick name
        Padding(
          padding: const EdgeInsets.only(top: 20.0),
          child: TkSectionTitle(
              title: S.of(context).kCarNickname, uppercase: false),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kCarNickname,
            initialValue: _car?.name,
            onChanged: (value) => setState(() => _car.name = value),
            validator: getValidationCallback(TkFormField.carName),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseEnter + S.of(context).kCarNickname,
          ),
        ),

        // Car state
        TkSectionTitle(title: S.of(context).kCarState, uppercase: false),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
          child: TkDropDownField(
            context: context,
            values: states.getStateNames(user),
            value: states.getStateName(_car.state, user),
            hintText: S.of(context).kCarState,
            onChanged: (value) =>
                setState(() => _car.state = states.getStateId(value, user)),
            validator: getValidationCallback(TkFormField.carState),
            validate: isValidating,
            errorMessage: S.of(context).kPleaseChoose + S.of(context).kCarState,
          ),
        ),

        // Car license number (EN)
        if (langController.lang.languageCode == 'en')
          Column(
            children: [
              TkSectionTitle(
                  title: S.of(context).kCarPlateEN, uppercase: false),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: TkTextField(
                  enabled: !account.isLoading,
                  hintText: S.of(context).kCarPlateEN,
                  initialValue: _car?.plateEN,
                  onChanged: (value) => setState(() => _car.plateEN = value),
                  validator: getValidationCallback(TkFormField.carPlateEN),
                  validate: isValidating,
                  errorMessage: S.of(context).kPleaseEnterAValid +
                      S.of(context).kCarPlateEN,
                ),
              ),
            ],
          ),

        // Car license number (AR)
        if (langController.lang.languageCode == 'ar')
          Column(
            children: [
              TkSectionTitle(
                  title: S.of(context).kCarPlateAR + S.of(context).kNoSpaces,
                  uppercase: false),
              Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 30.0),
                child: TkTextField(
                  enabled: !account.isLoading,
                  hintText: S.of(context).kCarPlateAR,
                  initialValue: _car?.plateAR,
                  onChanged: (value) => setState(() => _car.plateAR = value),
                  validator: getValidationCallback(TkFormField.carPlateAR),
                  validate: isValidating,
                  errorMessage: S.of(context).kPleaseEnterAValid +
                      S.of(context).kCarPlateAR,
                ),
              ),
            ],
          ),

        Row(
          children: [
            // Make
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCarMake, uppercase: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        30.0, 10.0, 5.0, 10.0),
                    child: TkTextField(
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCarMake,
                      initialValue: _car?.make,
                      onChanged: (value) => setState(() => _car.make = value),
                      validator: getValidationCallback(TkFormField.carMake),
                      validate: isValidating,
                      errorMessage:
                          S.of(context).kPleaseEnter + S.of(context).kCarMake,
                    ),
                  ),
                ],
              ),
            ),

            // Model
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCarModel,
                      uppercase: false,
                      start: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 10.0, 30, 10.0),
                    child: TkTextField(
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCarModel,
                      initialValue: _car?.model,
                      onChanged: (value) => setState(() => _car.model = value),
                      validator: getValidationCallback(TkFormField.carModel),
                      validate: isValidating,
                      errorMessage:
                          S.of(context).kPleaseEnter + S.of(context).kCarModel,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        Row(
          children: [
            // Color
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCarColor, uppercase: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        30.0, 10.0, 5.0, 10.0),
                    child: TkTextField(
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCarColor,
                      initialValue: _car?.color,
                      onChanged: (value) => setState(() => _car.color = value),
                    ),
                  ),
                ],
              ),
            ),

            // Year
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TkSectionTitle(
                      title: S.of(context).kCarYear,
                      uppercase: false,
                      start: false),
                  Padding(
                    padding: const EdgeInsetsDirectional.fromSTEB(
                        5.0, 10.0, 30, 10.0),
                    child: TkTextField(
                      keyboardType: TextInputType.number,
                      enabled: !account.isLoading,
                      hintText: S.of(context).kCarYear,
                      initialValue: _car?.year?.toString(),
                      onChanged: (value) => setState(() => _car.year = value),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),

        // Car default
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
          child: TkFormBuilder.createCheckBox(
              label: S.of(context).kCarIsPreferred,
              value: _car.preferred,
              onChanged: (value) => setState(() => _car.preferred = value)),
        ),
      ],
    );
  }

  Widget _createFormButton(TkAccount account) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 20.0),
      child: TkButton(
        isLoading: account.isLoading,
        btnColor: kSecondaryColor,
        btnBorderColor: kSecondaryColor,
        title: S.of(context).kSave,
        onPressed: () async {
          setState(() => startValidating());

          if (validate()) {
            stopValidating();

            if (widget.editMode) {
              // Call API to add car
              if (await account.updateCar(_car)) {
                // Copy by value
                widget.car.copyValue(_car);
                Navigator.of(context).pop();
              }
            } else {
              // Call API to add car
              if (await account.addCar(_car)) Navigator.of(context).pop();
            }
          }
        },
      ),
    );
  }

  @override
  void initState() {
    super.initState();

    if (widget.editMode) {
      // Copy by value
      _car = widget.car.createCopy();
    } else {
      _car = TkCar.fromJson({});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(builder: (context, account, _) {
      return Scaffold(
        appBar: TkAppBar(
          context: context,
          enableNotifications: false,
          enableClose: true,
          removeLeading: false,
          title: TkLogoBox(),
        ),
        body: TkScaffoldBody(
          child: ListView(
            children: [
              _createForm(account),
              _createFormButton(account),
              TkError(
                  message: widget.editMode
                      ? account.updateCarError
                      : account.addCarError),
            ],
          ),
        ),
      );
    });
  }
}
