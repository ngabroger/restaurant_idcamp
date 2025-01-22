import 'package:find_restaurant/data/preferences/setting_preference.dart';
import 'package:flutter/material.dart';

class DarkThemeProvider extends ChangeNotifier {
  SettingPreference settingPreference;

  DarkThemeProvider({required this.settingPreference}) {
    _loadFromPrefs();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

  void toogleTheme(bool value) {
    _darkTheme = value;
    _saveToPrefs();
    notifyListeners();
  }

  void _loadFromPrefs() async {
    _darkTheme = await settingPreference.isDarkMode();
    notifyListeners();
  }

  void _saveToPrefs() async {
    await settingPreference.setDarkMode(_darkTheme);
  }
}
