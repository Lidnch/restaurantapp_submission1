import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/style/theme_provider.dart';

class AppThemeSwitchWidget extends StatelessWidget {
  const AppThemeSwitchWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = context.read<ThemeProvider>();

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'App Theme',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text(
                  'Turn on dark mode',
                style: Theme.of(context).textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Switch(
            value: themeProvider.isDarkMode,
            onChanged: (value) {
              themeProvider.toggleTheme();
            }
        ),
      ],
    );
  }
}