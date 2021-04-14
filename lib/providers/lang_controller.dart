import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:thaki/globals/index.dart';
import 'package:thaki/utilities/index.dart';

class TkLangController extends ChangeNotifier {
  TkSharedPrefHelper _prefs = TkSharedPrefHelper();

  Locale lang;
  String fontFamily;

  void switchLang() {
    if (lang.languageCode == 'en') {
      lang = Locale('ar', '');
      fontFamily = kRTLFontFamily;
    } else {
      lang = Locale('en', '');
      fontFamily = kLTRFontFamily;
    }
    _prefs.store(tag: kLangTag, data: lang.languageCode);

    notifyListeners();
  }

  void initLang() async {
    String langCode = await _prefs.get(tag: kLangTag);
    if (langCode == null) {
      // No language selected, choose default
      langCode = 'en';
      if (kDefaultToAR) langCode = 'ar';
    }

    if (langCode == 'en') {
      lang = Locale('en', '');
      fontFamily = kLTRFontFamily;
    } else {
      lang = Locale('ar', '');
      fontFamily = kRTLFontFamily;
    }

    _prefs.store(tag: kLangTag, data: lang.languageCode);
    notifyListeners();
  }
}
