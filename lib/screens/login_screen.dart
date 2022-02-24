import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/edit_profile_screen.dart';
import 'package:thaki/screens/forgot_password_screen.dart';
import 'package:thaki/screens/home_screen.dart';
import 'package:thaki/screens/register_screen.dart';
import 'package:thaki/screens/welcome_screen.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/login/social_login.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkLoginScreen extends StatefulWidget {
  static const String id = 'login_screen';
  TkLoginScreen({this.showPasswordSuccess = false});
  final bool showPasswordSuccess;

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

    if (widget.showPasswordSuccess)
      Future.delayed(Duration(milliseconds: 100)).then(
        (value) =>
            TkSnackBarHelper.show(context, S.of(context).kUserProfileUpdated),
      );
  }

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user = TkUser.fromInfoFields(results);

    if (await account.login(store: account.user.rememberMe))
      Navigator.pushReplacementNamed(context, TkHomeScreen.id);
  }

  Widget _createForm(TkAccount account) {
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      // introTitle: S.of(context).kLoginIntroTitle,
      formTitle: kLoginFieldsJson[kFormName][controller.lang.languageCode],
      actionTitle: kLoginFieldsJson[kFormAction][controller.lang.languageCode],
      buttonTag: kLoginTag,
      fields: _fields,
      action: _updateModelAndPushNext,
      footer: Column(
        children: [
          Center(
            child: GestureDetector(
              onTap: () =>
                  Navigator.pushNamed(context, TkForgotPasswordScreen.id),
              child: Text(
                S.of(context).kForgotPassword,
                style: kLinkStyle,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(S.of(context).kNotRegisteredYet + ' '),
                GestureDetector(
                  onTap: () => Navigator.pushReplacementNamed(
                      context, TkRegisterScreen.id),
                  child: Text(
                    S.of(context).kSignUpExclamation,
                    style: kRegularStyle[kSmallSize].copyWith(
                      color: kPrimaryColor,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      isLoading: account.isLoading,
      child: Column(
        children: [
          TkError(message: account.loginError),
          TkError(message: account.socialError),
        ],
      ),
    );
  }

  Widget _createSocialLogin(TkAccount account) {
    return TkSocialLogin(
      callback: () async {
        if (await account.social()) {
          if (account.user != null) {
            if (account.user.needsUpdate) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  settings: RouteSettings(name: TkEditProfileScreen.id),
                  builder: (context) => TkEditProfileScreen(pushHomeMode: true),
                ),
              );
            } else {
              await Navigator.pushReplacementNamed(context, TkHomeScreen.id);
            }
          }
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkAccount>(
      builder: (context, account, _) {
        return WillPopScope(
          onWillPop: () async => true,
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
                  Column(children: [
                    TkLogoBox(),
                    _createForm(account),
                    _createSocialLogin(account),
                  ])
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
