import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'token_store.dart';

/// Cliente HTTP que pone el token de acceso en cada petición y, ante un 401, renueva la
/// sesión una vez y repite la petición. Varias peticiones que fallan a la vez comparten
/// una sola renovación (la API rota el token en cada una).
class AuthHttpClient extends http.BaseClient {
  AuthHttpClient({required this.inner, required this.store, required this.apiUrl, this.onSessionLost});

  final http.Client inner;
  final TokenStore store;
  final String apiUrl;

  /// Se llama cuando la renovación falla: la sesión terminó (venció, se cerró o la robaron).
  final void Function()? onSessionLost;

  Future<StoredTokens?>? _renewing;

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) async {
    final body = request is http.Request ? request.bodyBytes : null;
    final tokens = await store.read();
    final first = await inner.send(_withToken(request, body, tokens?.accessToken));
    if (first.statusCode != 401 || tokens == null || body == null || _isAuthRoute(request.url)) return first;

    await first.stream.drain<void>();
    final renewed = await (_renewing ??= _renew(tokens).whenComplete(() => _renewing = null));
    if (renewed == null) {
      onSessionLost?.call();
      return inner.send(_withToken(request, body, null));
    }
    return inner.send(_withToken(request, body, renewed.accessToken));
  }

  bool _isAuthRoute(Uri url) => url.path.startsWith('/v1/auth/');

  http.BaseRequest _withToken(http.BaseRequest original, List<int>? body, String? token) {
    if (body == null) {
      // Peticiones de flujo (archivos): se envían una sola vez, sin repetir.
      if (token != null) original.headers['Authorization'] = 'Bearer $token';
      return original;
    }
    final copy = http.Request(original.method, original.url)
      ..headers.addAll(original.headers)
      ..followRedirects = original.followRedirects
      ..bodyBytes = body;
    copy.headers.remove('Authorization');
    if (token != null) copy.headers['Authorization'] = 'Bearer $token';
    return copy;
  }

  Future<StoredTokens?> _renew(StoredTokens current) async {
    try {
      final res = await inner.post(
        Uri.parse('$apiUrl/v1/auth/renovar'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': current.refreshToken}),
      );
      if (res.statusCode != 200) {
        // Otra petición pudo renovar ya con este mismo token: se usa lo que haya guardado.
        final latest = await store.read();
        if (latest != null && latest.refreshToken != current.refreshToken) return latest;
        await store.clear();
        return null;
      }
      final json = jsonDecode(res.body) as Map<String, dynamic>;
      final fresh = StoredTokens(
        accessToken: json['accessToken'] as String,
        refreshToken: json['refreshToken'] as String,
      );
      await store.write(fresh);
      return fresh;
    } on Exception {
      // Sin red: no se borra la sesión; la próxima petición lo intentará de nuevo.
      return current;
    }
  }

  @override
  void close() => inner.close();
}
