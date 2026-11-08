import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fulldays_api/api.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../session/session.dart';
import 'common.dart';

/// Guarda los vouchers en el teléfono: el día del viaje se muestran sin señal.
class VoucherCache {
  VoucherCache([SharedPreferencesAsync? prefs]) : _prefs = prefs ?? SharedPreferencesAsync();

  final SharedPreferencesAsync _prefs;

  String _key(String bookingId) => 'vouchers:$bookingId';

  Future<void> save(String bookingId, VoucherList list) => _prefs.setString(_key(bookingId), jsonEncode(list.toJson()));

  Future<VoucherList?> read(String bookingId) async {
    final raw = await _prefs.getString(_key(bookingId));
    return raw == null ? null : VoucherList.fromJson(jsonDecode(raw));
  }
}

/// Primero la red; sin señal, la copia guardada.
Future<(VoucherList, bool)> loadVouchers(SessionController session, String bookingId, VoucherCache cache) async {
  try {
    final fresh = await call(() => PagosApi(session.client).getVouchers(bookingId));
    await cache.save(bookingId, fresh);
    return (fresh, false);
  } on FdError catch (e) {
    final saved = await cache.read(bookingId);
    if (e.code == 'offline' && saved != null) return (saved, true);
    rethrow;
  }
}

class VouchersScreen extends StatelessWidget {
  const VouchersScreen({super.key, required this.session, required this.bookingId, this.cache});

  final SessionController session;
  final String bookingId;
  final VoucherCache? cache;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Vouchers')),
      body: Loader<(VoucherList, bool)>(
        load: () => loadVouchers(session, bookingId, cache ?? VoucherCache()),
        builder: (context, data, _) {
          final (list, offline) = data;
          final theme = Theme.of(context);
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(list.title, style: theme.textTheme.titleLarge),
              Text('${shortDate(list.date)} · Reserva ${list.bookingCode}'),
              if (offline) const Text('Sin conexión: mostramos la copia guardada en tu teléfono.'),
              const SizedBox(height: 8),
              const Text('Muestra un código por pasajero al abordar. Funcionan sin señal.'),
              for (final v in list.items)
                Card(
                  margin: const EdgeInsets.only(top: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(v.name ?? 'Pasajero ${v.position + 1}', style: theme.textTheme.titleMedium),
                        const SizedBox(height: 8),
                        ColoredBox(
                          color: Colors.white,
                          child: QrImageView(data: v.qr, size: 240, errorCorrectionLevel: QrErrorCorrectLevel.M),
                        ),
                      ],
                    ),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
