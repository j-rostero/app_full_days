import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fulldays_api/api.dart';
import 'package:fulldays_mobile/src/operator/checkin_store.dart';
import 'package:fulldays_mobile/src/operator/operator_screen.dart';
import 'package:fulldays_mobile/src/operator/voucher_check.dart';
import 'package:shared_preferences_platform_interface/in_memory_shared_preferences_async.dart';
import 'package:shared_preferences_platform_interface/shared_preferences_async_platform_interface.dart';

// Firmado por la API con la llave de desarrollo (ver apps/api/src/payments/vouchers.ts).
const keyId = 'buCR_SgK';
const publicKey = 'buCR_SgKm2hVT6c8WIEl1H00JcaKJroja02tkPkKj5I';
const qr =
    'buCR_SgK:FD-ABCD2345:AaG5ZV-gdp-PtL8SSn8Smg:AaG5fenccqGku7J1OAds-A:20261120.'
    '9hvMu80_nmsuVFYQ2AU9seic3l9W_GsJD-J5nPjrNBYKT9-XNPv7fsGLW8gaW0C-zdZFJSCoVK8hwuehnigAAw';
const passengerId = '01a1b965-5fa0-769f-8fb4-bf124a7f129a';
const departureId = '01a1b97d-e9dc-72a1-a4bb-b27538076cf8';
const otherId = '01a1b965-5fa0-769f-8fb4-bf124a7f1200';

Manifest manifest({String? anaMark, List<Map<String, Object?>> discarded = const []}) => Manifest.fromJson({
  'departure': {'id': departureId, 'date': '2026-11-20', 'title': 'Cayo Sombrero', 'status': 'in_progress'},
  'keys': [
    {'id': keyId, 'publicKey': publicKey, 'retired': false},
  ],
  'passengers': [
    for (final (id, name, mark) in [(passengerId, 'Ana Pérez', anaMark), (otherId, 'Luis Pérez', null)])
      {
        'id': id,
        'bookingId': departureId,
        'bookingCode': 'FD-ABCD2345',
        'position': id == passengerId ? 0 : 1,
        'type': 'adult',
        'name': name,
        'cedula': null,
        'restrictions': null,
        'meals': <String>[],
        'boarding': 'Caracas',
        'balanceUsd': 0,
        'checkin': mark,
        'checkinAt': null,
      },
  ],
  'discarded': discarded,
})!;

void main() {
  setUp(() => SharedPreferencesAsyncPlatform.instance = InMemorySharedPreferencesAsync.empty());

  test('valida la firma del voucher sin red y detecta alteraciones', () async {
    final keys = {keyId: publicKey};
    final ok = await checkVoucher(qr, keys);
    expect(ok.claims?.passengerId, passengerId);
    expect(ok.claims?.departureId, departureId);
    expect(ok.claims?.date, '2026-11-20');
    expect(
      (await checkVoucher(qr.replaceFirst('FD-ABCD2345', 'FD-ABCD2346'), keys)).problem,
      VoucherProblem.badSignature,
    );
    expect((await checkVoucher(qr, {})).problem, VoucherProblem.unknownKey);
    expect((await checkVoucher('hola', keys)).problem, VoucherProblem.unreadable);
  });

  test('sin señal usa la lista guardada, conserva las marcas y al sincronizar quita solo lo enviado', () async {
    var online = true;
    final uploads = <List<CheckinSyncInputEventsInner>>[];
    CheckinStore store() => CheckinStore(
      departureId: departureId,
      download: () async => online ? manifest() : throw Exception('sin red'),
      upload: (events) async {
        uploads.add(events);
        return manifest(
          anaMark: 'boarded',
          discarded: [
            {'passengerId': otherId, 'reason': 'clock'},
          ],
        );
      },
    );
    expect(await store().open(), ManifestSource.network);

    online = false;
    final offline = store();
    expect(await offline.open(), ManifestSource.device);
    await offline.mark(passengerId, 'boarded');
    await offline.mark(otherId, 'no_show');
    expect(offline.markOf(offline.manifest!.passengers.first), 'boarded');

    // Otra pantalla (o la app reabierta) ve la cola guardada.
    final reopened = store();
    await reopened.open();
    expect(reopened.pending.length, 2);

    final discarded = await reopened.sync();
    expect(uploads.single.length, 2);
    expect(reopened.pending, isEmpty);
    expect(discarded.single.reason, ManifestDiscardedInnerReasonEnum.clock);
  });

  testWidgets('escanear un voucher válido marca al pasajero como abordado', (tester) async {
    final store = CheckinStore(
      departureId: departureId,
      download: () async => manifest(),
      upload: (_) async => manifest(),
    );
    await tester.pumpWidget(
      MaterialApp(
        home: CheckinScreen(store: store, scan: (_) async => qr),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('0 de 2 a bordo'), findsOneWidget);
    await tester.tap(find.text('Escanear'));
    await tester.runAsync(() => Future<void>.delayed(const Duration(milliseconds: 300)));
    await tester.pumpAndSettle();
    expect(find.text('Ana Pérez abordó.'), findsOneWidget);
    expect(find.textContaining('1 de 2 a bordo'), findsOneWidget);
  });
}
