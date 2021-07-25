import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/user_attributes_controller.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkEditProfileScreen extends StatefulWidget {
  static const String id = 'edit_profile_screen';

  @override
  _TkEditProfileScreenState createState() => _TkEditProfileScreenState();
}

class _TkEditProfileScreenState extends State<TkEditProfileScreen>
    with TkFormFieldValidatorMixin {
  TkInfoFieldsList _fields;
  String firstName;
  String middleName;
  String lastName;
  String gender;
  int nationality;
  int userType;

  /// Override mandatory validate field method from form field validator
  /// validate each field according to its type.
  @override
  bool validateField(TkFormField field, dynamic value) {
    // check the type of the field
    switch (field) {
      case TkFormField.firstName:
        return TkValidationHelper.validateAlphaNum(firstName);
      case TkFormField.middleName:
        return TkValidationHelper.validateAlphaNum(middleName);
      case TkFormField.lastName:
        return TkValidationHelper.validateAlphaNum(lastName);

      case TkFormField.nationality:
        return true;
      case TkFormField.userType:
        return TkValidationHelper.validateNotEmpty(userType?.toString());
      case TkFormField.gender:
        return true;

      default:
        return true;
    }
  }

  Widget _createUserPersonalData(
      TkAccount account, TkUserAttributesController userAttributesController) {
    TkLangController langController =
        Provider.of<TkLangController>(context, listen: false);

    return Column(
      children: [
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kFirstName,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kFirstName,
            initialValue: firstName,
            onChanged: (value) => setState(() => firstName = value),
            validator: getValidationCallback(TkFormField.firstName),
            validate: isValidating,
            errorMessage: S.of(context).kPleaseEnter + S.of(context).kFirstName,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kMiddleName,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kMiddleName,
            initialValue: middleName,
            onChanged: (value) => setState(() => middleName = value),
            validator: getValidationCallback(TkFormField.middleName),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseEnter + S.of(context).kMiddleName,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kLastName,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: TkTextField(
            enabled: !account.isLoading,
            hintText: S.of(context).kLastName,
            initialValue: lastName,
            onChanged: (value) => setState(() => lastName = value),
            validator: getValidationCallback(TkFormField.lastName),
            validate: isValidating,
            errorMessage: S.of(context).kPleaseEnter + S.of(context).kLastName,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kGender,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: TkDropDownField(
            context: context,
            values: [S.of(context).kMale, S.of(context).kFemale],
            value: gender,
            hintText: S.of(context).kGender,
            onChanged: (value) => setState(() => gender = value),
            validator: getValidationCallback(TkFormField.gender),
            validate: isValidating,
            errorMessage: S.of(context).kPleaseChoose + S.of(context).kGender,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kNationality,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 0),
          child: TkDropDownField(
            context: context,
            values: userAttributesController.nationalityNames(langController),
            value: userAttributesController.nationalityName(
                nationality, langController),
            hintText: S.of(context).kNationality,
            onChanged: (value) => setState(() =>
                nationality = userAttributesController.nationalityId(value)),
            validator: getValidationCallback(TkFormField.nationality),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseChoose + S.of(context).kNationality,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(25, 10, 25, 0),
          child: TkSectionTitle(
            title: S.of(context).kDriverType,
            uppercase: false,
            noPadding: true,
          ),
        ),
        Padding(
          padding: const EdgeInsetsDirectional.fromSTEB(20, 10, 20, 5),
          child: TkDropDownField(
            context: context,
            values: userAttributesController.userTypesNames(langController),
            value:
                userAttributesController.userTypeName(userType, langController),
            hintText: S.of(context).kDriverType,
            onChanged: (value) => setState(
                () => userType = userAttributesController.userTypeId(value)),
            validator: getValidationCallback(TkFormField.nationality),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseChoose + S.of(context).kDriverType,
          ),
        ),
      ],
    );
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user.updateModelFromInfoFields(results);
    account.user.firstName = firstName;
    account.user.middleName = middleName;
    account.user.lastName = lastName;
    account.user.gender = gender;
    account.user.nationality = nationality;
    account.user.userType = userType;

    if (await account.edit()) {
      Navigator.pop(context, true);
    }
  }

  bool _validatePasswordMatch(TkInfoField confirmField) {
    // Search for the password field in fields
    TkInfoField passwordField = _fields.fields.firstWhere(
        (element) => element.name == kUserPasswordTag,
        orElse: () => null);
    if (passwordField != null && passwordField.value == confirmField.value)
      return true;
    return false;
  }

  bool _validatePassword(TkInfoField passwordField) =>
      TkValidationHelper.validateStrongPassword(passwordField.value);

  Widget _createForm(TkUserAttributesController userAttributesController) {
    TkAccount account = Provider.of<TkAccount>(context);
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      formTitle: kEditProfileFieldsJson[kFormName]
          [controller.lang.languageCode],
      actionTitle: kEditProfileFieldsJson[kFormAction]
          [controller.lang.languageCode],
      validatePasswordMatch: _validatePasswordMatch,
      validatePassword: _validatePassword,
      buttonTag: kSignUpTag,
      fields: _fields,
      action: _updateModelAndPushNext,
      isLoading: account.isLoading,
      extraValidation: _extraValidation,
      startValidationCallback: _extraValidation,
      header: _createUserPersonalData(account, userAttributesController),
      footer: account.user.isSocial
          ? Container()
          : Center(child: Text(S.of(context).kPasswordWontChange)),
      child: TkError(message: account.editError),
    );
  }

  bool _extraValidation() {
    setState(() => startValidating());
    bool result = validate();
    return result;
  }

  @override
  void initState() {
    super.initState();

    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    // Load info fields from model
    if (account.user.isSocial) {
      _fields = TkInfoFieldsList.fromJson(data: kEditSocialProfileFieldsJson);
    } else {
      _fields = TkInfoFieldsList.fromJson(data: kEditProfileFieldsJson);
    }

    account.clearErrors();
    if (account.user != null) {
      _fields = account.user.toInfoFields(_fields);
      firstName = account.user.firstName;
      middleName = account.user.middleName;
      lastName = account.user.lastName;
      gender = account.user.gender;
      nationality = account.user.nationality;
      userType = account.user.userType;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkAccount, TkUserAttributesController>(
        builder: (context, account, userAttributesController, _) {
      return Scaffold(
        appBar: TkAppBar(
          context: context,
          enableNotifications: false,
          enableClose: false,
          removeLeading: false,
        ),
        body: TkScaffoldBody(
          image: AssetImage(kFooter),
          child: ListView(
            children: [
              Column(
                children: [TkLogoBox(), _createForm(userAttributesController)],
              ),
            ],
          ),
        ),
      );
    });
  }
}
