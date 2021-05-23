import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clock/clock_face.dart';
import 'package:flutter_clock/main.dart';

void main() {
  testWidgets('Clock screen', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(MyApp());

    // Verify that Digital Clock is shown.
    expect(find.byType(DigitalClockFace), findsOneWidget);
    expect(find.text('Digital Clock'), findsOneWidget);
    expect(find.text('To Analog'), findsOneWidget);

    expect(find.byType(AnalogClockFace), findsNothing);
    expect(find.text('Analog Clock'), findsNothing);
    expect(find.text('To Digital'), findsNothing);

    // Tap the To Analog action and trigger a frame.
    await tester.tap(find.widgetWithText(ActionChip, 'To Analog'));
    await tester.pump();

    // Verify that Analog Clock is shown.
    expect(find.byType(AnalogClockFace), findsOneWidget);
    expect(find.text('Analog Clock'), findsOneWidget);
    expect(find.text('To Digital'), findsOneWidget);

    expect(find.byType(DigitalClockFace), findsNothing);
    expect(find.text('Digital Clock'), findsNothing);
    expect(find.text('To Analog'), findsNothing);

    // Tap the To Analog action and trigger a frame.
    await tester.tap(find.widgetWithText(ActionChip, 'To Digital'));
    await tester.pump();

    // Verify that Digital Clock is shown.
    expect(find.byType(DigitalClockFace), findsOneWidget);
    expect(find.text('Digital Clock'), findsOneWidget);
    expect(find.text('To Analog'), findsOneWidget);

    expect(find.byType(AnalogClockFace), findsNothing);
    expect(find.text('Analog Clock'), findsNothing);
    expect(find.text('To Digital'), findsNothing);
  });
}
