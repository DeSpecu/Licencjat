import 'package:flutter/material.dart';
import 'preferences.dart';

class ModelTheme extends ChangeNotifier {
  late bool _isDark;
  final ThemePreferences _preferences = ThemePreferences();
  bool get isDark => _isDark;

  ModelTheme() {
    _isDark = false;
    getPreferences();
  }

  set isDark(bool value) {
    _isDark = value;
    _preferences.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _preferences.getTheme();
    notifyListeners();
  }
}