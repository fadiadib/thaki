import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/providers/permitter.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/id_card.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitDocumentsPane extends TkPane {
  TkPermitDocumentsPane({onDone})
      : super(paneTitle: kResidentPermit, onDone: onDone);

  Widget _getDocumentsWidgets() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        children: [
          TkIDCard(
            title: 'ID Card (Front)',
          ),
          SizedBox(
            height: 10,
          ),
          TkIDCard(
            title: 'ID Card (Back)',
          ),
        ],
      ),
    );
  }

  Widget _getAgreeButton() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 50.0, vertical: 20.0),
      child: TkButton(title: kContinue, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkPermitter>(
      builder: (context, permitter, _) {
        return permitter.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: kResidentPermit),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkTitleTextCard(
                      title: kUploadDocument,
                      child: Column(
                        children: [
                          _getDocumentsWidgets(),
                          _getAgreeButton(),
                        ],
                      ),
                    ),
                  ),
                ],
              );
      },
    );
  }
}
