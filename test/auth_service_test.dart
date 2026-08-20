import 'dart:convert';

import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_pomodoro_time_management_system/data/local/app_database.dart';
import 'package:my_pomodoro_time_management_system/services/auth_service.dart';

void main() {
  test(
    'sign-in persists the user and a restored session refreshes its token',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final client = MockClient((request) async {
        if (request.url.host == 'identitytoolkit.googleapis.com') {
          return http.Response(
            jsonEncode({
              'localId': 'user-1',
              'email': 'person@example.com',
              'idToken': 'initial-token',
              'refreshToken': 'initial-refresh',
              'expiresIn': '3600',
            }),
            200,
          );
        }
        if (request.url.host == 'securetoken.googleapis.com') {
          return http.Response(
            jsonEncode({
              'user_id': 'user-1',
              'access_token': 'refreshed-token',
              'refresh_token': 'replacement-refresh',
              'expires_in': '3600',
            }),
            200,
          );
        }
        return http.Response('{}', 404);
      });

      final auth = await AuthService.create(
        database: database,
        apiKey: 'test-key',
        client: client,
      );
      await auth.signIn(' person@example.com ', 'password');
      expect(auth.currentUser?.uid, 'user-1');
      expect(await auth.idToken(), 'initial-token');

      final restored = await AuthService.create(
        database: database,
        apiKey: 'test-key',
        client: client,
      );
      expect(restored.currentUser?.email, 'person@example.com');
      expect(await restored.idToken(), 'refreshed-token');

      await restored.signOut();
      expect(restored.currentUser, isNull);
      expect(await database.storedAuth(), isNull);
    },
  );

  test(
    'Firebase authentication errors are presented in plain language',
    () async {
      final database = AppDatabase(NativeDatabase.memory());
      addTearDown(database.close);
      final client = MockClient(
        (_) async => http.Response(
          jsonEncode({
            'error': {'message': 'INVALID_LOGIN_CREDENTIALS'},
          }),
          400,
        ),
      );
      final auth = await AuthService.create(
        database: database,
        apiKey: 'test-key',
        client: client,
      );

      await expectLater(
        auth.signIn('person@example.com', 'wrong-password'),
        throwsA(
          isA<AuthException>().having(
            (error) => error.message,
            'message',
            'The email or password is incorrect.',
          ),
        ),
      );
    },
  );
}
