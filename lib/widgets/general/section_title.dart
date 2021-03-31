import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkSectionTitle extends StatelessWidget {
  TkSectionTitle(
      {@required this.title,
      this.icon,
      this.action,
      this.uppercase = true,
      this.start = true});
  final String title;
  final IconData icon;
  final Function action;
  final bool uppercase;
  final bool start;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(start ? 30 : 5, 20, 30, 0),
      child: Row(
        mainAxisAlignment: icon == null
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          Text(
            uppercase ? title.toUpperCase() : title,
            style: kBoldStyle[kNormalSize],
          ),
          if (icon != null)
            GestureDetector(
                onTap: action,
                child: Icon(
                  icon,
                  color: kSecondaryColor,
                )),
        ],
      ),
    );
  }
}
