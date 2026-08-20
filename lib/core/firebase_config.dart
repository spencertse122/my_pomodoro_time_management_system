import 'package:flutter/foundation.dart';

class FirebaseConfig {
  const FirebaseConfig({required this.apiKey, required this.projectId});

  final String apiKey;
  final String projectId;

  static FirebaseConfig get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      default:
        throw UnsupportedError(
          'Focus Flow is configured for macOS and Windows.',
        );
    }
  }

  static const macos = FirebaseConfig(
    apiKey: 'AIzaSyCULUImEDHZUxe5xgUMqFnCidhCyUJ4J88',
    projectId: 'focus-flow-spencertse',
  );

  static const windows = FirebaseConfig(
    apiKey: 'AIzaSyC7HMXblfAXgd6xJkBVb3_-L93Yd_82NL0',
    projectId: 'focus-flow-spencertse',
  );
}
