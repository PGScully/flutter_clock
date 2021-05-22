import 'dart:async';
import 'dart:ui';
import 'package:intl/intl.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

class DigitalClock extends StatefulWidget {
  @override
  _DigitalClockState createState() => _DigitalClockState();
}

class _DigitalClockState extends State<DigitalClock> {
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
  Widget build(BuildContext context) => DigitalClockFace(timestamp: time);
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
