import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_clock/clock_screen.dart';
import 'package:flutter_clock/main.dart';

void main() {
  testWidgets('Smoke Test - App Starts', (WidgetTester tester) async {
    await tester.pumpWidget(ProviderScope(child: MyApp()));

    expect(find.byType(ClockScreen), findsOneWidget);
  });
}
