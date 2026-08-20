import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_pomodoro_time_management_system/services/diagnostics_service.dart';

void main() {
  test('diagnostics payload contains aggregate health counters only', () async {
    late Map<String, dynamic> payload;
    final client = MockClient((request) async {
      payload = jsonDecode(request.body) as Map<String, dynamic>;
      return http.Response('', 204);
    });
    final service = DiagnosticsService(
      client: client,
      endpoint: Uri.https('diagnostics.example', '/v1/health'),
    );

    await service.sendDailyHealth(
      enabled: true,
      platform: 'test',
      appVersion: '2.0.0',
      capturesSucceeded: 4,
      capturesSkipped: 2,
      inferenceFailures: 1,
    );

    expect(payload.keys, {
      'schema',
      'platform',
      'appVersion',
      'capturesSucceeded',
      'capturesSkipped',
      'inferenceFailures',
    });
    expect(jsonEncode(payload), isNot(contains('user')));
    expect(jsonEncode(payload), isNot(contains('window')));
    expect(jsonEncode(payload), isNot(contains('activity')));
  });

  test('disabled diagnostics performs no network request', () async {
    var requests = 0;
    final service = DiagnosticsService(
      client: MockClient((_) async {
        requests++;
        return http.Response('', 204);
      }),
      endpoint: Uri.https('diagnostics.example', '/v1/health'),
    );

    await service.sendDailyHealth(
      enabled: false,
      platform: 'test',
      appVersion: '2.0.0',
      capturesSucceeded: 4,
      capturesSkipped: 2,
      inferenceFailures: 1,
    );

    expect(requests, 0);
  });

  test('non-HTTPS diagnostics endpoints are rejected', () async {
    var requests = 0;
    final service = DiagnosticsService(
      client: MockClient((_) async {
        requests++;
        return http.Response('', 204);
      }),
      endpoint: Uri.parse('http://diagnostics.example/v1/health'),
    );

    expect(service.isConfigured, isFalse);
    expect(
      await service.sendDailyHealth(
        enabled: true,
        platform: 'test',
        appVersion: '2.0.0',
        capturesSucceeded: 1,
        capturesSkipped: 0,
        inferenceFailures: 0,
      ),
      isFalse,
    );
    expect(requests, 0);
  });
}
