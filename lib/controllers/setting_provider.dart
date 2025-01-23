import 'package:find_restaurant/controllers/schedule_controller.dart';
import 'package:find_restaurant/data/preferences/setting_preference.dart';
import 'package:find_restaurant/main.dart';
import 'package:find_restaurant/utils/notification_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class SettingProvider extends ChangeNotifier {
  final NotificationHelper _notificationHelper = NotificationHelper();
  SettingPreference settingPreference;

  ScheduleController scheduleController = ScheduleController();

  SettingProvider({required this.settingPreference}) {
    _loadFromPrefs();
  }

  bool? _permission = false;
  bool? get permission => _permission;

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

  void toggleNotification(bool value) async {
    _notification = value;
    settingPreference.setNotificationActive(value);
    if (value) {
      final permissionGranted = await _notificationHelper.requestPermissions();
      if (permissionGranted == true) {
        scheduleController.scheduleRestaurant(value);
      } else {
        _notification = false;
        settingPreference.setNotificationActive(false);
      }
    } else {
      scheduleController.scheduleRestaurant(value);
    }
    notifyListeners();
  }

  void _saveToPrefs() async {
    await settingPreference.setDarkMode(_darkTheme);
  }

  Future<void> requestPermission() async {
    _permission = await _notificationHelper.requestPermissions();
    notifyListeners();
  }
}
