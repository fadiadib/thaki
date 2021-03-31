import 'package:provider/provider.dart';
import 'package:thaki/panes/permit/index.dart';
import 'package:thaki/providers/permitter.dart';
import 'package:thaki/widgets/base/index.dart';

class TkResidentPermitScreen extends TkMultiStepPage {
  static const id = 'resident_permit_screen';

  @override
  _TkResidentPermitScreenState createState() => _TkResidentPermitScreenState();
}

class _TkResidentPermitScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    Provider.of<TkPermitter>(context, listen: false).loadDisclaimer();
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkPermitDisclaimerPane(onDone: () => loadNextPane()),
      TkPermitFormPane(onDone: () => loadNextPane()),
      TkPermitDocumentsPane(onDone: () => loadNextPane()),
      TkPermitSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
