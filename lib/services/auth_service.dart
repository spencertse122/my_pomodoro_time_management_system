import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../data/local/app_database.dart';
import 'secure_store.dart';

class AppUser {
  const AppUser({required this.uid, required this.email});

  final String uid;
  final String email;
}

class AuthException implements Exception {
  const AuthException(this.message);

  final String message;

  @override
  String toString() => message;
}

class AuthService {
  AuthService._({
    required AppDatabase database,
    required String apiKey,
    required http.Client client,
    SecureStore? secureStore,
  }) : _database = database,
       _apiKey = apiKey,
       _client = client,
       _secureStore = secureStore;

  final AppDatabase _database;
  final String _apiKey;
  final http.Client _client;
  final SecureStore? _secureStore;
  final StreamController<AppUser?> _changes = StreamController.broadcast();

  AppUser? _currentUser;
  String? _refreshToken;
  String? _idToken;
  DateTime? _tokenExpiresAt;
  Future<String>? _activeRefresh;

  static Future<AuthService> create({
    required AppDatabase database,
    required String apiKey,
    http.Client? client,
    SecureStore? secureStore,
  }) async {
    final service = AuthService._(
      database: database,
      apiKey: apiKey,
      client: client ?? http.Client(),
      secureStore: secureStore,
    );
    final stored = await database.storedAuth();
    if (stored != null) {
      final secureToken = await secureStore?.refreshToken(stored.userId);
      final token = secureToken ?? stored.refreshToken;
      if (token.isNotEmpty) {
        service._currentUser = AppUser(uid: stored.userId, email: stored.email);
        service._refreshToken = token;
        if (secureStore != null && secureToken == null) {
          await secureStore.saveRefreshToken(stored.userId, token);
          await database.saveAuth(
            StoredAuth(userId: stored.userId, email: stored.email),
          );
        }
      }
    }
    return service;
  }

  Stream<AppUser?> get userChanges async* {
    yield _currentUser;
    yield* _changes.stream;
  }

  AppUser? get currentUser => _currentUser;

  Future<void> signIn(String email, String password) async {
    final data = await _identityRequest('accounts:signInWithPassword', {
      'email': email.trim(),
      'password': password,
      'returnSecureToken': true,
    });
    await _acceptAuthentication(data, fallbackEmail: email.trim());
  }

  Future<void> createAccount(String email, String password) async {
    final data = await _identityRequest('accounts:signUp', {
      'email': email.trim(),
      'password': password,
      'returnSecureToken': true,
    });
    await _acceptAuthentication(data, fallbackEmail: email.trim());
  }

  Future<void> sendPasswordReset(String email) async {
    await _identityRequest('accounts:sendOobCode', {
      'requestType': 'PASSWORD_RESET',
      'email': email.trim(),
    });
  }

  Future<void> signOut() async {
    final userId = _currentUser?.uid;
    _currentUser = null;
    _refreshToken = null;
    _idToken = null;
    _tokenExpiresAt = null;
    await _database.clearAuth();
    if (userId != null) await _secureStore?.deleteRefreshToken(userId);
    _changes.add(null);
  }

  Future<void> deleteAccount() async {
    final token = await idToken();
    await _identityRequest('accounts:delete', {'idToken': token});
    await signOut();
  }

  Future<String> idToken({bool forceRefresh = false}) async {
    if (_currentUser == null || _refreshToken == null) {
      throw const AuthException('Please sign in again.');
    }
    final expiresAt = _tokenExpiresAt;
    if (!forceRefresh &&
        _idToken != null &&
        expiresAt != null &&
        DateTime.now().isBefore(expiresAt)) {
      return _idToken!;
    }
    final active = _activeRefresh;
    if (active != null) return active;
    final operation = _refreshIdToken();
    _activeRefresh = operation;
    try {
      return await operation;
    } finally {
      _activeRefresh = null;
    }
  }

  Future<Map<String, dynamic>> _identityRequest(
    String method,
    Map<String, Object?> body,
  ) async {
    final uri = Uri.https('identitytoolkit.googleapis.com', '/v1/$method', {
      'key': _apiKey,
    });
    try {
      final response = await _client
          .post(
            uri,
            headers: const {'Content-Type': 'application/json'},
            body: jsonEncode(body),
          )
          .timeout(const Duration(seconds: 20));
      return _decodeResponse(response);
    } on TimeoutException {
      throw const AuthException(
        'Firebase did not respond. Check your connection.',
      );
    } on http.ClientException {
      throw const AuthException(
        'Could not reach Firebase. Check your connection.',
      );
    }
  }

