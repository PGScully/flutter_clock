import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

final alarmProvider = StateNotifierProvider<AlarmPreference, DateTime?>((ref) => AlarmPreference());

class AlarmPreference extends StateNotifier<DateTime?> {
  static const _alarmKey = 'alarm';
  static const _noAlarm = 'none';

  late SharedPreferences _sharedPreferences;

  AlarmPreference() : super(null) {
    _initPreferences().then<void>((_) {
      final alarm = _sharedPreferences.getString(_alarmKey) ?? _noAlarm;
      final result = alarm == _noAlarm ? null : DateTime.tryParse(alarm);
      state = result;
    });
  }

  DateTime? get alarm => state;

  void setAlarm({required DateTime? alarm}) {
    _sharedPreferences.setString(_alarmKey, alarm?.toString() ?? _noAlarm);
    state = alarm;
  }

  Future<void> _initPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }
}
