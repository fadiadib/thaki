import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/login_screen.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
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
    return TkFormFrame(
      formTitle: kRegisterFieldsJson[kFormName],
      actionTitle: kRegisterFieldsJson[kFormAction],
      buttonTag: kSignUpTag,
      fields: _fields,
      validatePasswordMatch: _validatePasswordMatch,
      action: (TkInfoFieldsList results) async {
        await _updateModelAndPushNext(results);
      },
    );
  }

  Widget _createLoginOptions() {
    return Column(
      children: [
        TkSocialLogin(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(kAlreadyRegistered),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, TkLoginScreen.id),
              child: Text(
                kLoginExclamation,
                style: kRegularStyle[kSmallSize].copyWith(
                  color: kPrimaryColor,
                ),
              ),
            )
          ],
        ),
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
