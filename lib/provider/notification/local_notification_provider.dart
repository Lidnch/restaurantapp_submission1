import 'package:flutter/material.dart';
import 'package:restaurant_app/service/local/local_notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;
  static const String _stateKey = "isEnabled";

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool _isEnabled = false;

  bool? get permission => _permission;
  bool get isEnabled => _isEnabled;

  void toggleReminder() {
    _isEnabled = !_isEnabled;
    isEnabled
        ? scheduleDailyElevenAMNotification()
        : cancelAllNotification();
    notifyListeners();
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

  Future<void> _loadReminder() async {
    final prefs = await SharedPreferences.getInstance();
    _isEnabled = prefs.getBool(_stateKey) ?? false;
    _isEnabled
        ? scheduleDailyElevenAMNotification()
        : cancelAllNotification();
    notifyListeners();
  }

  Future<void> _saveReminder(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_stateKey, value);
  }
}