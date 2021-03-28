import 'package:flutter/material.dart';
import 'package:thaki/globals/icons.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';

class TkUserInfoCard extends StatelessWidget {
  TkUserInfoCard({this.user});
  final TkUser user;

  Widget _getInfoRow({IconData iconData, String title}) {
    return Row(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5.0),
        child: Icon(iconData, color: kPrimaryIconColor),
      ),
      Text(title, style: kRegularStyle[kNormalSize]),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _getInfoRow(iconData: kProfileOutlineBtnIcon, title: user.name),
        _getInfoRow(iconData: kEmailOutlineBtnIcon, title: user.email),
        _getInfoRow(iconData: kPhoneBtnIcon, title: user.phone),
      ],
    );
  }
}
