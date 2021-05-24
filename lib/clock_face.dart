import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:flutter_clock/alarm_preference.dart';
import 'package:flutter_clock/clock_face_preference.dart';

class ClockFace extends StatefulWidget {
  @override
  _ClockFaceState createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace> {
  late Timer _timer;

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => context.read(timeProvider).state =
          context.read(timeProvider).state.add(const Duration(seconds: 1)),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Consumer(
        builder: (context, watch, _) {
          final time = watch(timeProvider).state;
          final analogPreference = watch(clockFaceProvider);
          final alarmPreference = watch(alarmProvider);
          _testAlarm(alarmTime: alarmPreference, currentTime: time);

          return analogPreference
              ? AnalogClockFace(timestamp: time)
              : DigitalClockFace(timestamp: time);
        },
      );

  Future<void> _testAlarm({
    required DateTime? alarmTime,
    required DateTime currentTime,
  }) async {
    if (alarmTime != null &&
        currentTime.hour == alarmTime.hour &&
        currentTime.minute == alarmTime.minute &&
        currentTime.second == 0) {
      Future<void>.delayed(Duration.zero).then((_) => _displayAlarm(alarmTime: alarmTime));
    }
  }

  void _displayAlarm({
    required DateTime alarmTime,
  }) {
    debugPrint('Alarm!');
    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Alarm!'),
        content: Text('This is your ${DateFormat.Hm().format(alarmTime)} alarm.'),
        actions: [
          MaterialButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }
}

// Only load these once
late final hourHand = Image.asset(
  'assets/images/hour.png',
  fit: BoxFit.contain,
  color: Colors.blue,
  colorBlendMode: BlendMode.srcIn,
  semanticLabel: 'Hour Hand',
);
late final minuteHand = Image.asset(
  'assets/images/minute.png',
  fit: BoxFit.contain,
  color: Colors.green,
  colorBlendMode: BlendMode.srcIn,
  semanticLabel: 'Minute Hand',
);
late final secondHand = Image.asset(
  'assets/images/second.png',
  fit: BoxFit.contain,
  color: Colors.red,
  colorBlendMode: BlendMode.srcIn,
  semanticLabel: 'Second Hand',
);

class AnalogClockFace extends StatelessWidget {
  final DateTime timestamp;

  const AnalogClockFace({
    Key? key,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final hours = timestamp.hour;
    final minutes = timestamp.minute;
    final seconds = timestamp.second;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.0,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Hour Hand
            Transform.rotate(
              angle: hoursToRadians(hours),
              child: hourHand,
            ),
            // Minute Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(minutes),
              child: minuteHand,
            ),
            // Second Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(seconds),
              child: secondHand,
            ),
          ],
        ),
      ),
    );
  }

  double hoursToRadians(int n) => n * pi / 6.0;

  double minutesSecondsToRadians(int n) => n * pi / 30.0;
}

class DigitalClockFace extends StatelessWidget {
  static const maxFontSize = 288.0;

  final DateTime timestamp;

  const DigitalClockFace({
    Key? key,
    required this.timestamp,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AutoSizeText(
        DateFormat.Hms().format(timestamp),
        maxFontSize: maxFontSize,
        maxLines: 1,
        style: const TextStyle(
          fontSize: maxFontSize,
          fontFeatures: [
            FontFeature.tabularFigures(),
          ],
        ),
      );
}

final timeProvider = StateProvider<DateTime>((ref) => DateTime.now());
