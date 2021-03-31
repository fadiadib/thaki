import 'package:flutter/material.dart';

import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';

class TkPackageCard extends StatelessWidget {
  TkPackageCard({@required this.package});
  final TkPackage package;

  @override
  Widget build(BuildContext context) {
    return TkTitleTextCard(
      title: kPackageDetails,
      message: package.details,
    );
  }
}
