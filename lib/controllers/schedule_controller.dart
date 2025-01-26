import 'package:workmanager/workmanager.dart';
import 'package:find_restaurant/utils/background_service.dart';
import 'package:flutter/material.dart';

class ScheduleController extends ChangeNotifier {
  bool _isSelected = false;
  bool get isSelected => _isSelected;

  Future<void> scheduleRestaurant(bool value) async {
    _isSelected = value;
    notifyListeners();
    if (_isSelected) {
      notifyListeners();
      BackgroundService().scheduleDailyReminder();
    } else {
      notifyListeners();
      await Workmanager().cancelAll();
    }
  }
}
