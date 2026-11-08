import 'dart:convert';

import 'package:fulldays_api/api.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Una marca hecha en el teléfono, pendiente de subir. `checkin: null` deshace.
class PendingMark {
  const PendingMark({required this.passengerId, required this.checkin, required this.at});

  final String passengerId;
  final String? checkin;
  final DateTime at;

  Map<String, dynamic> toJson() => {'passengerId': passengerId, 'checkin': checkin, 'at': at.toUtc().toIso8601String()};

  static PendingMark fromJson(Map<String, dynamic> j) => PendingMark(
    passengerId: j['passengerId'] as String,
    checkin: j['checkin'] as String?,
    at: DateTime.parse(j['at'] as String),
  );

  CheckinSyncInputEventsInner toEvent() => CheckinSyncInputEventsInner(
    passengerId: passengerId,
    checkin: checkin == null ? null : CheckinSyncInputEventsInnerCheckinEnum.fromJson(checkin),
    at: at.toUtc(),
  );

  @override
  bool operator ==(Object other) =>
      other is PendingMark && other.passengerId == passengerId && other.checkin == checkin && other.at == at;

  @override
  int get hashCode => Object.hash(passengerId, checkin, at);
}

/// De dónde salió la lista: la red, la copia del teléfono o ninguna.
enum ManifestSource { network, device, none }

/// Lista de una salida y cola de marcas guardadas en el teléfono, para pasar lista sin señal.
class CheckinStore {
  CheckinStore({
    required this.departureId,
    required this.download,
    required this.upload,
    SharedPreferencesAsync? prefs,
    DateTime Function()? clock,
  }) : _prefs = prefs ?? SharedPreferencesAsync(),
       _clock = clock ?? DateTime.now;

  final String departureId;
  final Future<Manifest> Function() download;
  final Future<Manifest> Function(List<CheckinSyncInputEventsInner> events) upload;
  final SharedPreferencesAsync _prefs;
  final DateTime Function() _clock;

  Manifest? manifest;
  List<PendingMark> pending = [];

  String get _manifestKey => 'checkin:$departureId:manifest';
  String get _pendingKey => 'checkin:$departureId:pending';

  /// Lee la cola, intenta bajar la lista y, sin señal, usa la copia guardada.
  Future<ManifestSource> open() async {
    final raw = await _prefs.getString(_pendingKey);
    pending = raw == null
        ? []
        : [for (final j in jsonDecode(raw) as List<dynamic>) PendingMark.fromJson(j as Map<String, dynamic>)];
    try {
      manifest = await download();
      await _saveManifest();
      return ManifestSource.network;
    } on Object {
      final saved = await _prefs.getString(_manifestKey);
      if (saved == null) return ManifestSource.none;
      manifest = Manifest.fromJson(jsonDecode(saved));
      return ManifestSource.device;
    }
  }

  /// Lo que ve el guía: la marca pendiente más reciente encima de la del servidor.
  String? markOf(ManifestPassenger p) {
    final mine = pending.where((m) => m.passengerId == p.id);
    if (mine.isNotEmpty) return mine.last.checkin;
    return p.checkin?.toJson();
  }

  Map<String, String> get keys => {for (final k in manifest?.keys ?? <VoucherKey>[]) k.id: k.publicKey};

  Future<void> mark(String passengerId, String? checkin) async {
    pending = [...pending, PendingMark(passengerId: passengerId, checkin: checkin, at: _clock())];
    await _savePending();
  }

  /// Sube una copia de la cola; adopta la lista que responde la API y quita solo lo enviado.
  /// Devuelve las marcas que la API no aplicó, para avisar al guía.
  Future<List<ManifestDiscardedInner>> sync() async {
    if (pending.isEmpty) {
      manifest = await download();
      await _saveManifest();
      return [];
    }
    final sent = [...pending];
    final fresh = await upload([for (final m in sent) m.toEvent()]);
    manifest = fresh;
    pending = pending.where((m) => !sent.contains(m)).toList();
    await _saveManifest();
    await _savePending();
    return fresh.discarded;
  }

  Future<void> _saveManifest() => _prefs.setString(_manifestKey, jsonEncode(manifest!.toJson()));
  Future<void> _savePending() => _prefs.setString(_pendingKey, jsonEncode([for (final m in pending) m.toJson()]));
}
