import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/app.dart';

void main() {
  testWidgets('missing Firebase configuration has an actionable screen', (
    tester,
  ) async {
    await tester.pumpWidget(const MaterialApp(home: ConfigurationScreen()));

    expect(find.text('Firebase configuration is unavailable'), findsOneWidget);
    expect(
      find.textContaining('lib/core/firebase_config.dart'),
      findsOneWidget,
    );
  });
}
