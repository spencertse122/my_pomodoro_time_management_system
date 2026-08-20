import 'dart:convert';

import 'package:http/http.dart' as http;

/// Sends coarse health counters only. Activity labels, app/window metadata,
/// timestamps, model output, user IDs, and stable device IDs are never accepted.
class DiagnosticsService {
  DiagnosticsService({http.Client? client, Uri? endpoint})
    : _client = client ?? http.Client(),
      _endpoint = endpoint == null ? _configuredEndpoint : _httpsUri(endpoint);

  static final Uri? _configuredEndpoint = _readEndpoint(
    const String.fromEnvironment('FOCUS_FLOW_DIAGNOSTICS_URL'),
  );

  final http.Client _client;
  final Uri? _endpoint;

  bool get isConfigured => _endpoint != null;

  Future<bool> sendDailyHealth({
    required bool enabled,
    required String platform,
    required String appVersion,
    required int capturesSucceeded,
    required int capturesSkipped,
    required int inferenceFailures,
  }) async {
    final endpoint = _endpoint;
    if (!enabled || endpoint == null) return false;
    final payload = <String, Object>{
      'schema': 1,
      'platform': platform,
      'appVersion': appVersion,
      'capturesSucceeded': capturesSucceeded.clamp(0, 100000),
      'capturesSkipped': capturesSkipped.clamp(0, 100000),
      'inferenceFailures': inferenceFailures.clamp(0, 100000),
    };
    try {
      final response = await _client
          .post(
            endpoint,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(payload),
          )
          .timeout(const Duration(seconds: 10));
      return response.statusCode >= 200 && response.statusCode < 300;
    } on Object {
      // Diagnostics are best-effort and must never affect local tracking.
      return false;
    }
  }

  void dispose() => _client.close();

  static Uri? _readEndpoint(String value) {
    final parsed = Uri.tryParse(value);
    return parsed == null ? null : _httpsUri(parsed);
  }

  static Uri? _httpsUri(Uri value) =>
      value.scheme == 'https' && value.host.isNotEmpty ? value : null;
}
