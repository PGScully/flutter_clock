import 'package:flutter/material.dart';
import 'package:flutter_clock/clock_face.dart';

/// Display the clock, and handle switching between analog and digital clocks
class ClockScreen extends StatefulWidget {
  const ClockScreen({Key? key}) : super(key: key);

  @override
  _ClockScreenState createState() => _ClockScreenState();
}

class _ClockScreenState extends State<ClockScreen> {
  bool _analog = false;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: _analog ? const Text('Analog Clock') : const Text('Digital Clock'),
          actions: [
            ActionChip(
              label: _analog ? const Text('To Digital') : const Text('To Analog'),
              onPressed: () {
                setState(() {
                  _analog = !_analog;
                });
              },
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
}
