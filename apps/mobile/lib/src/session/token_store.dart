import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Par de tokens de la sesión del dispositivo.
class StoredTokens {
  const StoredTokens({required this.accessToken, required this.refreshToken});

  final String accessToken;
  final String refreshToken;
}

/// Dónde vive la sesión entre aperturas de la app.
abstract class TokenStore {
  Future<StoredTokens?> read();
  Future<void> write(StoredTokens tokens);
  Future<void> clear();
}

/// Llavero de iOS y almacenamiento cifrado de Android: los tokens nunca quedan en texto plano.
class SecureTokenStore implements TokenStore {
  SecureTokenStore([FlutterSecureStorage? storage]) : _storage = storage ?? const FlutterSecureStorage();

  final FlutterSecureStorage _storage;
  static const _access = 'fd_acceso';
  static const _refresh = 'fd_renovacion';

  @override
  Future<StoredTokens?> read() async {
    final access = await _storage.read(key: _access);
    final refresh = await _storage.read(key: _refresh);
    if (access == null || refresh == null) return null;
    return StoredTokens(accessToken: access, refreshToken: refresh);
  }

  @override
  Future<void> write(StoredTokens tokens) async {
    await _storage.write(key: _access, value: tokens.accessToken);
    await _storage.write(key: _refresh, value: tokens.refreshToken);
  }

  @override
  Future<void> clear() async {
    await _storage.delete(key: _access);
    await _storage.delete(key: _refresh);
  }
}

/// Para pruebas.
class MemoryTokenStore implements TokenStore {
  MemoryTokenStore([this.tokens]);

  StoredTokens? tokens;

  @override
  Future<StoredTokens?> read() async => tokens;

  @override
  Future<void> write(StoredTokens tokens) async => this.tokens = tokens;

  @override
  Future<void> clear() async => tokens = null;
}
