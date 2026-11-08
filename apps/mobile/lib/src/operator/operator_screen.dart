import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../session/session.dart';
import '../traveler/common.dart';
import 'checkin_store.dart';
import 'voucher_check.dart';

const _marks = {'boarded': 'Abordó', 'no_show': 'No se presentó'};

/// Agencias donde la persona puede pasar lista.
List<Membership> checkinMemberships(Me? me) => [
  for (final m in me?.memberships ?? <Membership>[])
    if (m.permissions.contains(ProviderPermission.checkin)) m,
];

/// Modo operador: salidas de hoy y mañana de la agencia escogida, guardadas para verlas sin señal.
class OperatorScreen extends StatefulWidget {
  const OperatorScreen({super.key, required this.session, this.prefs});

  final SessionController session;
  final SharedPreferencesAsync? prefs;

  @override
  State<OperatorScreen> createState() => _OperatorScreenState();
}

class _OperatorScreenState extends State<OperatorScreen> {
  late final _prefs = widget.prefs ?? SharedPreferencesAsync();
  late List<Membership> _agencies = checkinMemberships(widget.session.me);
  late String? _providerId = _agencies.firstOrNull?.providerId;

  Future<(TodayList, bool)> _load() async {
    final key = 'checkin:$_providerId:today';
    try {
      final list = await call(() => DiaDelViajeApi(widget.session.client).listTodayDepartures(_providerId!));
      await _prefs.setString(key, jsonEncode(list.toJson()));
      return (list, false);
    } on FdError catch (e) {
      final saved = await _prefs.getString(key);
      if (e.code == 'offline' && saved != null) return (TodayList.fromJson(jsonDecode(saved))!, true);
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    _agencies = checkinMemberships(widget.session.me);
    if (_providerId == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Operar')),
        body: const Center(child: Text('Tu rol no hace check-in.')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Salidas de hoy')),
      body: Column(
        children: [
          if (_agencies.length > 1)
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
              child: DropdownButtonFormField<String>(
                initialValue: _providerId,
                decoration: const InputDecoration(labelText: 'Agencia'),
                items: [for (final m in _agencies) DropdownMenuItem(value: m.providerId, child: Text(m.providerName))],
                onChanged: (v) => setState(() => _providerId = v),
              ),
            ),
          Expanded(
            child: Loader<(TodayList, bool)>(
              key: ValueKey(_providerId),
              load: _load,
              builder: (context, data, reload) {
                final (list, offline) = data;
                return RefreshIndicator(
                  onRefresh: reload,
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (offline) const Text('Sin señal: mostrando lo guardado.'),
                      if (list.items.isEmpty) const Text('No tienes salidas hoy ni mañana.'),
                      for (final d in list.items)
                        Card(
                          child: ListTile(
                            title: Text(d.title),
                            subtitle: Text('${shortDate(d.date)} · ${d.boarded} de ${d.passengers} a bordo'),
                            trailing: const Icon(Icons.chevron_right),
                            onTap: () => Navigator.of(context).push(
                              MaterialPageRoute<void>(
                                builder: (_) => CheckinScreen(
                                  store: CheckinStore(
                                    departureId: d.id,
                                    prefs: _prefs,
                                    download: () => call(
                                      () => DiaDelViajeApi(widget.session.client).getManifest(_providerId!, d.id),
                                    ),
                                    upload: (events) => call(
                                      () =>
                                          DiaDelViajeApi(widget.session.client)
                                              .syncCheckins(_providerId!, d.id, CheckinSyncInput(events: events)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Pasar lista: escanear vouchers o marcar a mano; todo queda en el teléfono hasta sincronizar.
class CheckinScreen extends StatefulWidget {
  const CheckinScreen({super.key, required this.store, this.scan});

  final CheckinStore store;

  /// Lector de QR; en pruebas se reemplaza.
  final Future<String?> Function(BuildContext context)? scan;

  @override
  State<CheckinScreen> createState() => _CheckinScreenState();
}

class _CheckinScreenState extends State<CheckinScreen> {
  ManifestSource? _source;
  bool _syncing = false;
  String? _notice;

  CheckinStore get _store => widget.store;

  @override
  void initState() {
    super.initState();
    _store.open().then((s) {
      if (mounted) setState(() => _source = s);
    });
  }

  Future<void> _mark(String passengerId, String? mark) async {
    await _store.mark(passengerId, mark);
    setState(() {});
  }

  Future<void> _sync() async {
    setState(() => _syncing = true);
    try {
      final discarded = await _store.sync();
      final names = {for (final p in _store.manifest!.passengers) p.id: p.name ?? 'Pasajero ${p.position + 1}'};
      final clock = discarded.where((d) => d.reason == ManifestDiscardedInnerReasonEnum.clock);
      final older = discarded.where((d) => d.reason == ManifestDiscardedInnerReasonEnum.older);
      setState(() {
        _source = ManifestSource.network;
        _notice = [
          if (clock.isNotEmpty)
            'No se aplicó la marca de ${clock.map((d) => names[d.passengerId]).join(', ')}: '
                'la hora del teléfono está adelantada. Corrígela y marca de nuevo.',
          if (older.isNotEmpty)
            'Otro guía marcó después a ${older.map((d) => names[d.passengerId]).join(', ')}; quedó su marca.',
        ].join('\n');
        if (_notice!.isEmpty) _notice = 'Lista sincronizada.';
      });
    } on Object {
      setState(() => _notice = 'Sin señal. Las marcas quedan guardadas en el teléfono.');
    } finally {
      if (mounted) setState(() => _syncing = false);
    }
  }

  Future<void> _scan() async {
    final text = await (widget.scan ?? _openScanner)(context);
    if (text == null || !mounted) return;
    final check = await checkVoucher(text, _store.keys);
    final manifest = _store.manifest!;
    final claims = check.claims;
    String message = check.message;
    if (claims != null) {
      final p = manifest.passengers.where((x) => x.id == claims.passengerId).firstOrNull;
      if (claims.departureId != manifest.departure.id) {
        message = 'Ese voucher es de otra salida (${claims.date}).';
      } else if (p == null) {
        message = 'Ese pasajero no tiene la reserva confirmada.';
      } else {
        await _store.mark(p.id, 'boarded');
        message = '${p.name ?? 'Pasajero ${p.position + 1}'} abordó.';
      }
    }
    if (!mounted) return;
    setState(() => _notice = message);
  }

  Future<String?> _openScanner(BuildContext context) => Navigator.of(context).push<String>(
    MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Escanear voucher')),
        body: MobileScanner(
          onDetect: (capture) {
            final value = capture.barcodes.firstOrNull?.rawValue;
            if (value != null) Navigator.of(context).pop(value);
          },
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final manifest = _store.manifest;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(manifest?.departure.title ?? 'Pasar lista'),
        actions: [
          IconButton(
            tooltip: 'Sincronizar',
            onPressed: _syncing || manifest == null ? null : _sync,
            icon: const Icon(Icons.sync),
          ),
        ],
      ),
      floatingActionButton: manifest == null
          ? null
          : FloatingActionButton.extended(
              onPressed: _scan,
              icon: const Icon(Icons.qr_code_scanner),
              label: const Text('Escanear'),
            ),
      body: switch (_source) {
        null => const Center(child: CircularProgressIndicator()),
        ManifestSource.none => const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text(
              'Sin señal y sin lista guardada. Abre esta salida una vez con conexión.',
              textAlign: TextAlign.center,
            ),
          ),
        ),
        _ => ListView(
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 96),
          children: [
            if (_source == ManifestSource.device) const Text('Sin señal: usando la lista guardada.'),
            Text(
              '${manifest!.passengers.where((p) => _store.markOf(p) == 'boarded').length} de '
              '${manifest.passengers.length} a bordo'
              '${_store.pending.isNotEmpty ? ' · ${_store.pending.length} marcas sin subir' : ''}',
              style: theme.textTheme.titleMedium,
            ),
            if (_notice != null && _notice!.isNotEmpty)
              Padding(padding: const EdgeInsets.only(top: 8), child: Text(_notice!)),
            for (final p in manifest.passengers) _passenger(p),
          ],
        ),
      },
    );
  }

  Widget _passenger(ManifestPassenger p) {
    final mark = _store.markOf(p);
    return Card(
      margin: const EdgeInsets.only(top: 12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(p.name ?? 'Pasajero ${p.position + 1}', style: Theme.of(context).textTheme.titleSmall),
            Text(
              [
                p.bookingCode,
                if (p.cedula != null) 'C.I. ${p.cedula}',
                if (p.boarding != null) p.boarding!,
                if (mark != null) _marks[mark]!,
              ].join(' · '),
            ),
            for (final m in p.meals) Text(m),
            if (p.restrictions != null) Text('Restricciones: ${p.restrictions}'),
            if (p.balanceUsd > 0 && p.position == 0) Text('Saldo por cobrar: ${usd(p.balanceUsd)}'),
            Wrap(
              spacing: 8,
              children: [
                if (mark != 'boarded')
                  FilledButton(onPressed: () => _mark(p.id, 'boarded'), child: const Text('Abordó')),
                if (mark != 'no_show')
                  OutlinedButton(onPressed: () => _mark(p.id, 'no_show'), child: const Text('No se presentó')),
                if (mark != null) TextButton(onPressed: () => _mark(p.id, null), child: const Text('Deshacer')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
