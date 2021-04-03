import 'package:flutter/foundation.dart';

class TkTabSelector extends ChangeNotifier {
  int _activeTab = 2;
  int get activeTab => _activeTab;
  set activeTab(int index) {
    _activeTab = index;
    notifyListeners();
  }
}
