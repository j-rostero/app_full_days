import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_mobile/main.dart';
import 'package:fulldays_mobile/src/session/session.dart';
import 'package:fulldays_mobile/src/session/token_store.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response json(int status, Object body) =>
    http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json; charset=utf-8'});

Map<String, Object?> me(String email) => {
  'id': '0190f5a0-0000-7000-8000-000000000001',
  'email': email,
  'name': null,
  'phone': null,
  'hasPassword': true,
  'hasGoogle': false,
  'memberships': <Object>[],
  'staff': {'roles': <Object>[], 'permissions': <Object>[]},
};

Map<String, Object?> signed(String access, String refresh) => {
  'accessToken': access,
  'refreshToken': refresh,
  'expiresIn': 900,
  'user': {'id': '0190f5a0-0000-7000-8000-000000000001', 'email': 'ana@x.com', 'name': null, 'phone': null},
};

SessionController controller(MemoryTokenStore store, Future<http.Response> Function(http.Request) handler) =>
    SessionController(apiUrl: 'http://api.test', store: store, httpClient: MockClient(handler));

void main() {
  test('entrar guarda los tokens y carga la cuenta', () async {
    final store = MemoryTokenStore();
    final session = controller(store, (r) async {
      if (r.url.path == '/v1/auth/entrar') return json(200, signed('a1', 'r1'));
      expect(r.headers['Authorization'], 'Bearer a1');
      return json(200, me('ana@x.com'));
    });
    await session.signIn('ana@x.com', 'clave-segura-1');
    expect(session.status, SessionStatus.signedIn);
    expect(session.me?.email, 'ana@x.com');
    expect(store.tokens?.refreshToken, 'r1');
  });

  test('un acceso vencido se renueva una vez y se repite la petición', () async {
    final store = MemoryTokenStore(const StoredTokens(accessToken: 'viejo', refreshToken: 'r1'));
    var renewals = 0;
    final session = controller(store, (r) async {
      if (r.url.path == '/v1/auth/renovar') {
        renewals++;
        expect(jsonDecode(r.body), {'refreshToken': 'r1'});
        return json(200, {'accessToken': 'nuevo', 'refreshToken': 'r2', 'expiresIn': 900});
      }
      if (r.headers['Authorization'] != 'Bearer nuevo') {
        return json(401, {'statusCode': 401, 'code': 'unauthorized', 'message': 'x'});
      }
      return json(200, me('ana@x.com'));
    });
    await session.restore();
    expect(session.status, SessionStatus.signedIn);
    expect(renewals, 1);
    expect(store.tokens?.refreshToken, 'r2');
  });

  test('si la renovación falla la sesión se cierra y se borran los tokens', () async {
    final store = MemoryTokenStore(const StoredTokens(accessToken: 'viejo', refreshToken: 'robado'));
    final session = controller(store, (r) async {
      return json(401, {'statusCode': 401, 'code': 'unauthorized', 'message': 'Tu sesión venció. Vuelve a entrar.'});
    });
    await session.restore();
    expect(session.status, SessionStatus.signedOut);
    expect(store.tokens, isNull);
  });

  testWidgets('un error de la API se muestra en el formulario', (tester) async {
    final session = controller(MemoryTokenStore(), (r) async {
      return json(401, {
        'statusCode': 401,
        'code': 'unauthorized',
        'message': 'El correo o la contraseña no son correctos.',
      });
    });
    await session.restore();
    await tester.pumpWidget(FullDaysApp(session: session, flavor: 'dev'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('campo-email')), 'ana@x.com');
    await tester.enterText(find.byKey(const ValueKey('campo-password')), 'mala');
    await tester.tap(find.widgetWithText(FilledButton, 'Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('El correo o la contraseña no son correctos.'), findsOneWidget);
  });

  testWidgets('una cuenta sin confirmar pasa a la pantalla del código', (tester) async {
    final session = controller(MemoryTokenStore(), (r) async {
      if (r.url.path == '/v1/auth/entrar') {
        return json(403, {'statusCode': 403, 'code': 'email_not_verified', 'message': 'Confirma tu correo.'});
      }
      if (r.url.path == '/v1/auth/verificar') return json(200, signed('a1', 'r1'));
      return json(200, me('ana@x.com'));
    });
    await session.restore();
    await tester.pumpWidget(FullDaysApp(session: session, flavor: 'dev'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byKey(const ValueKey('campo-email')), 'ana@x.com');
    await tester.enterText(find.byKey(const ValueKey('campo-password')), 'clave-segura-1');
    await tester.tap(find.widgetWithText(FilledButton, 'Entrar'));
    await tester.pumpAndSettle();
    expect(find.text('Confirma tu correo'), findsOneWidget);

    await tester.enterText(find.byKey(const ValueKey('campo-code')), '123456');
    await tester.tap(find.widgetWithText(FilledButton, 'Confirmar'));
    await tester.pumpAndSettle();
    // Con la sesión abierta entra al modo viajero.
    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.text('Hola, ana@x.com.', skipOffstage: false), findsOneWidget);
  });
}
