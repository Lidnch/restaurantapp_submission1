import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/service/local/local_notification_service.dart';

class LocalNotificationProvider extends ChangeNotifier {
  final LocalNotificationService flutterNotificationService;

  LocalNotificationProvider(this.flutterNotificationService);

  int _notificationId = 0;
  bool? _permission = false;
  bool _isInitialized = false;

  bool? get permission => _permission;
  bool get isInitialized => _isInitialized;

  List<PendingNotificationRequest> pendingNotificationRequest = [];

  Future<void> requestPermissions() async {
    _permission = await flutterNotificationService.requestPermissions();
    notifyListeners();
  }

  void scheduleDailyElevenAMNotification() {
    _notificationId += 1;
    flutterNotificationService.scheduleDailyElevenAMNotification(
      id: _notificationId,
    );
  }

  Future<void> cancelAllNotification() async {
    await flutterNotificationService.cancelAllNotification();
  }
}