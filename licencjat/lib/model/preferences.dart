import 'package:shared_preferences/shared_preferences.dart';

class ThemePreferences {
  static const _key = "licencjat";

  setTheme(bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    sharedPreferences.setBool(_key, value);
  }

  getTheme() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    if(sharedPreferences.getBool(_key) == null)
      return false;
  }
}
