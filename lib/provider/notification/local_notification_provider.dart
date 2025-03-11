import 'package:flutter/material.dart';
import 'package:restaurant_app/service/local/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool _isEnabled = false;

  bool? get permission => _permission;
  bool get isEnabled => _isEnabled;

  void toggleReminder() {
    _isEnabled = !_isEnabled;
    if(_isEnabled) {
      cancelAllNotification();
    } else {
      scheduleDailyElevenAMNotification();
    }

    _sa
  }

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
    _isEnabled = true;
  }

  Future<void> cancelAllNotification() async {
    await flutterNotificationService.cancelAllNotification();
  }
}