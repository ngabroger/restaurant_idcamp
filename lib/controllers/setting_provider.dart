import 'package:find_restaurant/data/preferences/setting_preference.dart';
import 'package:flutter/material.dart';

class SettingProvider extends ChangeNotifier {
  SettingPreference settingPreference;

  SettingProvider({required this.settingPreference}) {
    _loadFromPrefs();
  }

  bool _notification = false;
  bool get notification => _notification;

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
    _notification = await settingPreference.isNotificationActive();
    notifyListeners();
  }

  void toogleNotification(bool value) {
    _notification = value;
    settingPreference.setNotificationActive(value);
    notifyListeners();
  }

  void _saveToPrefs() async {
    await settingPreference.setDarkMode(_darkTheme);
  }
}
