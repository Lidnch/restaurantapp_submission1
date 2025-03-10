import 'package:flutter/material.dart';

class NotificationSwitchWidget extends StatefulWidget {

  NotificationSwitchWidget({super.key});

  @override
  State<NotificationSwitchWidget> createState() => _NotificationSwitchWidgetState();
}

class _NotificationSwitchWidgetState extends State<NotificationSwitchWidget> {
  @override
  void initState() {
    super.initState();
  }
  bool isEnabled = true;

  @override
  Widget build(BuildContext context) {
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