import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  int language = 0;
  // 0- English
  //1-Telugu
  //2 - Hindi
  setLocalizationMode(int languageToBeSet) async {
    language = languageToBeSet;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setInt("language_mode", languageToBeSet);
    notifyListeners();

    print("Button Pressed: $language");
  }
}
