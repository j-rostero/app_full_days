import 'dart:convert';

import 'package:cryptography/cryptography.dart';

/// Datos de un voucher leído del QR: `clave:código:pasajero:salida:fecha.firma`.
class VoucherClaims {
  const VoucherClaims({
    required this.keyId,
    required this.code,
    required this.passengerId,
    required this.departureId,
    required this.date,
  });

  final String keyId;
  final String code;
  final String passengerId;
  final String departureId;
  final String date;
}

enum VoucherProblem { unreadable, unknownKey, badSignature }

class VoucherCheck {
  const VoucherCheck.ok(VoucherClaims this.claims) : problem = null;
  const VoucherCheck.fail(VoucherProblem this.problem) : claims = null;

  final VoucherClaims? claims;
  final VoucherProblem? problem;

  String get message => switch (problem) {
    null => 'Voucher válido.',
    VoucherProblem.unreadable => 'Ese código no es un voucher de FullDays.',
    VoucherProblem.unknownKey => 'Voucher firmado con una llave desconocida. Sincroniza la lista con señal.',
    VoucherProblem.badSignature => 'La firma no coincide: el voucher fue alterado.',
  };
}

List<int> _b64url(String text) => base64Url.decode(text.padRight((text.length + 3) ~/ 4 * 4, '='));

String _uuid(String packed) {
  final hex = _b64url(packed).map((b) => b.toRadixString(16).padLeft(2, '0')).join();
  if (hex.length != 32) throw const FormatException('uuid');
  return '${hex.substring(0, 8)}-${hex.substring(8, 12)}-${hex.substring(12, 16)}-'
      '${hex.substring(16, 20)}-${hex.substring(20)}';
}

/// Valida la firma Ed25519 con las llaves públicas guardadas: funciona sin red.
/// [keys] es id de la llave → llave pública en base64url.
Future<VoucherCheck> checkVoucher(String text, Map<String, String> keys) async {
  final dot = text.trim().lastIndexOf('.');
  if (dot < 0) return const VoucherCheck.fail(VoucherProblem.unreadable);
  final payload = text.trim().substring(0, dot);
  final parts = payload.split(':');
  if (parts.length != 5 || !RegExp(r'^\d{8}$').hasMatch(parts[4])) {
    return const VoucherCheck.fail(VoucherProblem.unreadable);
  }
  final VoucherClaims claims;
  final List<int> signature;
  try {
    final day = parts[4];
    claims = VoucherClaims(
      keyId: parts[0],
      code: parts[1],
      passengerId: _uuid(parts[2]),
      departureId: _uuid(parts[3]),
      date: '${day.substring(0, 4)}-${day.substring(4, 6)}-${day.substring(6)}',
    );
    signature = _b64url(text.trim().substring(dot + 1));
  } on FormatException {
    return const VoucherCheck.fail(VoucherProblem.unreadable);
  }
  final key = keys[claims.keyId];
  if (key == null) return const VoucherCheck.fail(VoucherProblem.unknownKey);
  final valid = await Ed25519().verify(
    utf8.encode(payload),
    signature: Signature(signature, publicKey: SimplePublicKey(_b64url(key), type: KeyPairType.ed25519)),
  );
  return valid ? VoucherCheck.ok(claims) : const VoucherCheck.fail(VoucherProblem.badSignature);
}
