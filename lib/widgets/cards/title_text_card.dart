import 'package:flutter/material.dart';
import 'package:thaki/globals/colors.dart';
import 'package:thaki/globals/index.dart';

class TkTitleTextCard extends StatelessWidget {
  TkTitleTextCard({
    @required this.title,
    this.message,
    this.child,
    this.titleColor = kPrimaryColor,
    this.messageColor,
    this.icon,
  });
  final String title;
  final String message;
  final Color titleColor;
  final Color messageColor;
  final Widget child;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: kTileBgColor,
            boxShadow: kTileShadow,
            borderRadius: BorderRadius.circular(4.0),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Text(
                  title,
                  style: kBoldStyle[kBigSize].copyWith(color: titleColor),
                ),
              ),
              Divider(color: kAccentGreyColor, thickness: 1.0),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Row(
                  children: [
                    if (icon != null)
                      Padding(
                        padding: const EdgeInsetsDirectional.only(end: 8.0),
                        child: Icon(icon, color: titleColor),
                      ),
                    Expanded(
                      child: Text(
                        message != null ? message : title,
                        style: kRegularStyle[kSmallSize]
                            .copyWith(color: messageColor ?? kDarkGreyColor),
                      ),
                    ),
                  ],
                ),
              ),
              if (child != null) child,
            ],
          ),
        )
      ],
    );
  }
}
