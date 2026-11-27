import 'dart:async';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class AuthException implements Exception {
  const AuthException(this.message);
  final String message;

  @override
  String toString() => message;
}

class AuthService {
  const AuthService();
  static const _storage = FlutterSecureStorage();

  Uri _endpoint(String path) {
    const configured = String.fromEnvironment('API_BASE_URL');
    final android = !kIsWeb && defaultTargetPlatform == TargetPlatform.android;
    final base = configured.isNotEmpty
        ? configured
        : 'http://${android ? '10.0.2.2' : '127.0.0.1'}:8000/api';
    final uri = Uri.parse('${base.replaceFirst(RegExp(r'/$'), '')}/$path');
    if (!kDebugMode && uri.scheme != 'https') {
      throw const AuthException('Atur API_BASE_URL ke server HTTPS.');
    }
    return uri;
  }

  String get _key => 'mobile.session.${_endpoint('me').origin}';

  Future<http.Response> _send(
    String path, {
    String? token,
    Map<String, String>? data,
  }) async {
    final uri = _endpoint(path);
    final headers = {
      'Accept': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    };
    try {
      final request = path == 'me'
          ? http.get(uri, headers: headers)
          : http.post(uri, headers: headers, body: data);
      return await request.timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw const AuthException('Server belum merespons. Coba kembali.');
    } on http.ClientException {
      throw const AuthException(
        'Server tidak dapat dijangkau. Periksa koneksi.',
      );
    }
  }

  Future<void> login({
    required String identifier,
    required String password,
  }) async {
    final response = await _send(
      'login',
      data: {'identifier': identifier, 'password': password},
    );
    if (response.statusCode == 401) {
      throw const AuthException(
        'Identitas atau kata sandi salah, atau akun tidak aktif.',
      );
    }
    if (response.statusCode == 429) {
      throw const AuthException(
        'Terlalu banyak percobaan. Coba lagi dalam satu menit.',
      );
    }
    if (response.statusCode != 200) {
      throw const AuthException('Gagal masuk. Periksa data dan alamat server.');
    }
    final body = jsonDecode(response.body);
    final token = body is Map ? body['token'] : null;
    if (token is! String || token.isEmpty) {
      throw const AuthException('Respons login dari server tidak valid.');
    }
    await _storage.write(key: _key, value: token);
  }

  Future<bool> restore() async {
    final token = await _storage.read(key: _key);
    if (token == null) return false;
    final response = await _send('me', token: token);
    if (response.statusCode == 401) {
      await _storage.delete(key: _key);
      return false;
    }
    if (response.statusCode != 200) {
      throw const AuthException('Server gagal memeriksa sesi.');
    }
    return true;
  }

  Future<void> logout() async {
    final token = await _storage.read(key: _key);
    if (token != null) {
      final response = await _send('logout', token: token);
      if (response.statusCode != 204 && response.statusCode != 401) {
        throw const AuthException('Gagal mengakhiri sesi. Coba kembali.');
      }
    }
    await _storage.delete(key: _key);
  }
}
