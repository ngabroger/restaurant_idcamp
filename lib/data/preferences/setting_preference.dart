import 'package:shared_preferences/shared_preferences.dart';

class SettingPreference {
  final Future<SharedPreferences> sharedPreference;
  SettingPreference(this.sharedPreference);
  static const String _keyDarkMode = 'dark_mode';
  static const String _keyNotification = 'notification';

  Future<bool> isNotificationActive() async {
    final prefs = await sharedPreference;
    return prefs.getBool(_keyNotification) ?? false;
  }

  Future<void> setNotificationActive(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(_keyNotification, value);
  }

  Future<bool> isDarkMode() async {
    final prefs = await sharedPreference;
    return prefs.getBool(_keyDarkMode) ?? false;
  }

  Future<void> setDarkMode(bool value) async {
    final prefs = await sharedPreference;
    prefs.setBool(_keyDarkMode, value);
  }
}
