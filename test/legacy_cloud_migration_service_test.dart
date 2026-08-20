import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/services/auth_service.dart';
import 'package:my_pomodoro_time_management_system/services/firestore_rest_client.dart';
import 'package:my_pomodoro_time_management_system/services/legacy_cloud_migration_service.dart';

void main() {
  test('imports legacy records then uses only GET and DELETE to purge', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final auth = await AuthService.create(
      database: database,
      apiKey: 'test-key',
      client: MockClient(
        (_) async => http.Response(
          jsonEncode({
            'localId': 'user-1',
            'email': 'person@example.com',
            'idToken': 'id-token',
            'refreshToken': 'refresh-token',
            'expiresIn': '3600',
          }),
          200,
        ),
      ),
    );
    await auth.signIn('person@example.com', 'password');

    var hasSession = true;
    var hasSettings = true;
    final methods = <String>[];
    final firestore = FirestoreRestClient(
      projectId: 'test-project',
      auth: auth,
      client: MockClient((request) async {
        methods.add(request.method);
        final path = request.url.path;
        if (request.method == 'DELETE') {
          if (path.endsWith('/sessions/session-1')) hasSession = false;
          if (path.endsWith('/settings/pomodoro')) hasSettings = false;
          return http.Response('', 204);
        }
        if (path.endsWith('/users/user-1/sessions')) {
          return http.Response(
            jsonEncode({
              'documents': hasSession
                  ? [
                      {
                        'name':
                            'projects/test-project/databases/(default)/documents/users/user-1/sessions/session-1',
                        'fields': _encodedSession(),
                      },
                    ]
                  : <Object>[],
            }),
            200,
          );
        }
        if (path.endsWith('/users/user-1/settings/pomodoro')) {
          if (!hasSettings) return http.Response('{}', 404);
          return http.Response(
            jsonEncode({
              'name':
                  'projects/test-project/databases/(default)/documents/users/user-1/settings/pomodoro',
              'fields': {
                'focusMinutes': {'integerValue': '30'},
                'shortBreakMinutes': {'integerValue': '6'},
                'longBreakMinutes': {'integerValue': '18'},
                'longBreakInterval': {'integerValue': '3'},
                'soundEnabled': {'booleanValue': false},
              },
            }),
            200,
          );
        }
        return http.Response('{}', 404);
      }),
    );
    final service = LegacyCloudMigrationService(database, firestore);

    final preview = await service.preview('user-1');
    expect(preview.sessionCount, 1);
    expect(preview.hasPomodoroSettings, isTrue);
    final result = await service.importAndPurge(
      userId: 'user-1',
      confirmedPrimaryDevice: true,
      confirmedPermanentPurge: true,
    );

    expect(result.state, 'complete');
    expect(result.cloudVerifiedEmpty, isTrue);
    expect(result.importedSessionCount, 1);
    expect((await database.sessionById('session-1'))?.activity, 'Legacy work');
    expect((await database.settings('user-1')).focusMinutes, 30);
    expect(methods, isNot(contains('PATCH')));
    expect(methods, isNot(contains('POST')));
    expect(methods.where((method) => method == 'DELETE'), hasLength(2));
  });

  test('refuses migration without both destructive confirmations', () async {
    final database = AppDatabase(NativeDatabase.memory());
    addTearDown(database.close);
    final auth = await AuthService.create(
      database: database,
      apiKey: 'key',
      client: MockClient((_) async => http.Response('{}', 500)),
    );
    final service = LegacyCloudMigrationService(
      database,
      FirestoreRestClient(
        projectId: 'project',
        auth: auth,
        client: MockClient((_) async => http.Response('{}', 200)),
      ),
    );

    await expectLater(
      service.importAndPurge(
        userId: 'user',
        confirmedPrimaryDevice: true,
        confirmedPermanentPurge: false,
      ),
      throwsArgumentError,
    );
  });
}

Map<String, Object> _encodedSession() => {
  'cycleId': {'stringValue': 'legacy-cycle'},
  'phase': {'stringValue': 'focus'},
  'activity': {'stringValue': 'Legacy work'},
  'plannedSeconds': {'integerValue': '1500'},
  'actualSeconds': {'integerValue': '1200'},
  'startedAtMs': {'integerValue': '1760000000000'},
  'endedAtMs': {'integerValue': '1760001200000'},
  'outcome': {'stringValue': 'stopped'},
  'updatedAtMs': {'integerValue': '1760001200000'},
  'isDeleted': {'booleanValue': false},
};
