import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/id_card.dart';
import 'package:thaki/widgets/cards/title_text_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/error.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';

class TkPermitDocumentsPane extends TkPane {
  TkPermitDocumentsPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getDocumentsWidgets(BuildContext context, TkSubscriber subscriber) {
    List<Widget> widgets = [];
    for (TkDocument doc in subscriber.documents) {
      widgets.add(
        Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: TkIDCard(
            requiredMark: doc.required,
            title: doc.title,
            image: doc.image,
            callback: (File imageFile) =>
                subscriber.updateDocument(doc.tag, imageFile),
            cancelCallback: () => subscriber.updateDocument(doc.tag, null),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(children: widgets),
    );
  }

  Widget _getAgreeButton(TkSubscriber subscriber, BuildContext context,
      ScrollController scrollController) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20.0),
      child: TkButton(
          title: S.of(context).kContinue,
          onPressed: () {
            if (subscriber.validateDocuments(context))
              onDone();
            else
              scrollController.animateTo(0,
                  duration: Duration(milliseconds: 600), curve: Curves.easeOut);
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    ScrollController scrollController = ScrollController();
    return Consumer<TkSubscriber>(
      builder: (context, subscriber, _) {
        return subscriber.isLoading
            ? TkProgressIndicator()
            : ListView(
                controller: scrollController,
                reverse: true,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child:
                        TkError(message: subscriber.validationDocumentsError),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkTitleTextCard(
                      title: S.of(context).kUploadDocument,
                      message: S.of(context).kSecuredData,
                      icon: kSecuredBtnIcon,
                      child: Column(
                        children: [
                          _getDocumentsWidgets(context, subscriber),
                          _getAgreeButton(
                              subscriber, context, scrollController),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child: TkSectionTitle(title: S.of(context).kResidentPermit),
                  ),
                ],
              );
      },
    );
  }
}
