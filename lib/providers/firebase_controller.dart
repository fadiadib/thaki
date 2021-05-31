import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

class TkFirebaseController extends ChangeNotifier {
  void initializeFlutterFire() async {
    await Firebase.initializeApp();
  }
}
