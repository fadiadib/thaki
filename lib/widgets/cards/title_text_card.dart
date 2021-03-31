import 'package:flutter/material.dart';
import 'package:thaki/globals/colors.dart';
import 'package:thaki/globals/index.dart';

class TkTitleTextCard extends StatelessWidget {
  TkTitleTextCard(
      {@required this.title,
      this.message,
      this.child,
      this.titleColor = kPrimaryColor});
  final String title;
  final String message;
  final Color titleColor;
  final Widget child;

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
              if (message != null)
                Padding(
                    padding: const EdgeInsets.all(20), child: Text(message)),
              if (child != null) child,
            ],
          ),
        )
      ],
    );
  }
}
