import 'dart:isolate';
import 'dart:ui';
import 'package:workmanager/workmanager.dart';

import '../data/api/api_service.dart';
import '../main.dart';
import 'notification_helper.dart';

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _service;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._createObject();

  factory BackgroundService() {
    _service ??= BackgroundService._createObject();
    return _service!;
  }

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
    Workmanager().initialize(callbackDispatcher);
  }

  static Future<void> callback() async {
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().getListRestaurant();
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }

  Future<void> someTask() async {}

  void scheduleDailyReminder() {
    Workmanager().registerPeriodicTask(
      "1",
      "simplePeriodicTask",
      frequency: Duration(hours: 24),
    );
  }
}

void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    await BackgroundService.callback();
    return Future.value(true);
  });
}
