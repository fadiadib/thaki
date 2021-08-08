import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/attributes_controller.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/forms/license_field.dart';
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
  ScrollController _scrollController = ScrollController();
  TextEditingController _modelController = TextEditingController();
  TextEditingController _makeController = TextEditingController();
  TextEditingController _colorController = TextEditingController();
  TextEditingController _yearController = TextEditingController();

  /// Override mandatory validate field method from form field validator
  /// validate each field according to its type.
  @override
  bool validateField(TkFormField field, dynamic value) {
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    // check the type of the field
    switch (field) {
      case TkFormField.carName:
        return TkValidationHelper.validateAlphaNum(_car.name);

      case TkFormField.carState:
        return TkValidationHelper.validateNotEmpty(_car.state.toString());

      case TkFormField.carPlateEN:
        return langController.isRTL ||
            TkValidationHelper.validateLicense(
                _car.plateEN, _car.state, langController.lang.languageCode);

      case TkFormField.carPlateAR:
        return !langController.isRTL ||
            TkValidationHelper.validateLicense(
                _car.plateAR, _car.state, langController.lang.languageCode);

      case TkFormField.carMake:
        return TkValidationHelper.validateNotEmpty(_car.make?.toString());

      // case TkFormField.carModel:
      //   return TkValidationHelper.validateNotEmpty(_car.model?.toString());

      default:
        return true;
    }
  }

  /// Returns a list of years Strings starting from 1986 to current year
  List<String> _getYears() {
    List<String> years = [];
    int currentYear = DateTime.now().year + 1;

    for (int year = currentYear; year >= 1886; year--)
      years.add(year.toString());

    return years;
  }

  List<String> _getInitialValuesEN() {
    if (_car == null || _car.plateEN == null || _car.plateEN.isEmpty)
      return ['', ''];

    final RegExp nExp = RegExp(r"\d{1,4}");
    final String nums = nExp.stringMatch(_car.plateEN);

    final RegExp cExp = RegExp(r"[A-Z]{2,3}");
    final String chars = cExp.stringMatch(_car.plateEN);

    return [nums, chars];
  }

  /// Finds the letters part in the car arabic license plate
  String _getARLetterPlate() {
    // First check for letters without spaces
    String result = RegExp(r"([\u0621-\u064A]){2,3}", unicode: true)
        .stringMatch(_car.plateAR);

    // If found split them and join with space
    if (result != null) return result.split('').join(' ');

    // If no match, try to find letters with spaces and return it
    result = RegExp(r"([\u0621-\u064A]\s*){2,3}", unicode: true)
            .stringMatch(_car.plateAR) ??
        '-';
    return result;
  }

  List<String> _getInitialValuesAR() {
    if (_car == null || _car.plateAR == null || _car.plateAR.isEmpty)
      return ['', ''];

    final RegExp nExp = RegExp(r"[\u0660-\u0669\d]{1,4}", unicode: true);
    final String nums = nExp.stringMatch(_car.plateAR);

    return [nums, _getARLetterPlate()];
  }

  Widget getLicensePlateWidgetEN(
      TkLangController langController, TkAccount account) {
    if (_car.state == 1)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: TkLicenseField(
          langCode: langController.lang.languageCode,
          enabled: !account.isLoading,
          onChanged: (value) => setState(() => _car.plateEN = value),
          values: _getInitialValuesEN(),
          validator: getValidationCallback(TkFormField.carPlateEN),
          validate: isValidating,
          errorMessage:
              S.of(context).kPleaseEnterAValid + S.of(context).kCarPlateEN,
        ),
      );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: TkTextField(
        enabled: !account.isLoading,
        hintText: S.of(context).kCarPlateEN,
        initialValue: _car?.plateEN,
        onChanged: (value) => setState(() => _car.plateEN = value),
        validator: getValidationCallback(TkFormField.carPlateEN),
        validate: isValidating,
        errorMessage:
            S.of(context).kPleaseEnterAValid + S.of(context).kCarPlateEN,
      ),
    );
  }

  Widget getLicensePlateWidgetAR(
      TkLangController langController, TkAccount account) {
    if (_car.state == 1)
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
        child: TkLicenseField(
          enabled: !account.isLoading,
          langCode: langController.lang.languageCode,
          onChanged: (value) => setState(() => _car.plateAR = value),
          values: _getInitialValuesAR(),
          validator: getValidationCallback(TkFormField.carPlateAR),
          validate: isValidating,
          errorMessage:
              S.of(context).kPleaseEnterAValid + S.of(context).kCarPlateAR,
        ),
      );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 30.0),
      child: TkTextField(
        height: kDefaultLicensePlateTextEditHeight,
        maxLengthEnforced: _car.state != 1,
        maxLength: _car.state != 1 ? 7 : null,
        enabled: !account.isLoading,
        hintText: S.of(context).kCarPlateAR,
        initialValue: _car?.plateAR,
        onChanged: (value) => setState(() => _car.plateAR = value),
        validator: getValidationCallback(TkFormField.carPlateAR),
        validate: isValidating,
        errorMessage:
            S.of(context).kPleaseEnterAValid + S.of(context).kCarPlateAR,
      ),
    );
  }

  Widget _createForm(TkAccount account) {
    TkAttributesController states =
        Provider.of<TkAttributesController>(context, listen: true);
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
            values: states.stateNames(langController),
            value: states.stateName(_car.state, langController),
            hintText: S.of(context).kCarState,
            onChanged: (value) =>
                setState(() => _car.state = states.stateId(value)),
            validator: getValidationCallback(TkFormField.carState),
            validate: isValidating,
            errorMessage: S.of(context).kPleaseChoose + S.of(context).kCarState,
          ),
        ),

        // Car license number (EN)
        if (!langController.isRTL)
          Column(
            children: [
              TkSectionTitle(
                  title: S.of(context).kCarPlateEN +
                      (_car.state == 1 ? S.of(context).kCarPlateHint : ''),
                  uppercase: false),
              getLicensePlateWidgetEN(langController, account),
            ],
          ),

        // Car license number (AR)
        if (langController.isRTL)
          Column(
            children: [
              TkSectionTitle(
                  title: S.of(context).kCarPlateAR +
                      (_car.state == 1 ? S.of(context).kCarPlateHint : ''),
                  uppercase: false),
              getLicensePlateWidgetAR(langController, account),
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
                    child: TkSearchableDropDownField(
                      controller: _makeController,
                      style: kRegularStyle[kSmallSize],
                      context: context,
                      hintText: S.of(context).kCarMake,
                      value: states.makeName(_car.make, langController),
                      values: states.makeNames(langController),
                      onChanged: (value) {
                        setState(() {
                          _car.make = states.makeId(value);
                          _car.model = null;
                          _modelController.clear();
                          _modelController.clearComposing();
                          _makeController.clearComposing();
                        });
                        states.loadModels(user, _car.make);
                      },
                      validator: getValidationCallback(TkFormField.carMake),
                      validate: isValidating,
                      errorMessage:
                          S.of(context).kPleaseChoose + S.of(context).kCarMake,
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
                    child: TkSearchableDropDownField(
                      controller: _modelController,
                      style: kRegularStyle[kSmallSize],
                      context: context,
                      hintText: S.of(context).kCarModel,
                      value: states.modelName(_car.model, langController),
                      values: states.modelNames(langController),
                      onChanged: (value) {
                        setState(() => _car.model = states.modelId(value));
                        _modelController.clearComposing();
                      },
                      validator: getValidationCallback(TkFormField.carModel),
                      validate: isValidating,
                      errorMessage:
                          S.of(context).kPleaseChoose + S.of(context).kCarModel,
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
                    child: TkSearchableDropDownField(
                      controller: _colorController,
                      style: kRegularStyle[kSmallSize],
                      context: context,
                      hintText: S.of(context).kCarColor,
                      value: states.colorName(_car.color, langController),
                      values: states.colorNames(langController),
                      onChanged: (value) {
                        setState(() => _car.color = states.colorId(value));
                        _colorController.clearComposing();
                      },
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
                    child: TkSearchableDropDownField(
                      controller: _yearController,
                      style: kRegularStyle[kSmallSize],
                      context: context,
                      hintText: S.of(context).kCarYear,
                      value: _car.year,
                      values: _getYears(),
                      onChanged: (value) {
                        setState(() => _car.year = value);
                        _yearController.clearComposing();
                      },
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

            // Remove the spaces in the car plate Arabic
            if (_car.plateAR != null)
              _car.plateAR = _car.plateAR.split(' ').join();

            if (widget.editMode) {
              // Call API to add car
              if (await account.updateCar(_car)) {
                // Copy by value
                widget.car.copyValue(_car);
                Navigator.of(context).pop();
              }
            } else {
              // Call API to add car
              if (await account.addCar(_car))
                Navigator.of(context).pop();
              else
                _scrollController.animateTo(0,
                    duration: Duration(milliseconds: 600),
                    curve: Curves.easeOut);
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

    TkAttributesController states =
        Provider.of<TkAttributesController>(context, listen: false);
    TkUser user = Provider.of<TkAccount>(context, listen: false).user;
    states.loadModels(user, _car?.make, init: true);

    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    _makeController.text = states.makeName(_car.make, langController);
    Future.delayed(Duration(seconds: 3)).then((_) =>
        _modelController.text = states.modelName(_car.model, langController));
    _colorController.text = states.colorName(_car.color, langController);
    _yearController.text = _car.year;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkAccount, TkAttributesController>(
        builder: (context, account, attributes, _) {
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
            shrinkWrap: true,
            controller: _scrollController,
            reverse: true,
            children: [
              TkError(
                  message: widget.editMode
                      ? account.updateCarError
                      : account.addCarError),
              _createFormButton(account),
              _createForm(account),
            ],
          ),
        ),
      );
    });
  }
}
