import 'package:shared_preferences/shared_preferences.dart';

import '../../model/setting.dart';

class SharedPreferencesService {
  final SharedPreferences _preferences;

  SharedPreferencesService(this._preferences);

  static const String keyNotification = "MY_NOTIFICATION";

  Future<void> saveSettingValue(Setting setting) async {
    try {
      await _preferences.setBool(keyNotification, setting.notificationEnable);
    } catch (e) {
      throw Exception("Shared preferences cannot save the setting value.");
    }
  }

  Setting getSettingValue() {
    return Setting(
        notificationEnable: _preferences.getBool(keyNotification) ?? true,
    );
  }
}