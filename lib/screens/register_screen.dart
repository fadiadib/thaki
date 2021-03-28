import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
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

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    // TODO: Call Login in Account Provider
    // TODO: Update user model with result from API
    // TODO: If Remember me is checked, save model to prefs
    // TODO: Encrypt password before sending it

    Navigator.pushNamed(context, TkHomeScreen.id);
  }

  Widget _createForm() {
    return TkFormFrame(
      formTitle: kRegisterFieldsJson[kFormName],
      actionTitle: kRegisterFieldsJson[kFormAction],
      buttonTag: kSignUpTag,
      fields: _fields,
      action: (TkInfoFieldsList results) async {
        await _updateModel(results);
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
