import 'package:flutter/material.dart';

import 'package:flutter_clock/clock_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Clock',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: const ClockScreen(),
      );
}
