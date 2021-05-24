import 'package:flutter/material.dart';
import 'package:flutter_clock/clock_face_preference.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clock/clock_face.dart';

void main() {
  group('Clock Face', () {
    testWidgets('Analog face is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          clockFaceProvider.overrideWithValue(ClockFacePreference()..analog = true),
        ],
        child: boilerplate(child: ClockFace()),
      ));

      expect(find.byType(AnalogClockFace), findsOneWidget);

      expect(find.byType(DigitalClockFace), findsNothing);
    });

    testWidgets('Digital face is displayed', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          clockFaceProvider.overrideWithValue(ClockFacePreference()..analog = false),
        ],
        child: boilerplate(child: ClockFace()),
      ));

      expect(find.byType(DigitalClockFace), findsOneWidget);

      expect(find.byType(AnalogClockFace), findsNothing);
    });
  });

  group('Analog Clock Face', () {
    testWidgets('Clock hands are displayed', (WidgetTester tester) async {
      final midnight = DateTime(1);
      await tester.pumpWidget(boilerplate(child: AnalogClockFace(timestamp: midnight)));

      expect(find.bySemanticsLabel('Hour Hand', skipOffstage: false), findsOneWidget);
      expect(find.bySemanticsLabel('Minute Hand', skipOffstage: false), findsOneWidget);
      expect(find.bySemanticsLabel('Second Hand', skipOffstage: false), findsOneWidget);
    });

    testWidgets(
      'Midnight is displayed correctly',
      (WidgetTester tester) async {
        final midnight = DateTime(1);
        await tester.pumpWidget(boilerplate(child: AnalogClockFace(timestamp: midnight)));

        // TODO: find the clock hands, determine their rotation, and compare with expected values
        expect(find.bySemanticsLabel('Hour Hand'), findsOneWidget);
        expect(find.bySemanticsLabel('Minute Hand'), findsOneWidget);
        expect(find.bySemanticsLabel('Second Hand'), findsOneWidget);
      },
      skip: true,
    );
  });

  group('Digital Clock Face', () {
    testWidgets('08:09:10 is correctly displayed', (WidgetTester tester) async {
      final time1 = DateTime(1, 1, 1, 8, 9, 10);
      await tester.pumpWidget(boilerplate(child: DigitalClockFace(timestamp: time1)));

      expect(find.text('08:09:10'), findsOneWidget);

      expect(find.text('8:09:10'), findsNothing);
      expect(find.text('8:9:10'), findsNothing);
    });

    testWidgets('10:15:20 is correctly displayed', (WidgetTester tester) async {
      final time2 = DateTime(1, 1, 1, 10, 15, 20);
      await tester.pumpWidget(
        boilerplate(
          child: DigitalClockFace(timestamp: time2),
        ),
      );

      expect(find.text('10:15:20'), findsOneWidget);
    });

    testWidgets('21:45:55 is correctly displayed', (WidgetTester tester) async {
      final time3 = DateTime(1, 1, 1, 21, 45, 55);
      await tester.pumpWidget(
        boilerplate(
          child: DigitalClockFace(timestamp: time3),
        ),
      );

      expect(find.text('21:45:55'), findsOneWidget);

      expect(find.text('09:45:55'), findsNothing);
      expect(find.text('9:45:55'), findsNothing);
    });
  });
}

Widget boilerplate({required Widget child}) => MaterialApp(home: Scaffold(body: child));
