import 'package:provider/provider.dart';

import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/purchaser.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/balace/user_package_list_pane.dart';

class TkBalanceScreen extends TkMultiStepPage {
  static const id = 'balance_screen';

  @override
  _TkBalanceScreenState createState() => _TkBalanceScreenState();
}

class _TkBalanceScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    // Load available packages
    Provider.of<TkPurchaser>(context, listen: false).loadBalance(
        Provider.of<TkAccount>(context, listen: false).user,
        notify: false);
  }

  @override
  List<TkPane> getPanes() {
    List<TkPane> panes = [TkUserPackageListPane(onDone: () => loadNextPane())];

    return panes;
  }
}
