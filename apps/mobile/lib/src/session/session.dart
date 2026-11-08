import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:fulldays_api/api.dart';
import 'package:http/http.dart' as http;

import 'auth_http_client.dart';
import 'token_store.dart';

enum SessionStatus { loading, signedOut, signedIn }

/// Error de la API listo para mostrar: `code` para decidir, `message` para la persona.
class FdError implements Exception {
  const FdError(this.code, this.message);

  final String code;
  final String message;

  static const offline = FdError('offline', 'No pudimos conectar. Revisa tu conexión e inténtalo de nuevo.');

  factory FdError.from(Object error) {
    if (error is FdError) return error;
    if (error is ApiException) {
      try {
        final body = jsonDecode(error.message ?? '') as Map<String, dynamic>;
        final issues = body['issues'] as List<dynamic>?;
        final first = issues?.isNotEmpty == true ? (issues!.first as Map<String, dynamic>)['message'] : null;
        return FdError(body['code'] as String? ?? 'error', (first ?? body['message'] ?? offline.message) as String);
      } on Object {
        return offline;
      }
    }
    return offline;
  }

  @override
  String toString() => message;
}

/// Sesión de la app: entrar, registrarse, confirmar, recuperar y salir. Guarda los tokens
/// en el almacenamiento seguro y renueva sola cuando el acceso vence.
class SessionController extends ChangeNotifier {
  SessionController({required String apiUrl, required TokenStore store, http.Client? httpClient}) : _store = store {
    final authHttp = AuthHttpClient(
      inner: httpClient ?? http.Client(),
      store: store,
      apiUrl: apiUrl,
      onSessionLost: _lost,
    );
    client = ApiClient(basePath: apiUrl)..client = authHttp;
  }

  final TokenStore _store;
  late final ApiClient client;

  SessionStatus status = SessionStatus.loading;
  Me? me;

  AuthApi get _auth => AuthApi(client);

  /// Al abrir la app: si hay tokens guardados, carga la cuenta.
  Future<void> restore() async {
    if (await _store.read() == null) return _set(SessionStatus.signedOut);
    try {
      await refreshMe();
    } on FdError catch (e) {
      // Sin red se queda con la sesión guardada; un 401 ya la borró.
      if (e.code == 'offline' && await _store.read() != null) return _set(SessionStatus.signedIn);
      _set(SessionStatus.signedOut);
    }
  }

  Future<void> refreshMe() async {
    try {
      me = await YoApi(client).getMe();
      _set(SessionStatus.signedIn);
    } on Object catch (e) {
      throw FdError.from(e);
    }
  }

  Future<void> signIn(String email, String password) =>
      _open(() => _auth.signIn(SignInInput(email: email, password: password)));

  Future<void> register(String email, String password) =>
      _call(() => _auth.register(RegisterInput(email: email, password: password)));

  Future<void> verify(String email, String code) =>
      _open(() => _auth.verifyEmail(VerifyInput(email: email, code: code)));

  Future<void> recover(String email) => _call(() => _auth.recoverPassword(RecoverInput(email: email)));

  Future<void> reset(String email, String code, String password) =>
      _open(() => _auth.resetPassword(ResetInput(email: email, code: code, password: password)));

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on Object {
      // Sin red igual se cierra en el dispositivo.
    }
    await _store.clear();
    me = null;
    _set(SessionStatus.signedOut);
  }

  Future<void> _open(Future<SignedIn?> Function() run) async {
    final signed = await _call(run);
    if (signed == null) throw FdError.offline;
    await _store.write(StoredTokens(accessToken: signed.accessToken, refreshToken: signed.refreshToken));
    await refreshMe();
  }

  Future<T> _call<T>(Future<T> Function() run) async {
    try {
      return await run();
    } on Object catch (e) {
      throw FdError.from(e);
    }
  }

  void _lost() {
    me = null;
    _set(SessionStatus.signedOut);
  }

  void _set(SessionStatus next) {
    status = next;
    notifyListeners();
  }
}
