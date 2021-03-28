import 'package:provider/provider.dart';

import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';

import 'package:thaki/panes/package/package_details_pane.dart';
import 'package:thaki/panes/package/package_list_pane.dart';
import 'package:thaki/panes/package/package_payment_pane.dart';
import 'package:thaki/panes/package/package_success_pane.dart';

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
      TkPackageListPane(
        onDone: () {
          // Load next pane
          loadNextPane();
        },
      ),
      TkPackageDetailsPane(
        onDone: () {
          // Load next pane
          loadNextPane();
        },
      ),
      TkPackagePaymentPane(
        onDone: () {
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
