import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';

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

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kRegisterFieldsJson);
    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    account.clearErrors();
    if (account.user != null) _fields = account.user.toInfoFields(_fields);
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user = TkUser.fromInfoFields(results);

    if (await account.register(store: account.user.rememberMe))
      Navigator.pushNamed(context, TkHomeScreen.id);
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

  Widget _createForm() {
    TkAccount account = Provider.of<TkAccount>(context);

    return TkFormFrame(
      formTitle: kRegisterFieldsJson[kFormName],
      actionTitle: kRegisterFieldsJson[kFormAction],
      buttonTag: kSignUpTag,
      fields: _fields,
      validatePasswordMatch: _validatePasswordMatch,
      action: _updateModelAndPushNext,
      isLoading: account.isLoading,
      child: TkError(message: account.error[TkAccountError.register]),
    );
  }

  Widget _createLoginOptions() {
    return Column(
      children: [
        Row(
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
        TkSocialLogin(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
              children: [
                TkLogoBox(),
                _createForm(),
                _createLoginOptions(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
