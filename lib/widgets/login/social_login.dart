import 'package:flutter/material.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';

class TkSocialLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(S.of(context).kYouCanAlsoLoginWith),
        Container(
          width: 250,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(child: Image.asset(kFacebookBtn, height: 52.0)),
              GestureDetector(child: Image.asset(kTwitterBtn, height: 52.0)),
              GestureDetector(child: Image.asset(kGoogleBtn, height: 52.0))
            ],
          ),
        )
      ],
    );
  }
}
