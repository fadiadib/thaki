import 'package:provider/provider.dart';
import 'package:thaki/panes/permit/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/subscriber.dart';
import 'package:thaki/widgets/base/index.dart';

class TkApplyForSubscriptionScreen extends TkMultiStepPage {
  static const id = 'apply_subscription_screen';

  @override
  _TkApplyForSubscriptionScreenState createState() =>
      _TkApplyForSubscriptionScreenState();
}

class _TkApplyForSubscriptionScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    TkAccount account = Provider.of<TkAccount>(context, listen: false);
    await Provider.of<TkSubscriber>(context, listen: false)
        .loadDisclaimer(account.user);
    await Provider.of<TkSubscriber>(context, listen: false)
        .loadDocuments(account.user);
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkPermitDisclaimerPane(onDone: () => loadNextPane()),
      TkPermitFormPane(onDone: () {
        Provider.of<TkSubscriber>(context, listen: false)
            .validationDocumentsError = null;
        loadNextPane();
      }),
      TkPermitDocumentsPane(
        onDone: () {
          TkAccount account = Provider.of<TkAccount>(context, listen: false);
          Provider.of<TkSubscriber>(context, listen: false)
              .applyForSubscription(account.user);

          loadNextPane();
        },
      ),
      TkPermitSuccessPane(onDone: () {
        loadNextPane();
      }),
    ];
  }
}
