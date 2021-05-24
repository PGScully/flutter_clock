import 'package:flutter/material.dart';

import 'package:flutter_clock/clock_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
        title: 'Flutter Clock',
        theme: ThemeData.light(),
        darkTheme: ThemeData.dark(),
        home: ClockScreen(),
      );
}
