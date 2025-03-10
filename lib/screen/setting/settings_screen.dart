import 'package:flutter/material.dart';

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
        title: Text("Settings"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Row(
              children: [
                Column(
                  children: [
                    Text(
                      "Restaurant Notification",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                        "Enable notification",
                      style: Theme.of(context).textTheme.displayMedium,
                    ),
                  ],
                ),
                Placeholder(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}