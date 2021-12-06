import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/providers/user_attributes_controller.dart';
import 'package:thaki/screens/edit_profile_screen.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/forms/text_fields.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/login/social_login.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkRegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _TkRegisterScreenState createState() => _TkRegisterScreenState();
}

class _TkRegisterScreenState extends State<TkRegisterScreen>
    with TkFormFieldValidatorMixin {
  TkInfoFieldsList? _fields;
  bool terms = false;
  String? firstName;
  String? middleName;
  String? lastName;
  String? gender;
  int? nationality;
  int? userType;

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
            validator: getValidationCallback(TkFormField.userType),
            validate: isValidating,
            errorMessage:
                S.of(context).kPleaseChoose + S.of(context).kDriverType,
          ),
        ),
      ],
    );
  }

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kRegisterFieldsJson);
    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    account.clearErrors();
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    if (terms == false) {
      Provider.of<TkAccount>(context, listen: false).registerError =
          S.of(context).kYouMustAcceptTerms;
    } else {
      _fields = results;

      TkAccount account = Provider.of<TkAccount>(context, listen: false);
      account.user = TkUser.fromInfoFields(results);
      account.user!.firstName = firstName;
      account.user!.middleName = middleName;
      account.user!.lastName = lastName;
      account.user!.nationality = nationality;
      account.user!.userType = userType;
      account.user!.gender = gender;

      if (await account.register(store: account.user!.rememberMe))
        Navigator.pushReplacementNamed(context, TkHomeScreen.id);
    }
  }

  bool? _extraValidation() {
    setState(() => startValidating());
    bool? result = validate();
    return result;
  }

  bool _validatePasswordMatch(TkInfoField confirmField) {
    // Search for the password field in fields
    TkInfoField? passwordField = _fields!.fields.firstWhereOrNull(
        (element) => element.name == kUserPasswordTag);
    if (passwordField != null && passwordField.value == confirmField.value)
      return true;
    return false;
  }

  bool _validatePassword(TkInfoField passwordField) =>
      TkValidationHelper.validateStrongPassword(passwordField.value);

  Widget _createForm(
      TkAccount account, TkUserAttributesController userAttributesController) {
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang!.languageCode,
      formTitle: kRegisterFieldsJson[kFormName][controller.lang!.languageCode],
      actionTitle: kRegisterFieldsJson[kFormAction]
          [controller.lang!.languageCode],
      buttonTag: kSignUpTag,
      fields: _fields,
      validatePasswordMatch: _validatePasswordMatch,
      validatePassword: _validatePassword,
      passwordError: S.of(context).kStrongPasswordError,
      action: _updateModelAndPushNext,
      isLoading: account.isLoading,
      extraValidation: _extraValidation,
      startValidationCallback: _extraValidation,
      header: _createUserPersonalData(account, userAttributesController),
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).kAlreadyRegistered),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, TkLoginScreen.id),
            child: Text(
              S.of(context).kLoginExclamation,
              style: kRegularStyle[kSmallSize]!.copyWith(color: kPrimaryColor),
            ),
          )
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => TkURLLauncher.launchBase(
                  S.of(context).kLocale + kTermsConditionsURL),
              child: TkFormBuilder.createCheckBox(
                label: S.of(context).kAcceptTerms,
                value: terms,
                onChanged: (value) => setState(() => terms = value),
                style: kBoldStyle[kSmallSize]!
                    .copyWith(decoration: TextDecoration.underline),
              ),
            ),
            Column(
              children: [
                TkError(message: account.registerError),
                TkError(message: account.socialError),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _createLoginOptions(TkAccount account) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 50.0),
      child: TkSocialLogin(
        callback: () async {
          if (await account.social()) {
            if (account.user != null) {
              if (account.user!.needsUpdate) {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    settings: RouteSettings(name: TkEditProfileScreen.id),
                    builder: (context) =>
                        TkEditProfileScreen(pushHomeMode: true),
                  ),
                );
              } else {
                await Navigator.pushReplacementNamed(context, TkHomeScreen.id);
              }
            }
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<TkAccount, TkUserAttributesController>(
      builder: (context, account, userAttributesController, _) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
            appBar: TkAppBar(
              context: context,
              enableNotifications: false,
              enableClose: false,
              removeLeading: true,
              leading: IconButton(
                icon: Icon(kBackBtnIcon),
                onPressed: () => Navigator.of(context)
                    .pushReplacementNamed(TkWelcomeScreen.id),
              ),
            ),
            body: TkScaffoldBody(
              image: AssetImage(kFooter),
              child: ListView(
                children: [
                  Column(
                    children: [
                      TkLogoBox(),
                      _createForm(account, userAttributesController),
                      _createLoginOptions(account),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
