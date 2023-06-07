import 'package:flutter/widgets.dart';

class PorviderLang extends ChangeNotifier {
 String lang = WidgetsBinding.instance.window.locales.first.languageCode;

  changLang() {
    if (lang == 'ar') {
      lang = 'en';
    } else if (lang == 'en') {
      lang = 'ar';
    }

    notifyListeners();
  }
}