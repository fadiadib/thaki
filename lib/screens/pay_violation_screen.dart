import 'package:provider/provider.dart';

import 'package:thaki/providers/payer.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/violation/index.dart';

class TkPayViolationScreen extends TkMultiStepPage {
  static const id = 'pay_violation_screen';

  @override
  _TkPayViolationScreenState createState() => _TkPayViolationScreenState();
}

class _TkPayViolationScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    // Load available packages
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkViolationCarPane(onDone: () {
        Provider.of<TkPayer>(context, listen: false).loadViolations();

        loadNextPane();
      }),
      TkViolationListPane(onDone: () => loadNextPane()),
      TkViolationPaymentPane(onDone: () {
        Provider.of<TkPayer>(context, listen: false).paySelectedViolations();
        loadNextPane();
      }),
      TkViolationSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
