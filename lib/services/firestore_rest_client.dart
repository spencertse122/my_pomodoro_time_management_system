import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'auth_service.dart';

class FirestoreDocument {
  const FirestoreDocument({required this.id, required this.fields});

  final String id;
  final Map<String, dynamic> fields;
}

class FirestoreRestClient {
  FirestoreRestClient({
    required String projectId,
    required AuthService auth,
    http.Client? client,
  }) : _projectId = projectId,
       _auth = auth,
       _client = client ?? http.Client();

  final String _projectId;
  final AuthService _auth;
  final http.Client _client;

  Future<FirestoreDocument?> getDocument(String documentPath) async {
    final response = await _request(
      'GET',
      _documentUri(documentPath),
      allowNotFound: true,
    );
    if (response == null) return null;
    return _decodeDocument(response);
  }

  Future<void> deleteDocument(String documentPath) async {
    await _request('DELETE', _documentUri(documentPath), allowNotFound: true);
  }

  Future<List<FirestoreDocument>> listDocuments(String collectionPath) async {
    final documents = <FirestoreDocument>[];
    String? pageToken;
    do {
      final response = await _request(
        'GET',
        _documentUri(
          collectionPath,
          query: {'pageSize': '1000', 'pageToken': ?pageToken},
        ),
      );
      final rawDocuments = response?['documents'] as List<dynamic>? ?? const [];
      for (final raw in rawDocuments) {
        documents.add(_decodeDocument(raw as Map<String, dynamic>));
      }
      pageToken = response?['nextPageToken'] as String?;
    } while (pageToken != null && pageToken.isNotEmpty);
    return documents;
  }

  Uri _documentUri(String path, {Map<String, String>? query}) => Uri.https(
    'firestore.googleapis.com',
    '/v1/projects/$_projectId/databases/(default)/documents/$path',
    query,
  );

  Future<Map<String, dynamic>?> _request(
    String method,
    Uri uri, {
    bool allowNotFound = false,
    bool retryAuthentication = true,
  }) async {
    try {
      final token = await _auth.idToken(forceRefresh: !retryAuthentication);
      final headers = <String, String>{'Authorization': 'Bearer $token'};
      final response = await switch (method) {
        'GET' => _client.get(uri, headers: headers),
        'DELETE' => _client.delete(uri, headers: headers),
        _ => throw ArgumentError.value(method, 'method'),
      }.timeout(const Duration(seconds: 20));

      if (response.statusCode == 401 && retryAuthentication) {
        return await _request(
          method,
          uri,
          allowNotFound: allowNotFound,
          retryAuthentication: false,
        );
      }
      if (allowNotFound && response.statusCode == 404) return null;
      final decoded = response.body.isEmpty
          ? <String, dynamic>{}
          : jsonDecode(response.body) as Map<String, dynamic>;
      if (response.statusCode >= 200 && response.statusCode < 300) {
        return decoded;
      }
      final error = decoded['error'] as Map<String, dynamic>?;
      throw FirestoreException(
        error?['message'] as String? ??
            'Firestore request failed (${response.statusCode}).',
      );
    } on TimeoutException {
      throw const FirestoreException(
        'Firestore did not respond. The one-time migration was not completed.',
      );
    } on http.ClientException {
      throw const FirestoreException(
        'Could not reach Firestore. The one-time migration was not completed.',
      );
    }
  }

  FirestoreDocument _decodeDocument(Map<String, dynamic> document) {
    final name = document['name'] as String? ?? '';
    final rawFields = document['fields'] as Map<String, dynamic>? ?? const {};
    return FirestoreDocument(
      id: name.split('/').last,
      fields: _decodeFields(rawFields),
    );
  }

  Map<String, dynamic> _decodeFields(Map<String, dynamic> fields) => {
    for (final entry in fields.entries)
      entry.key: _decodeValue(entry.value as Map<String, dynamic>),
  };

  dynamic _decodeValue(Map<String, dynamic> value) {
    if (value.containsKey('nullValue')) return null;
    if (value.containsKey('booleanValue')) return value['booleanValue'] as bool;
    if (value.containsKey('integerValue')) {
      return int.parse(value['integerValue'].toString());
    }
    if (value.containsKey('doubleValue')) {
      return (value['doubleValue'] as num).toDouble();
    }
    if (value.containsKey('timestampValue')) {
      return DateTime.parse(value['timestampValue'] as String).toUtc();
    }
    if (value.containsKey('stringValue')) return value['stringValue'] as String;
    if (value.containsKey('arrayValue')) {
      final array = value['arrayValue'] as Map<String, dynamic>;
      final values = array['values'] as List<dynamic>? ?? const [];
      return values
          .map((item) => _decodeValue(item as Map<String, dynamic>))
          .toList();
    }
    if (value.containsKey('mapValue')) {
      final map = value['mapValue'] as Map<String, dynamic>;
      return _decodeFields(map['fields'] as Map<String, dynamic>? ?? const {});
    }
    return null;
  }
}

class FirestoreException implements Exception {
  const FirestoreException(this.message);

  final String message;

  @override
  String toString() => message;
}
