import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:my_pomodoro_time_management_system/services/update_service.dart';

void main() {
  test('non-HTTPS update feeds are rejected without a request', () async {
    var requests = 0;
    final service = UpdateService(
      client: MockClient((_) async {
        requests++;
        return http.Response('{}', 200);
      }),
      feed: Uri.parse('http://updates.example/feed.json'),
    );

    expect(service.isConfigured, isFalse);
    expect(await service.check(), isNull);
    expect(requests, 0);
  });

  test('a feed with no entry for this platform reports no update', () async {
    final service = UpdateService(
      client: MockClient(
        (_) async => http.Response('{"unsupported-platform": {}}', 200),
      ),
      feed: Uri.https('updates.example', '/feed.json'),
    );

    expect(await service.check(), isNull);
  });
}
