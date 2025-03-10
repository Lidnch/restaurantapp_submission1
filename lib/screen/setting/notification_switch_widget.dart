import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/notification/local_notification_provider.dart';

class NotificationSwitchWidget extends StatefulWidget {

  const NotificationSwitchWidget({super.key});

  @override
  State<NotificationSwitchWidget> createState() => _NotificationSwitchWidgetState();
}

class _NotificationSwitchWidgetState extends State<NotificationSwitchWidget> {
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<LocalNotificationProvider>();
      provider.checkPendingNotificationRequests(context).then((_) {
        if(provider.pendingNotificationRequest.isNotEmpty) {
          setState(() {
            isEnabled = true;
          });
        }
      });
    });
  }


  @override
  Widget build(BuildContext context) {
    final notificationProvider = context.read<LocalNotificationProvider>();

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
                'Lunch reminder every day on 11.00',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
        Switch(
            value: isEnabled,
            onChanged: (value) {
               setState(() {
                 isEnabled = value;
               });
            }
        ),
      ],
    );
  }
}