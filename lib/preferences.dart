import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences with ChangeNotifier {
  static const _alarmKey = 'alarm';
  static const _noAlarm = 'none';

  late SharedPreferences _sharedPreferences;

  DateTime? _alarmTime;

  Preferences() {
    _initPreferencesAsync().then<void>((_) {
      final alarm = _sharedPreferences.getString(_alarmKey) ?? _noAlarm;
      if (alarm == _noAlarm) {
        _alarmTime = null;
      } else {
        _alarmTime = DateTime.tryParse(alarm);
      }
      notifyListeners();
    });
  }

  DateTime? get alarm => _alarmTime;

  void setAlarm({required DateTime? alarm}) {
    _alarmTime = alarm;
    _sharedPreferences.setString(_alarmKey, _alarmTime?.toString() ?? _noAlarm);
  }

  Future<void> _initPreferencesAsync() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
