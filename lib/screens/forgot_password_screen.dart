import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/screens/login_screen.dart';
import 'package:thaki/screens/otp_screen.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkForgotPasswordScreen extends StatefulWidget {
  static const String id = 'reset_screen';

  @override
  _TkForgotPasswordScreenState createState() => _TkForgotPasswordScreenState();
}

class _TkForgotPasswordScreenState extends State<TkForgotPasswordScreen> {
  TkInfoFieldsList? _fields;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kResetFieldsJson);

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.clearErrors();

    if (_fields != null && account.user != null) _fields = account.user!.toInfoFields(_fields!);
  }

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user = TkUser.fromInfoFields(results);

    if (await account.forgotPassword())
      Navigator.pushNamed(context, TkOTPScreen.id);
  }

  Widget _createForm() {
    TkAccount account = Provider.of<TkAccount>(context);
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      isLoading: account.isLoading,
      langCode: controller.lang!.languageCode,
      formTitle: kResetFieldsJson[kFormName][controller.lang!.languageCode],
      actionTitle: kResetFieldsJson[kFormAction][controller.lang!.languageCode],
      buttonTag: kLoginTag,
      fields: _fields,
      action: (TkInfoFieldsList results) async {
        await _updateModel(results);
      },
      footer: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(S.of(context).kBackTo),
          GestureDetector(
            onTap: () =>
                Navigator.pushReplacementNamed(context, TkLoginScreen.id),
            child: Text(
              S.of(context).kLoginExclamation,
              style: kRegularStyle[kSmallSize]!.copyWith(
                color: kPrimaryColor,
              ),
            ),
          )
        ],
      ),
      child: TkError(message: account.forgotPasswordError),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => true,
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
              Column(children: [TkLogoBox(), _createForm()]),
            ],
          ),
        ),
      ),
    );
  }
}
