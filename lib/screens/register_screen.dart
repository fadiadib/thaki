import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/login/social_login.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkRegisterScreen extends StatefulWidget {
  static const String id = 'register_screen';

  @override
  _TkRegisterScreenState createState() => _TkRegisterScreenState();
}

class _TkRegisterScreenState extends State<TkRegisterScreen> {
  TkInfoFieldsList _fields;
  bool terms = false;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kRegisterFieldsJson);
    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    account.clearErrors();
    //if (account.user != null) _fields = account.user.toInfoFields(_fields);
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    if (terms == false) {
      Provider.of<TkAccount>(context, listen: false).registerError =
          S.of(context).kYouMustAcceptTerms;
    } else {
      _fields = results;

      TkAccount account = Provider.of<TkAccount>(context, listen: false);
      account.user = TkUser.fromInfoFields(results);

      if (await account.register(store: account.user.rememberMe))
        Navigator.pushReplacementNamed(context, TkHomeScreen.id);
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

  Widget _createForm(TkAccount account) {
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      formTitle: kRegisterFieldsJson[kFormName][controller.lang.languageCode],
      actionTitle: kRegisterFieldsJson[kFormAction]
          [controller.lang.languageCode],
      buttonTag: kSignUpTag,
      fields: _fields,
      validatePasswordMatch: _validatePasswordMatch,
      validatePassword: _validatePassword,
      action: _updateModelAndPushNext,
      isLoading: account.isLoading,
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).kAlreadyRegistered),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, TkLoginScreen.id),
            child: Text(
              S.of(context).kLoginExclamation,
              style: kRegularStyle[kSmallSize].copyWith(color: kPrimaryColor),
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
              onTap: () => TkURLLauncher.launch(
                  kBaseURL + S.of(context).kLocale + kTermsConditionsURL),
              child: TkFormBuilder.createCheckBox(
                  label: S.of(context).kAcceptTerms,
                  value: terms,
                  onChanged: (value) => setState(() => terms = value)),
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
          if (await account.social())
            Navigator.pushReplacementNamed(context, TkHomeScreen.id);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(
      builder: (context, account, _) {
        return WillPopScope(
          onWillPop: () async => false,
          child: Scaffold(
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
                    children: [
                      TkLogoBox(),
                      _createForm(account),
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
