import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the auth token in platform secure storage (Keychain / Keystore /
/// equivalent). Reads are tolerant of platform exceptions so a missing token
/// never crashes start-up.
class SecureTokenStore {
  SecureTokenStore([FlutterSecureStorage? storage])
    : _storage = storage ?? const FlutterSecureStorage();

  static const _tokenKey = 'auth_token';

  final FlutterSecureStorage _storage;

  Future<String?> readToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (_) {
      return null;
    }
  }

  Future<void> writeToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (_) {
      // best-effort; secure storage may be unavailable on some desktop setups
    }
  }

  Future<void> clear() async {
    try {
      await _storage.delete(key: _tokenKey);
    } catch (_) {}
  }
}
