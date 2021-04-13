import 'package:provider/provider.dart';
import 'package:thaki/providers/account.dart';

import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/package/index.dart';

class TkPurchasePackageScreen extends TkMultiStepPage {
  static const id = 'purchase_package_screen';

  @override
  _TkPurchasePackageScreenState createState() =>
      _TkPurchasePackageScreenState();
}

class _TkPurchasePackageScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    // Load available packages
    Provider.of<TkPurchaser>(context, listen: false)
        .loadPackages(Provider.of<TkAccount>(context, listen: false).user);
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkPackageListPane(onDone: () => loadNextPane()),
      TkPackageDetailsPane(onDone: () {
        TkAccount account = Provider.of<TkAccount>(context, listen: false);

        if (account.user.cards != null && account.user.cards.isNotEmpty)
          Provider.of<TkPurchaser>(context, listen: false).selectedCard =
              account.user.cards?.first;

        loadNextPane();
      }),
      TkPackagePaymentPane(
        onDone: () {
          // Perform purchase by calling the API
          Provider.of<TkPurchaser>(context, listen: false)
              .purchaseSelectedPackage(
                  Provider.of<TkAccount>(context, listen: false).user);

          // Load next pane
          loadNextPane();
        },
      ),
      TkPackageSuccessPane(
        onDone: () {
          // Load next pane
          loadNextPane();
        },
      ),
    ];
  }
}
