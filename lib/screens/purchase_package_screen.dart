import 'package:provider/provider.dart';

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
    Provider.of<TkPurchaser>(context, listen: false).loadPackages();
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkPackageListPane(onDone: () => loadNextPane()),
      TkPackageDetailsPane(onDone: () => loadNextPane()),
      TkPackagePaymentPane(
        onDone: () {
          // Perform purchase by calling the API
          Provider.of<TkPurchaser>(context, listen: false)
              .purchaseSelectedPackage();

          // Load next pane
          loadNextPane();
        },
      ),
      TkPackageSuccessPane(
        onDone: () {
          // TODO: Reload user packages and balance

          // Load next pane
          loadNextPane();
        },
      ),
    ];
  }
}
