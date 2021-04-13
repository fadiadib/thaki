import 'package:provider/provider.dart';

import 'package:thaki/panes/parking/index.dart';
import 'package:thaki/providers/account.dart';
import 'package:thaki/providers/booker.dart';
import 'package:thaki/widgets/base/index.dart';

class TkBookParkingScreen extends TkMultiStepPage {
  static const id = 'book_parking_screen';

  @override
  _TkBookParkingScreenState createState() => _TkBookParkingScreenState();
}

class _TkBookParkingScreenState extends TkMultiStepPageState {
  @override
  void initData() async {
    Provider.of<TkBooker>(context, listen: false).clearBooking();
  }

  @override
  List<TkPane> getPanes() {
    return [
      TkParkingTimePane(onDone: () => loadNextPane()),
      TkParkingDurationPane(onDone: () {
        // Book parking
        Provider.of<TkBooker>(context, listen: false).reserveParking(
            Provider.of<TkAccount>(context, listen: false).user);

        // Load next screen
        loadNextPane();
      }),
      TkParkingSuccessPane(onDone: () => loadNextPane()),
    ];
  }
}
