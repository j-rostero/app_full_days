import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_mobile/src/push/push.dart';
import 'package:fulldays_mobile/src/session/session.dart';
import 'package:fulldays_mobile/src/session/token_store.dart';
import 'package:fulldays_mobile/src/traveler/inbox_screen.dart';
import 'package:fulldays_mobile/src/traveler/review_screen.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

http.Response json(int status, Object? body) => http.Response(
  body == null ? '' : jsonEncode(body),
  status,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

SessionController signedIn(Future<http.Response> Function(http.Request) handler) => SessionController(
  apiUrl: 'http://api.test',
  store: MemoryTokenStore(const StoredTokens(accessToken: 'a', refreshToken: 'r')),
  httpClient: MockClient(handler),
);

class FakeTokens implements PushTokens {
  final controller = StreamController<String>();

  @override
  Future<bool> start() async => true;

  @override
  Stream<String> get tokens => controller.stream;

  @override
  DeviceInputPlatformEnum get platform => DeviceInputPlatformEnum.android;
}

void main() {
  test('el dispositivo se registra con su token, se actualiza y se quita antes de salir', () async {
    final calls = <String>[];
    final session = signedIn((req) async {
      calls.add('${req.method} ${req.url.path} ${req.body}');
      return json(204, null);
    });
    final tokens = FakeTokens();
    final push = PushRegistration(session, tokens);
    await push.start();
    tokens.controller.add('token-uno-aaaaaaaaaaaaaaaaaaaa');
    tokens.controller.add('token-dos-bbbbbbbbbbbbbbbbbbbb');
    await Future<void>.delayed(Duration.zero);
    await session.signOut();
    expect(calls[0], contains('PUT /v1/yo/dispositivos'));
    expect(calls[0], contains('"platform":"android"'));
    expect(calls[1], contains('token-dos'));
    expect(calls[2], startsWith('POST /v1/yo/dispositivos/quitar'));
    expect(calls[2], contains('token-dos'));
    expect(calls[3], contains('/v1/auth/'));
    expect(session.beforeSignOut, isEmpty);
  });

  testWidgets('la bandeja muestra los avisos y los marca leídos', (tester) async {
    var read = false;
    final session = signedIn((req) async {
      if (req.url.path == '/v1/yo/notificaciones/leidas') {
        read = true;
        return json(204, null);
      }
      return json(200, {
        'unread': read ? 0 : 1,
        'items': [
          {
            'id': '0190f5a0-0000-7000-8000-000000000001',
            'event': 'payment_confirmed',
            'title': 'Pago confirmado',
            'body': 'Tu pago de 40 USD quedó confirmado.',
            'link': 'reserva:0190f5a0-0000-7000-8000-000000000002',
            'read': read,
            'createdAt': '2026-11-08T12:00:00.000Z',
          },
        ],
      });
    });
    await tester.pumpWidget(MaterialApp(home: InboxScreen(session: session)));
    await tester.pumpAndSettle();
    expect(find.text('Pago confirmado'), findsOneWidget);
    await tester.tap(find.text('Marcar leídos'));
    await tester.pumpAndSettle();
    expect(read, isTrue);
    expect(find.text('Marcar leídos'), findsNothing);
  });

  testWidgets('la reseña envía estrellas, aspectos y si fue como se describió', (tester) async {
    Map<String, dynamic>? sent;
    final session = signedIn((req) async {
      sent = jsonDecode(req.body) as Map<String, dynamic>;
      return json(400, {'code': 'validation_error', 'message': 'Algo falló.'});
    });
    await tester.pumpWidget(
      MaterialApp(
        home: ReviewScreen(session: session, bookingId: '0190f5a0-0000-7000-8000-000000000003', title: 'Cayo Sombrero'),
      ),
    );
    await tester.tap(find.byTooltip('4').first);
    await tester.ensureVisible(find.byType(Switch));
    await tester.tap(find.byType(Switch));
    await tester.pump();
    await tester.ensureVisible(find.text('Publicar reseña'));
    await tester.tap(find.text('Publicar reseña'));
    await tester.pumpAndSettle();
    expect(sent?['rating'], 4);
    expect(sent?['asDescribed'], isFalse);
    expect(find.text('Algo falló.'), findsOneWidget);
  });
}
