import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:thaki/generated/l10n.dart';
import 'package:thaki/models/index.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/widgets/general/progress_indicator.dart';
import 'package:thaki/widgets/forms/button.dart';
import 'package:thaki/widgets/general/section_title.dart';
import 'package:thaki/widgets/tiles/subscription_tile.dart';

class TkSubscriptionListPane extends TkPane {
  TkSubscriptionListPane({onDone}) : super(paneTitle: '', onDone: onDone);

  Widget _getSubscriptionTiles(TkSubscriber subscriber) {
    List<Widget> tiles = [];
    for (TkSubscription subscription in subscriber.subscriptions) {
      tiles.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 7.0),
          child: TkSubscriptionTile(
            subscription: subscription,
            isSelected: subscriber.selectedSubscription == subscription,
            onTap: () {
              // Save the selected subscription in the model provider
              subscriber.selectedSubscription = subscription;
            },
          ),
        ),
      );
    }
    return Column(children: tiles);
  }

  Widget _getContinueButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(50.0, 20.0, 50.0, 0),
      child: TkButton(title: S.of(context).kContinue, onPressed: onDone),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<TkSubscriber>(builder: (context, subscriber, _) {
      return subscriber.isLoading
          ? TkProgressIndicator()
          : ListView(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20.0),
                  child: TkSectionTitle(title: S.of(context).kBuySubscription),
                ),
                _getSubscriptionTiles(subscriber),
                _getContinueButton(context),
              ],
            );
    });
  }
}
