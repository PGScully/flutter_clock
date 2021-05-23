import 'dart:async';
import 'dart:math';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ClockFace extends StatefulWidget {
  final bool analog;

  const ClockFace({
    Key? key,
    required this.analog,
  }) : super(key: key);

  @override
  _ClockFaceState createState() => _ClockFaceState();
}

class _ClockFaceState extends State<ClockFace> {
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
  Widget build(BuildContext context) =>
      widget.analog ? AnalogClockFace(timestamp: time) : DigitalClockFace(timestamp: time);
}

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
              child: Image.asset(
                'assets/images/hour.png',
                fit: BoxFit.contain,
                color: Theme.of(context).colorScheme.onSurface,
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            // Minute Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(minutes),
              child: Image.asset(
                'assets/images/minute.png',
                fit: BoxFit.contain,
                color: Theme.of(context).colorScheme.onSurface.withBlue(128),
                colorBlendMode: BlendMode.srcIn,
              ),
            ),
            // Second Hand
            Transform.rotate(
              angle: minutesSecondsToRadians(seconds),
              child: Image.asset(
                'assets/images/second.png',
                fit: BoxFit.contain,
                color: Colors.red,
                colorBlendMode: BlendMode.srcIn,
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
