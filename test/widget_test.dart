// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility that Flutter provides. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_clock/analog_clock.dart';
import 'package:flutter_clock/digital_clock.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clock/main.dart';

void main() {
  testWidgets('Clock screen smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that Digital Clock is shown.
    expect(find.text('Digital Clock'), findsOneWidget);
    expect(find.byType(DigitalClock), findsOneWidget);
    expect(find.text('Analog Clock'), findsNothing);
    expect(find.byType(AnalogClock), findsNothing);

    // Tap the To Analog action and trigger a frame.
    await tester.tap(find.byType(ActionChip));
    await tester.pump();

    // Verify that Analog Clock is shown.
    expect(find.text('Digital Clock'), findsNothing);
    expect(find.byType(DigitalClock), findsNothing);
    expect(find.text('Analog Clock'), findsOneWidget);
    expect(find.byType(AnalogClock), findsOneWidget);
  });
}
