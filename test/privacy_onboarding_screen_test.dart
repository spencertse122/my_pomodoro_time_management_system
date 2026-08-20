import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/features/onboarding/privacy_onboarding_screen.dart';

void main() {
  testWidgets('permission is requested only after explicit enable action', (
    tester,
  ) async {
    var requests = 0;
    var skipped = 0;
    await tester.pumpWidget(
      MaterialApp(
        home: PrivacyOnboardingScreen(
          onEnableTracking: () async {
            requests++;
            return true;
          },
          onContinueWithoutTracking: () async => skipped++,
        ),
      ),
    );

    expect(requests, 0);
    expect(find.text('Local AI only'), findsOneWidget);
    expect(find.text('No cloud activity data'), findsOneWidget);

    await tester.ensureVisible(find.text('Enable local activity tracking'));
    await tester.tap(find.text('Enable local activity tracking'));
    await tester.pump();
    expect(requests, 1);
    expect(skipped, 0);
  });
}
