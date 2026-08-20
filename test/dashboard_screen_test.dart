import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/data/session_repository.dart';
import 'package:my_pomodoro_time_management_system/domain/models.dart';
import 'package:my_pomodoro_time_management_system/features/dashboard/dashboard_screen.dart';

void main() {
  testWidgets('dashboard edits and deletes a session from its menu', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(1200, 800);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final repository = SessionRepository(database);
    final now = DateTime.now().toUtc();
    await repository.save(
      WorkSession(
        id: 'dashboard-session',
        userId: 'dashboard-user',
        cycleId: 'cycle',
        phase: TimerPhase.focus,
        activity: 'Original label',
        plannedSeconds: 1500,
        actualSeconds: 600,
        startedAt: now.subtract(const Duration(minutes: 10)),
        endedAt: now,
        outcome: SessionOutcome.stopped,
        updatedAt: now,
      ),
    );

    await tester.pumpWidget(
      MaterialApp(
        home: DashboardScreen(userId: 'dashboard-user', sessions: repository),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Original label'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Edit label'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextFormField), 'Edited label');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();
    expect(find.text('Edited label'), findsOneWidget);

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Delete'));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(FilledButton, 'Delete'));
    await tester.pumpAndSettle();
    expect(find.text('Edited label'), findsNothing);

    final deleted = await database.sessionById('dashboard-session');
    expect(deleted, isNull);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(milliseconds: 1));
  });
}
