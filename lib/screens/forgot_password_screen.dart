import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/otp_screen.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkForgotPasswordScreen extends StatefulWidget {
  static const String id = 'reset_screen';

  @override
  _TkForgotPasswordScreenState createState() => _TkForgotPasswordScreenState();
}

class _TkForgotPasswordScreenState extends State<TkForgotPasswordScreen> {
  TkInfoFieldsList _fields;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kResetFieldsJson);
  }

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    // TODO: Call Login in Account Provider
    // TODO: Update user model with result from API
    // TODO: If Remember me is checked, save model to prefs
    // TODO: Encrypt password before sending it
    Navigator.pushNamed(context, TkOTPScreen.id);
  }

  Widget _createForm() {
    return TkFormFrame(
      formTitle: kResetFieldsJson[kFormName],
      actionTitle: kResetFieldsJson[kFormAction],
      buttonTag: kLoginTag,
      fields: _fields,
      action: (TkInfoFieldsList results) async {
        await _updateModel(results);
      },
    );
  }

  Widget _createLoginOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).kBackTo),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, TkLoginScreen.id),
              child: Text(
                S.of(context).kLoginExclamation,
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
