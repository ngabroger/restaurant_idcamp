import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:find_restaurant/utils/background_service.dart';
import 'package:find_restaurant/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

class ScheduleController extends ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  Future<void> scheduleRestaurant(bool value) async {
    _isSelected = value;
    notifyListeners();
    if (_isSelected) {
      notifyListeners();
      await AndroidAlarmManager.periodic(
          const Duration(hours: 24), 1, BackgroundService.callback,
          startAt: DateTimeHelper.format(), exact: true, wakeup: true);
    } else {
      notifyListeners();
      await AndroidAlarmManager.cancel(1);
    }
  }
}
