import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/forgot_password_screen.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/register_screen.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/error.dart';
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

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.clearErrors();

    if (account.user != null) _fields = account.user.toInfoFields(_fields);
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user = TkUser.fromInfoFields(results);

    if (await account.login(store: account.user.rememberMe))
      Navigator.pushNamed(context, TkHomeScreen.id);
  }

  Widget _createForm() {
    TkAccount account = Provider.of<TkAccount>(context);
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      // introTitle: S.of(context).kLoginIntroTitle,
      formTitle: kLoginFieldsJson[kFormName][controller.lang.languageCode],
      actionTitle: kLoginFieldsJson[kFormAction][controller.lang.languageCode],
      buttonTag: kLoginTag,
      fields: _fields,
      action: _updateModelAndPushNext,
      footer: Center(
        child: GestureDetector(
          onTap: () => Navigator.pushReplacementNamed(
              context, TkForgotPasswordScreen.id),
          child: Text(
            S.of(context).kForgotPassword,
            style: kLinkStyle,
          ),
        ),
      ),
      isLoading: account.isLoading,
      child: TkError(message: account.loginError),
    );
  }

  Widget _createLoginOptions() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(S.of(context).kNotRegisteredYet),
            GestureDetector(
              onTap: () =>
                  Navigator.pushReplacementNamed(context, TkRegisterScreen.id),
              child: Text(
                S.of(context).kSignUpExclamation,
                style: kRegularStyle[kSmallSize].copyWith(
                  color: kPrimaryColor,
                ),
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
