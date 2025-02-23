import 'package:flutter/material.dart';
import 'package:restaurant_app/style/theme/app_theme.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  AppTheme? _theme = AppTheme.system;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
            "Settings",
          style: TextStyle(
            color: Colors.orangeAccent,
          ),
        ),
        backgroundColor: Colors.teal,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(),
        children: [
          const Text("Theme"),
          ListTile(
            title: const Text("System"),
            leading: Radio<AppTheme>(
                value: AppTheme.system,
                groupValue: _theme,
                onChanged: (AppTheme? value) {
                  setState(() {
                    _theme = value;
                  });
                }
            ),
          ),
          ListTile(
            title: const Text("Light"),
            leading: Radio<AppTheme>(
                value: AppTheme.light,
                groupValue: _theme,
                onChanged: (AppTheme? value) {
                  setState(() {
                    _theme = value;
                  });
                }
            ),
          ),
          ListTile(
            title: const Text("Dark"),
            leading: Radio<AppTheme>(
                value: AppTheme.dark,
                groupValue: _theme,
                onChanged: (AppTheme? value) {
                  setState(() {
                    _theme = value;
                  });
                }
            ),
          ),
        ],
      ),
    );
  }
}