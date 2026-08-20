import 'dart:convert';
import 'dart:math';

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStore {
  SecureStore({FlutterSecureStorage? storage})
    : _storage = storage ?? const FlutterSecureStorage();

  static const _databaseKeyName = 'focus_flow_database_key_v2';
  static const _refreshTokenPrefix = 'firebase_refresh_token_';

  final FlutterSecureStorage _storage;

  Future<String> databaseKey() async {
    final existing = await _storage.read(key: _databaseKeyName);
    if (existing != null && existing.length >= 32) return existing;

    final random = Random.secure();
    final bytes = List<int>.generate(32, (_) => random.nextInt(256));
    final value = base64UrlEncode(bytes);
    await _storage.write(key: _databaseKeyName, value: value);
    return value;
  }

  Future<String?> refreshToken(String userId) =>
      _storage.read(key: '$_refreshTokenPrefix$userId');

  Future<void> saveRefreshToken(String userId, String token) =>
      _storage.write(key: '$_refreshTokenPrefix$userId', value: token);

  Future<void> deleteRefreshToken(String userId) =>
      _storage.delete(key: '$_refreshTokenPrefix$userId');

  Future<void> deleteDatabaseKey() => _storage.delete(key: _databaseKeyName);
}