  Future<void> _acceptAuthentication(
    Map<String, dynamic> data, {
    required String fallbackEmail,
  }) async {
    final userId = data['localId'] as String?;
    final refreshToken = data['refreshToken'] as String?;
    final idToken = data['idToken'] as String?;
    if (userId == null || refreshToken == null || idToken == null) {
      throw const AuthException(
        'Firebase returned an incomplete sign-in response.',
      );
    }
    final email = data['email'] as String? ?? fallbackEmail;
    _currentUser = AppUser(uid: userId, email: email);
    _refreshToken = refreshToken;
    _idToken = idToken;
    _setExpiration(data['expiresIn']);
    await _secureStore?.saveRefreshToken(userId, refreshToken);
    await _database.saveAuth(
      StoredAuth(
        userId: userId,
        email: email,
        refreshToken: _secureStore == null ? refreshToken : '',
      ),
    );
    _changes.add(_currentUser);
  }

  Future<String> _refreshIdToken() async {
    final refreshToken = _refreshToken!;
    final uri = Uri.https('securetoken.googleapis.com', '/v1/token', {
      'key': _apiKey,
    });
    try {
      final response = await _client
          .post(
            uri,
            headers: const {
              'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: {
              'grant_type': 'refresh_token',
              'refresh_token': refreshToken,
            },
          )
          .timeout(const Duration(seconds: 20));
      final data = _decodeResponse(response);
      final token = data['access_token'] as String?;
      final replacementRefreshToken = data['refresh_token'] as String?;
      if (token == null || replacementRefreshToken == null) {
        throw const AuthException('Firebase could not refresh your session.');
      }
      _idToken = token;
      _refreshToken = replacementRefreshToken;
      _setExpiration(data['expires_in']);
      final user = _currentUser!;
      await _secureStore?.saveRefreshToken(user.uid, replacementRefreshToken);
      await _database.saveAuth(
        StoredAuth(
          userId: user.uid,
          email: user.email,
          refreshToken: _secureStore == null ? replacementRefreshToken : '',
        ),
      );
      return token;
    } on TimeoutException {
      throw const AuthException(
        'Firebase did not respond. Check your connection.',
      );
    } on http.ClientException {
      throw const AuthException(
        'Could not reach Firebase. Check your connection.',
      );
    }
  }

  Map<String, dynamic> _decodeResponse(http.Response response) {
    final decoded = jsonDecode(response.body) as Map<String, dynamic>;
    if (response.statusCode >= 200 && response.statusCode < 300) return decoded;
    final error = decoded['error'] as Map<String, dynamic>?;
    final code = error?['message'] as String? ?? 'AUTHENTICATION_FAILED';
    throw AuthException(_friendlyMessage(code));
  }

  void _setExpiration(Object? seconds) {
    final lifetime = int.tryParse(seconds?.toString() ?? '') ?? 3600;
    _tokenExpiresAt = DateTime.now().add(Duration(seconds: lifetime - 60));
  }

  String _friendlyMessage(String code) {
    final normalized = code.split(' : ').first;
    return switch (normalized) {
      'EMAIL_EXISTS' => 'An account already exists for this email.',
      'EMAIL_NOT_FOUND' ||
      'INVALID_PASSWORD' ||
      'INVALID_LOGIN_CREDENTIALS' => 'The email or password is incorrect.',
      'INVALID_EMAIL' => 'Enter a valid email address.',
      'MISSING_PASSWORD' ||
      'WEAK_PASSWORD' => 'Use a password with at least 6 characters.',
      'TOO_MANY_ATTEMPTS_TRY_LATER' =>
        'Too many attempts. Please wait a moment and try again.',
      'USER_DISABLED' => 'This account has been disabled.',
      'TOKEN_EXPIRED' ||
      'INVALID_REFRESH_TOKEN' ||
      'USER_NOT_FOUND' => 'Your session expired. Please sign in again.',
      _ => code.replaceAll('_', ' ').toLowerCase(),
    };
  }
}
