import 'package:flutter/material.dart';
import 'package:restaurant_app/screen/setting/app_theme_switch_widget.dart';
import 'package:restaurant_app/screen/setting/notification_switch_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationSwitchWidget(),
            const SizedBox.square(dimension: 16,),
            AppThemeSwitchWidget(),
          ],
        ),
      ),
    );
  }
}