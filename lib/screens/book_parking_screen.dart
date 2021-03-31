import 'package:thaki/panes/parking/index.dart';
import 'package:thaki/widgets/base/index.dart';
import 'package:thaki/panes/violation/index.dart';

class TkBookParkingScreen extends TkMultiStepPage {
  static const id = 'book_parking_screen';

  @override
  _TkBookParkingScreenState createState() => _TkBookParkingScreenState();
}

class _TkBookParkingScreenState extends TkMultiStepPageState {
  @override
  void initData() async {}

  @override
  List<TkPane> getPanes() {
    return [
      TkParkingTimePane(onDone: () => loadNextPane()),
      TkParkingDurationPane(onDone: () => loadNextPane()),
      TkParkingSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
