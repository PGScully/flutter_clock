import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clock/analog_clock.dart';
import 'package:flutter_clock/digital_clock.dart';
import 'package:flutter_clock/main.dart';

void main() {
  testWidgets('Clock screen ', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that Digital Clock is shown.
    expect(find.text('Digital Clock'), findsOneWidget);
    expect(find.byType(DigitalClock), findsOneWidget);
    expect(find.text('Analog Clock'), findsNothing);
    expect(find.byType(AnalogClock), findsNothing);
    expect(find.text('To Analog'), findsOneWidget);
    expect(find.text('To Digital'), findsNothing);

    // Tap the To Analog action and trigger a frame.
    await tester.tap(find.widgetWithText(ActionChip, 'To Analog'));
    await tester.pump();

    // Verify that Analog Clock is shown.
    expect(find.text('Digital Clock'), findsNothing);
    expect(find.byType(DigitalClock), findsNothing);
    expect(find.text('Analog Clock'), findsOneWidget);
    expect(find.byType(AnalogClock), findsOneWidget);
    expect(find.text('To Analog'), findsNothing);
    expect(find.text('To Digital'), findsOneWidget);

    // Tap the To Analog action and trigger a frame.
    await tester.tap(find.widgetWithText(ActionChip, 'To Digital'));
    await tester.pump();

    // Verify that Digital Clock is shown.
    expect(find.text('Digital Clock'), findsOneWidget);
    expect(find.byType(DigitalClock), findsOneWidget);
    expect(find.text('Analog Clock'), findsNothing);
    expect(find.byType(AnalogClock), findsNothing);
    expect(find.text('To Analog'), findsOneWidget);
    expect(find.text('To Digital'), findsNothing);
  });
}
