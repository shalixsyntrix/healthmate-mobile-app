import 'package:flutter_test/flutter_test.dart';

import 'package:healthmate/main.dart';

void main() {
  testWidgets('Dashboard screen loads test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const HealthMateApp());

    // Verify that the dashboard loads
    expect(find.text('HealthMate'), findsOneWidget);
    expect(find.text('Today\'s Health Summary'), findsOneWidget);
  });
}
