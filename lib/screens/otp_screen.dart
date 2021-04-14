import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/lang_controller.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkOTPScreen extends StatefulWidget {
  static const String id = 'otp_screen';

  @override
  _TkOTPScreenState createState() => _TkOTPScreenState();
}

class _TkOTPScreenState extends State<TkOTPScreen> {
  TkInfoFieldsList _fields;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kOTPFieldsJson);
  }

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    // TODO: Call Login in Account Provider
    // TODO: Update user model with result from API
    // TODO: If Remember me is checked, save model to prefs
    // TODO: Encrypt password before sending it
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
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      formTitle: kOTPFieldsJson[kFormName][controller.lang.languageCode],
      actionTitle: kOTPFieldsJson[kFormAction][controller.lang.languageCode],
      buttonTag: kLoginTag,
      fields: _fields,
      validatePasswordMatch: _validatePasswordMatch,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child:
            Text(S.of(context).kEnterOTPMessage, textAlign: TextAlign.center),
      ),
      action: (TkInfoFieldsList results) async {
        await _updateModel(results);
      },
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
