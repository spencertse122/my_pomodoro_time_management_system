import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:package_info_plus/package_info_plus.dart';

class AvailableUpdate {
  const AvailableUpdate({
    required this.version,
    required this.downloadUrl,
    required this.releaseNotes,
  });

  final String version;
  final Uri downloadUrl;
  final String releaseNotes;
}

class UpdateService {
  UpdateService({http.Client? client, Uri? feed})
    : _client = client ?? http.Client(),
      _feed = feed == null ? _configuredFeed : _httpsUri(feed);

  static final Uri? _configuredFeed = _readUri(
    const String.fromEnvironment('FOCUS_FLOW_UPDATE_FEED_URL'),
  );

  final http.Client _client;
  final Uri? _feed;

  bool get isConfigured => _feed != null;

  Future<AvailableUpdate?> check() async {
    final feed = _feed;
    if (feed == null) return null;
    final response = await _client
        .get(feed)
        .timeout(const Duration(seconds: 15));
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw StateError('The update feed returned ${response.statusCode}.');
    }
    final json = jsonDecode(response.body) as Map<String, dynamic>;
    final platform = Platform.isMacOS ? 'macos-arm64' : 'windows-x64';
    final release = json[platform] as Map<String, dynamic>?;
    if (release == null) return null;
    final version = release['version'] as String?;
    final rawUrl = release['url'] as String?;
    final url = rawUrl == null ? null : Uri.tryParse(rawUrl);
    if (version == null ||
        !RegExp(r'^\d+\.\d+\.\d+$').hasMatch(version) ||
        url == null ||
        url.scheme != 'https' ||
        url.host.isEmpty) {
      throw const FormatException('The update feed is invalid.');
    }
    final current = (await PackageInfo.fromPlatform()).version;
    if (_compareVersions(version, current) <= 0) return null;
    return AvailableUpdate(
      version: version,
      downloadUrl: url,
      releaseNotes: _boundedNotes(release['notes']),
    );
  }

  void dispose() => _client.close();

  static int _compareVersions(String left, String right) {
    final a = left.split('.').map((value) => int.tryParse(value) ?? 0).toList();
    final b = right
        .split('.')
        .map((value) => int.tryParse(value) ?? 0)
        .toList();
    for (var index = 0; index < 3; index++) {
      final difference =
          (index < a.length ? a[index] : 0) - (index < b.length ? b[index] : 0);
      if (difference != 0) return difference;
    }
    return 0;
  }

  static Uri? _readUri(String value) {
    final uri = Uri.tryParse(value);
    return uri == null ? null : _httpsUri(uri);
  }

  static Uri? _httpsUri(Uri value) =>
      value.scheme == 'https' && value.host.isNotEmpty ? value : null;

  static String _boundedNotes(Object? value) {
    if (value is! String) return '';
    return value.length <= 4000 ? value : value.substring(0, 4000);
  }
}
