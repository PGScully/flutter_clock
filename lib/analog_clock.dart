import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

class AnalogClock extends StatefulWidget {
  @override
  _AnalogClockState createState() => _AnalogClockState();
}

class _AnalogClockState extends State<AnalogClock> {
  late Timer _timer;
  late DateTime time;

  @override
  void initState() {
    super.initState();
    time = DateTime.now();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) => setState(() => time = DateTime.now()),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => AnalogClockFace(timestamp: time);
}

class AnalogClockFace extends StatelessWidget {
  final DateTime timestamp;

  const AnalogClockFace({Key? key, required this.timestamp}) : super(key: key);

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
          children: [
            // Hour Hand
            Transform.rotate(
              angle: hoursToRadians(hours),
              child: Container(
                color: Colors.red,
              ),
            ),
            // Minute Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(minutes),
              child: Container(
                color: Colors.blue,
              ),
            ),
            // Second Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(seconds),
              child: Container(
                color: Colors.green,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double hoursToRadians(int n) => n * pi / 6.0;

  double minutesSecondsToRadians(int n) => n * pi / 30.0;
}
