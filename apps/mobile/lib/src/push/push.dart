import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:fulldays_api/api.dart';

import '../session/session.dart';

/// De dónde salen los tokens de push. En la app es Firebase; en las pruebas, uno falso.
abstract class PushTokens {
  /// Pide permiso y arranca el registro. `false` si el dispositivo no tendrá push.
  Future<bool> start();

  /// El token del dispositivo, cada vez que se obtiene o cambia.
  Stream<String> get tokens;

  DeviceInputPlatformEnum get platform;
}

/// Firebase Cloud Messaging. Sin `google-services.json` / `GoogleService-Info.plist` la
/// inicialización falla y la app sigue sin push: los avisos quedan en la bandeja.
class FirebasePushTokens implements PushTokens {
  @override
  Future<bool> start() async {
    try {
      await Firebase.initializeApp();
      final settings = await FirebaseMessaging.instance.requestPermission();
      return settings.authorizationStatus != AuthorizationStatus.denied;
    } on Object catch (e) {
      debugPrint('Push desactivado: $e');
      return false;
    }
  }

  // El token de registro clásico es el que acepta `message.token` de la API HTTP v1 de FCM, que
  // usa el servidor; las APIs nuevas de FID (register/onRegistered) entregan otro identificador.
  @override
  Stream<String> get tokens async* {
    final messaging = FirebaseMessaging.instance;
    // ignore: deprecated_member_use
    final first = await messaging.getToken();
    if (first != null) yield first;
    // ignore: deprecated_member_use
    yield* messaging.onTokenRefresh;
  }

  @override
  DeviceInputPlatformEnum get platform =>
      defaultTargetPlatform == TargetPlatform.iOS ? DeviceInputPlatformEnum.ios : DeviceInputPlatformEnum.android;
}

/// Registra el token del dispositivo en la cuenta y lo quita al cerrar sesión.
class PushRegistration {
  PushRegistration(this.session, this.tokens);

  final SessionController session;
  final PushTokens tokens;
  String? _token;
  StreamSubscription<String>? _sub;

  Future<void> start() async {
    session.beforeSignOut.add(_forget);
    if (!await tokens.start()) return;
    _sub = tokens.tokens.listen(_register);
  }

  Future<void> _register(String token) async {
    _token = token;
    try {
      await NotificacionesApi(session.client).registerDevice(DeviceInput(token: token, platform: tokens.platform));
    } on Object catch (e) {
      debugPrint('No se registró el dispositivo: $e');
    }
  }

  Future<void> _forget() async {
    session.beforeSignOut.remove(_forget);
    await _sub?.cancel();
    final token = _token;
    if (token == null) return;
    await NotificacionesApi(session.client).forgetDevice(ForgetDeviceInput(token: token));
  }

  Future<void> stop() async {
    session.beforeSignOut.remove(_forget);
    await _sub?.cancel();
  }
}
