import 'package:flutter/material.dart';
import 'package:thaki/globals/index.dart';

class TkSocialLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(kYouCanAlsoLoginWith),
        Container(
          width: 250,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(child: Image.asset(kFacebookBtn)),
              GestureDetector(child: Image.asset(kTwitterBtn)),
              GestureDetector(child: Image.asset(kGoogleBtn))
            ],
          ),
        )
      ],
    );
  }
}
