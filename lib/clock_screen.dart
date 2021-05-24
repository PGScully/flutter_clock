import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_clock/alarm_preference.dart';
import 'package:flutter_clock/clock_face_preference.dart';
import 'package:flutter_clock/clock_face.dart';

/// Display the clock, and handle switching between analog and digital clocks
class ClockScreen extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final alarmPreference = watch(alarmProvider);
    final analogFacePreference = watch(clockFaceProvider);
    return Scaffold(
      appBar: AppBar(
        title: analogFacePreference ? const Text('Analog Clock') : const Text('Digital Clock'),
        actions: [
          ActionChip(
            label: alarmPreference == null
                ? const Text('No Alarm')
                : Text(DateFormat.Hms().format(alarmPreference)),
            onPressed: () => _setAlarm(context: context, currentAlarm: alarmPreference),
          ),
          ActionChip(
            label: analogFacePreference ? const Text('To Digital') : const Text('To Analog'),
            onPressed: () => _toggleAnalog(context: context, currentState: analogFacePreference),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: ClockFace(),
        ),
      ),
    );
  }

  Future<void> _setAlarm({
    required BuildContext context,
    required DateTime? currentAlarm,
  }) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(currentAlarm ?? DateTime.now()),
    );
    final result = time == null ? null : DateTime(1, 1, 1, time.hour, time.minute);
    context.read(alarmProvider.notifier).setAlarm(alarm: result);
  }

  void _toggleAnalog({required BuildContext context, required bool currentState}) {
    context.read(clockFaceProvider.notifier).analog = !currentState;
  }
}
