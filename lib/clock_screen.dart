import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'package:flutter_clock/clock_face.dart';
import 'package:flutter_clock/preferences.dart';

/// Display the clock, and handle switching between analog and digital clocks
class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  final _preferences = Preferences();

  bool _analog = false;
  DateTime? _alarm;

  @override
  void initState() {
    super.initState();
    _preferences.addListener(() => setState(() => _alarm = _preferences.alarm));
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: _analog ? const Text('Analog Clock') : const Text('Digital Clock'),
          actions: [
            ActionChip(
              label:
                  _alarm == null ? const Text('No Alarm') : Text(DateFormat.Hms().format(_alarm!)),
              onPressed: _setAlarm,
            ),
            ActionChip(
              label: _analog ? const Text('To Digital') : const Text('To Analog'),
              onPressed: _toggleAnalog,
            )
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: ClockFace(analog: _analog),
          ),
        ),
      );

  Future<void> _setAlarm() async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(_alarm ?? DateTime.now()),
    );
    if (time == null) {
      setState(() {
        _alarm = null;
      });
    } else {
      setState(() {
        _alarm = DateTime(1, 1, 1, time.hour, time.minute);
      });
    }
    _preferences.setAlarm(alarm: _alarm);
  }

  void _toggleAnalog() => setState(() => _analog = !_analog);
}
