import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationSwitchWidget extends StatelessWidget {
  const NotificationSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final localNotificationProvider = Provider.of<LocalNotificationProvider>(context);

    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Daily Reminder',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                'Lunch reminder every day at 11:00 AM',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Consumer<LocalNotificationProvider>(
          builder: (context, value, child){
          return Switch(
            value: localNotificationProvider.isEnabled,
            onChanged: (bool value) async {
              if (value) {
               localNotificationProvider.scheduleDailyElevenAMNotification();
              } else {
                await localNotificationProvider.cancelAllNotification();
              }

              await _saveReminderStatus(value);

              (context as Element).markNeedsBuild();
            },
          );
        }),
      ],
    );
  }

  Future<void> _saveReminderStatus(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isReminderOn', value);
  }

  Future<bool> _getReminderStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isReminderOn') ?? false;
  }
}
