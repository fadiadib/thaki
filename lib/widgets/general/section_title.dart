import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkSectionTitle extends StatelessWidget {
  TkSectionTitle({
    required this.title,
    this.icon,
    this.action,
    this.uppercase = true,
    this.start = true,
    this.noPadding = false,
  });
  final String title;
  final IconData? icon;
  final Function? action;
  final bool uppercase;
  final bool start;
  final bool noPadding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: noPadding
          ? EdgeInsets.all(0)
          : EdgeInsetsDirectional.fromSTEB(start ? 30 : 5, 20, 30, 0),
      child: Row(
        mainAxisAlignment: icon == null
            ? MainAxisAlignment.start
            : MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              uppercase ? title.toUpperCase() : title,
              style: kBoldStyle[kSmallSize],
            ),
          ),
          if (icon != null)
            GestureDetector(
                onTap: action as void Function()?,
                child: Icon(
                  icon,
                  color: kSecondaryColor,
                )),
        ],
      ),
    );
  }
}
