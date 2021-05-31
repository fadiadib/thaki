import 'package:provider/provider.dart';
import 'package:thaki/globals/index.dart';

import 'package:thaki/panes/subscription/index.dart';
import 'package:thaki/panes/subscription/subscription_list_pane.dart';
import 'package:thaki/panes/subscription/subscription_payment_pane.dart';
import 'package:thaki/panes/transaction/transaction_pane.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/providers/transactor.dart';
import 'package:thaki/widgets/base/index.dart';

class TkBuySubscriptionScreen extends TkMultiStepPage {
  static const id = 'buy_subscription_screen';

  @override
  _TkBuySubscriptionScreenState createState() =>
      _TkBuySubscriptionScreenState();
}

class _TkBuySubscriptionScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    await Provider.of<TkSubscriber>(context, listen: false)
        .loadSubscriptions(Provider.of<TkAccount>(context, listen: false).user);
  }

  @override
  List<TkPane> getPanes() {
    List<TkPane> panes = [
      TkSubscriptionListPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);

        if (kSaveCardMode) {
          if (account.user.cards != null && account.user.cards.isNotEmpty)
            Provider.of<TkSubscriber>(context, listen: false).selectedCard =
                Provider.of<TkAccount>(context, listen: false)
                    .user
                    .cards
                    ?.first;
        } else {
          TkTransactor transactor =
              Provider.of<TkTransactor>(context, listen: false);
          transactor.initTransaction(
              user: account.user,
              type: 'Subscription',
              id: Provider.of<TkSubscriber>(context, listen: false)
                  .selectedSubscription
                  .id,
              car: Provider.of<TkSubscriber>(context, listen: false)
                  .selectedCar);
        }
        loadNextPane();
      })
    ];

    if (kSaveCardMode) {
      panes.add(
        TkSubscriptionPaymentPane(
          onDone: () {
            // Perform purchase by calling the API
            Provider.of<TkSubscriber>(context, listen: false)
                .purchaseSelectedSubscription(
                    Provider.of<TkAccount>(context, listen: false).user);

            // Load next pane
            loadNextPane();
          },
        ),
      );
      panes.add(TkSubscriptionSuccessPane(onDone: () => loadNextPane()));
    } else {
      panes.add(TkTransactionPane(onDone: () => loadNextPane()));
    }
    return panes;
  }
}
