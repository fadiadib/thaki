import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/cards/success_card.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/subscription_tile.dart';

class TkSubscriptionSuccessPane extends TkPane {
  TkSubscriptionSuccessPane({onDone})
      : super(paneTitle: '', onDone: onDone, allowNavigation: false);

  Widget _getSubscriptionTile(TkSubscriber subscriber) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
      child: TkSubscriptionTile(
          subscription: subscriber.selectedSubscription, isSelected: true),
    );
  }

  Widget _getCloseButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(title: S.of(context).kClose, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkSubscriber>(
      builder: (context, subscriber, _) {
        return subscriber.isLoading
            ? TkProgressIndicator()
            : ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                    child:
                        TkSectionTitle(title: S.of(context).kBuySubscription),
                  ),

                  // Show the selected subscription
                  _getSubscriptionTile(subscriber),

                  // Result is dependent on the purchaser result
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: TkSuccessCard(
                      message: subscriber.error[TkSubscriberError.buy] == null
                          ? S.of(context).kSubscriptionSuccess
                          : subscriber.error[TkSubscriberError.buy],
                      result: subscriber.error[TkSubscriberError.buy] == null,
                    ),
                  ),
                  _getCloseButton(context),
                ],
              );
      },
    );
  }
}
