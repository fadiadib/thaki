import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/lang_controller.dart';
import 'package:thaki/utilities/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkEditProfileScreen extends StatefulWidget {
  static const String id = 'edit_profile_screen';

  @override
  _TkEditProfileScreenState createState() => _TkEditProfileScreenState();
}

class _TkEditProfileScreenState extends State<TkEditProfileScreen> {
  TkInfoFieldsList _fields;

  Future<void> _updateModelAndPushNext(TkInfoFieldsList results) async {
    _fields = results;

    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    account.user.updateModelFromInfoFields(results);

    if (await account.edit()) Navigator.pop(context);
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
    TkLangController controller = Provider.of<TkLangController>(context);

    return TkFormFrame(
      langCode: controller.lang.languageCode,
      formTitle: kEditProfileFieldsJson[kFormName]
          [controller.lang.languageCode],
      actionTitle: kEditProfileFieldsJson[kFormAction]
          [controller.lang.languageCode],
      validatePasswordMatch: _validatePasswordMatch,
      buttonTag: kSignUpTag,
      fields: _fields,
      action: _updateModelAndPushNext,
      isLoading: account.isLoading,
      footer: Center(child: Text(S.of(context).kPasswordWontChange)),
      child: TkError(message: account.editError),
    );
  }

  @override
  void initState() {
    super.initState();

    TkAccount account = Provider.of<TkAccount>(context, listen: false);

    // Load info fields from model
    if (account.user.isSocial) {
      _fields = TkInfoFieldsList.fromJson(data: kEditSocialProfileFieldsJson);
    } else {
      _fields = TkInfoFieldsList.fromJson(data: kEditProfileFieldsJson);
    }

    account.clearErrors();
    if (account.user != null) _fields = account.user.toInfoFields(_fields);
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
              children: [TkLogoBox(), _createForm()],
            ),
          ],
        ),
      ),
    );
  }
}
