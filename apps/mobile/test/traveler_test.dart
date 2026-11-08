import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_mobile/src/session/session.dart';
import 'package:fulldays_mobile/src/session/token_store.dart';
import 'package:fulldays_mobile/src/traveler/explore_screen.dart';
import 'package:fulldays_mobile/src/traveler/vouchers_screen.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

http.Response json(int status, Object body) =>
    http.Response(jsonEncode(body), status, headers: {'content-type': 'application/json; charset=utf-8'});

SessionController signedIn(Future<http.Response> Function(http.Request) handler) => SessionController(
  apiUrl: 'http://api.test',
  store: MemoryTokenStore(const StoredTokens(accessToken: 'a', refreshToken: 'r')),
  httpClient: MockClient(handler),
);

const _id = '0190f5a0-0000-7000-8000-0000000000';

Map<String, Object?> card(int i) => {
  'departureId': '${_id}1$i',
  'productId': '${_id}2$i',
  'date': '2026-12-20',
  'status': 'open',
  'type': 'fullday',
  'title': 'Cayo Sombrero $i',
  'summary': 'Playa',
  'cover': null,
  'priceUsd': 45,
  'seatsLeft': i == 0 ? 0 : 12,
  'days': 1,
  'destination': 'Morrocoy',
  'cities': ['caracas'],
  'featured': i == 1,
  'provider': {'id': '${_id}30', 'name': 'Rutas', 'badge': 'new', 'baseCity': 'Caracas'},
};

Map<String, Object?> vouchers() => {
  'bookingCode': 'FD-ABCDEFGH',
  'title': 'Cayo Sombrero',
  'date': '2026-12-20',
  'items': [
    {
      'passengerId': '${_id}40',
      'position': 0,
      'type': 'adult',
      'name': 'Ana Pérez',
      'qr': 'abcd1234:FD-ABCDEFGH:x:y:20261220.firma',
    },
  ],
};

void main() {
  setUp(() => SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty());

  testWidgets('explorar muestra salidas, los puestos y lo agotado', (tester) async {
    String? query;
    final session = signedIn((r) async {
      expect(r.url.path, '/v1/salidas');
      query = r.url.queryParameters['q'];
      return json(200, {
        'items': [card(0), card(1)],
        'page': 1,
        'hasMore': false,
      });
    });
    await tester.pumpWidget(MaterialApp(home: ExploreScreen(session: session)));
    await tester.pumpAndSettle();
    expect(find.text('Cayo Sombrero 1'), findsOneWidget);
    expect(find.text('Agotado'), findsOneWidget);
    expect(find.text('12 puestos'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'roques');
    await tester.testTextInput.receiveAction(TextInputAction.search);
    await tester.pumpAndSettle();
    expect(query, 'roques');
  });

  test('los vouchers se guardan y se muestran sin señal', () async {
    var online = true;
    final session = signedIn((r) async {
      if (!online) throw http.ClientException('sin red');
      return json(200, vouchers());
    });
    final cache = VoucherCache();
    final (first, firstOffline) = await loadVouchers(session, 'b1', cache);
    expect(firstOffline, isFalse);
    expect(first.items.single.name, 'Ana Pérez');

    online = false;
    final (saved, offline) = await loadVouchers(session, 'b1', cache);
    expect(offline, isTrue);
    expect(saved.items.single.qr, first.items.single.qr);

    await expectLater(loadVouchers(session, 'otra', cache), throwsA(isA<FdError>()));
  });
}
