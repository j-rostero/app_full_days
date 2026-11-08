import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_mobile/main.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';

ApiClient fakeApi(Future<http.Response> Function(http.Request) handler) =>
    ApiClient(basePath: 'http://api.test')..client = MockClient(handler);

http.Response json(int status, Object body) => http.Response(
      jsonEncode(body),
      status,
      headers: {'content-type': 'application/json; charset=utf-8'},
    );

void main() {
  testWidgets('muestra la API conectada cuando /salud responde ok', (tester) async {
    final client = fakeApi((request) async {
      expect(request.url.path, '/salud');
      return json(200, {
        'status': 'ok',
        'checks': {'database': 'ok', 'redis': 'ok'},
      });
    });
    await tester.pumpWidget(FullDaysApp(client: client, flavor: 'dev'));
    await tester.pumpAndSettle();

    expect(find.text('API conectada'), findsOneWidget);
    expect(find.text('Base de datos: en línea'), findsOneWidget);
  });

  testWidgets('una API degradada (503) muestra qué servicio falla', (tester) async {
    final client = fakeApi((_) async => json(503, {
          'status': 'degraded',
          'checks': {'database': 'ok', 'redis': 'down'},
        }));
    await tester.pumpWidget(FullDaysApp(client: client, flavor: 'dev'));
    await tester.pumpAndSettle();

    expect(find.text('API con problemas'), findsOneWidget);
    expect(find.text('Redis: sin respuesta'), findsOneWidget);
  });

  testWidgets('sin red muestra un mensaje y permite reintentar', (tester) async {
    var calls = 0;
    final client = fakeApi((_) async {
      calls++;
      throw http.ClientException('sin red');
    });
    await tester.pumpWidget(FullDaysApp(client: client, flavor: 'dev'));
    await tester.pumpAndSettle();
    expect(find.text('No pudimos conectar con la API. Revisa tu conexión.'), findsOneWidget);

    await tester.tap(find.widgetWithText(FilledButton, 'Volver a comprobar'));
    await tester.pumpAndSettle();
    expect(calls, 2);
  });
}
