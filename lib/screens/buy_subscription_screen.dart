import 'package:provider/provider.dart';

import 'package:thaki/panes/subscription/index.dart';
import 'package:thaki/panes/subscription/subscription_list_pane.dart';
import 'package:thaki/panes/subscription/subscription_payment_pane.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/subscriber.dart';
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
    return [
      TkSubscriptionListPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);

        if (account.user.cards != null && account.user.cards.isNotEmpty)
          Provider.of<TkSubscriber>(context, listen: false).selectedCard =
              Provider.of<TkAccount>(context, listen: false).user.cards?.first;

        loadNextPane();
      }),
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
      TkSubscriptionSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
