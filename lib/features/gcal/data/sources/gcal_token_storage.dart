import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists Google Calendar OAuth tokens separately from app auth tokens.
class GCalTokenStorage {
  GCalTokenStorage(this._storage);

  final FlutterSecureStorage _storage;

  static const _accessTokenKey = 'GCAL_ACCESS_TOKEN';
  static const _refreshTokenKey = 'GCAL_REFRESH_TOKEN';

  Future<void> saveTokens({
    required String accessToken,
    String? refreshToken,
  }) async {
    await _storage.write(key: _accessTokenKey, value: accessToken);
    if (refreshToken != null) {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    }
  }

  Future<String?> getAccessToken() => _storage.read(key: _accessTokenKey);

  Future<String?> getRefreshToken() => _storage.read(key: _refreshTokenKey);

  Future<void> clear() async {
    await _storage.delete(key: _accessTokenKey);
    await _storage.delete(key: _refreshTokenKey);
  }
}
