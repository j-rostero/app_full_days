/**
 * Texto del QR de un voucher: `clave:código:pasajero:salida:fecha.firma`. Los UUID van como 16
 * bytes en base64url para que el QR sea corto y legible en pantallas baratas. La firma Ed25519
 * cubre todo lo anterior al punto y la valida cualquiera con la clave pública, sin red.
 */
export interface VoucherClaims {
  keyId: string;
  code: string;
  passengerId: string;
  departureId: string;
  date: string;
}

const B64 = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789-_';

export function toBase64Url(bytes: Uint8Array): string {
  let out = '';
  for (let i = 0; i < bytes.length; i += 3) {
    const n = (bytes[i]! << 16) | ((bytes[i + 1] ?? 0) << 8) | (bytes[i + 2] ?? 0);
    const chars = [(n >> 18) & 63, (n >> 12) & 63, (n >> 6) & 63, n & 63].map((x) => B64[x]);
    out += chars.slice(0, Math.min(4, bytes.length - i + 1)).join('');
  }
  return out;
}

export function fromBase64Url(text: string): Uint8Array {
  const bytes: number[] = [];
  let buffer = 0;
  let bits = 0;
  for (const ch of text) {
    const v = B64.indexOf(ch);
    if (v < 0) throw new Error('base64url inválido');
    buffer = (buffer << 6) | v;
    bits += 6;
    if (bits >= 8) {
      bits -= 8;
      bytes.push((buffer >> bits) & 255);
    }
  }
  return Uint8Array.from(bytes);
}

const packUuid = (uuid: string) =>
  toBase64Url(
    Uint8Array.from(
      uuid
        .replace(/-/g, '')
        .match(/../g)!
        .map((h) => parseInt(h, 16)),
    ),
  );
const unpackUuid = (text: string) => {
  const hex = Array.from(fromBase64Url(text), (b) => b.toString(16).padStart(2, '0')).join('');
  if (hex.length !== 32) throw new Error('uuid inválido');
  return `${hex.slice(0, 8)}-${hex.slice(8, 12)}-${hex.slice(12, 16)}-${hex.slice(16, 20)}-${hex.slice(20)}`;
};

/** Lo que se firma. */
export function voucherPayload(c: VoucherClaims): string {
  return [
    c.keyId,
    c.code,
    packUuid(c.passengerId),
    packUuid(c.departureId),
    c.date.replace(/-/g, ''),
  ].join(':');
}

/** Separa el texto del QR en sus datos, lo firmado y la firma; `null` si no tiene la forma. */
export function parseVoucher(
  text: string,
): { claims: VoucherClaims; payload: string; signature: Uint8Array } | null {
  const dot = text.lastIndexOf('.');
  if (dot < 0) return null;
  const payload = text.slice(0, dot);
  const parts = payload.split(':');
  if (parts.length !== 5) return null;
  const [keyId, code, passenger, departure, day] = parts as [
    string,
    string,
    string,
    string,
    string,
  ];
  if (!/^\d{8}$/.test(day)) return null;
  try {
    return {
      claims: {
        keyId,
        code,
        passengerId: unpackUuid(passenger),
        departureId: unpackUuid(departure),
        date: `${day.slice(0, 4)}-${day.slice(4, 6)}-${day.slice(6)}`,
      },
      payload,
      signature: fromBase64Url(text.slice(dot + 1)),
    };
  } catch {
    return null;
  }
}
