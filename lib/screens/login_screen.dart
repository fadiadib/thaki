import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/screens/forgot_password_screen.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/register_screen.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/login/social_login.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkLoginScreen extends StatefulWidget {
  static const String id = 'login_screen';

  @override
  _TkLoginScreenState createState() => _TkLoginScreenState();
}

class _TkLoginScreenState extends State<TkLoginScreen> {
  TkInfoFieldsList _fields;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kLoginFieldsJson);
  }

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    // TODO: Call Login in Account Provider
    // TODO: Update user model with result from API
    // TODO: If Remember me is checked, save model to prefs
    // TODO: Encrypt password before sending it
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    if (await account.login(results))
      Navigator.pushNamed(context, TkHomeScreen.id);
  }

  Widget _createForm() {
    return TkFormFrame(
        introTitle: kLoginIntroTitle,
        formTitle: kLoginFieldsJson[kFormName],
        actionTitle: kLoginFieldsJson[kFormAction],
        buttonTag: kLoginTag,
        fields: _fields,
        action: (TkInfoFieldsList results) async {
          await _updateModel(results);
        },
        footer: Center(
          child: GestureDetector(
            onTap: () => Navigator.pushReplacementNamed(
                context, TkForgotPasswordScreen.id),
            child: Text(
              kForgotPassword + '?',
              style: kLinkStyle,
            ),
          ),
        ));
  }

  Widget _createLoginOptions() {
    return Column(
      children: [
        TkSocialLogin(),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(kNotRegisteredYet),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, TkRegisterScreen.id),
              child: Text(
                kSignUpExclamation,
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
            Column(children: [
              TkLogoBox(),
              _createForm(),
              _createLoginOptions(),
            ])
          ],
        ),
      ),
    );
  }
}
