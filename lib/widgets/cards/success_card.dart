import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';

class TkSuccessCard extends StatelessWidget {
  TkSuccessCard({@required this.message, this.result = true});
  final String message;
  final bool result;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(40.0),
          child: Image.asset(
            result ? kSuccessIcon : kFailureIcon,
            color: result ? kPrimaryColor : kErrorTextColor,
          ),
        ),
        TkTitleTextCard(
          title: result ? S.of(context).kSuccess : S.of(context).kFailure,
          message: message,
          titleColor: result ? kPrimaryColor : kErrorTextColor,
        ),
      ],
    );
  }
}
