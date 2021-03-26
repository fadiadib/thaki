import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

import 'package:thaki/widgets/base/appbar.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/forms/form_frame.dart';
import 'package:thaki/widgets/general/logo_box.dart';

class TkEditProfileScreen extends StatefulWidget {
  static const String id = 'edit_profile_screen';

  @override
  _TkEditProfileScreenState createState() => _TkEditProfileScreenState();
}

class _TkEditProfileScreenState extends State<TkEditProfileScreen> {
  TkInfoFieldsList _fields;

  @override
  void initState() {
    super.initState();

    _fields = TkInfoFieldsList.fromJson(data: kEditProfileFieldsJson);
  }

  Future<void> _updateModel(TkInfoFieldsList results) async {
    _fields = results;

    // TODO: Call Login in Account Provider
    // TODO: Update user model with result from API
    // TODO: If Remember me is checked, save model to prefs
    // TODO: Encrypt password before sending it

    Navigator.pop(context);
  }

  Widget _createForm() {
    return TkFormFrame(
      formTitle: kEditProfileFieldsJson[kFormName],
      actionTitle: kEditProfileFieldsJson[kFormAction],
      buttonTag: kSignUpTag,
      fields: _fields,
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
        child: Column(
          children: [
            TkLogoBox(),
            Expanded(flex: 5, child: _createForm()),
            Expanded(flex: 2, child: Text(kPasswordWontChange)),
            Expanded(flex: 1, child: Container())
          ],
        ),
      ),
    );
  }
}
