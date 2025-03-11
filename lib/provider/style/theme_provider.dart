import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/style/theme/restaurant_theme.dart';

class ThemeProvider extends ChangeNotifier {
  static const String _themeKey = "isDarkMode";

  ThemeData _theme = RestaurantTheme.lightTheme;
  bool _isDarkMode = false;

  ThemeProvider() {
    _loadTheme();
  }

  ThemeData get theme => _theme;
  bool get isDarkMode => _isDarkMode;
  ThemeMode get themeMode => _isDarkMode ? ThemeMode.dark : ThemeMode.light;

  void toggleTheme(){
    _isDarkMode = !_isDarkMode;
    _theme = _isDarkMode ? RestaurantTheme.darkTheme : RestaurantTheme.lightTheme;

    _saveTheme(_isDarkMode);
    notifyListeners();
  }

  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    _isDarkMode = prefs.getBool(_themeKey) ?? false;
    _theme = _isDarkMode ? RestaurantTheme.darkTheme : RestaurantTheme.lightTheme;
    notifyListeners();
  }

  Future<void> _saveTheme(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_themeKey, value);
  }
}