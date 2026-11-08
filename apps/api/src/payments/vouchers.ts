import { createPrivateKey, createPublicKey, type KeyObject, sign, verify } from 'node:crypto';
import { parseVoucher, toBase64Url, type VoucherClaims, voucherPayload } from '@fulldays/shared';

const PKCS8_ED25519 = Buffer.from('302e020100300506032b657004220420', 'hex');
const SPKI_ED25519 = Buffer.from('302a300506032b6570032100', 'hex');

export interface VoucherKey {
  id: string;
  publicKey: string;
  retired: boolean;
}

/** Firma y valida vouchers con Ed25519. El id de una clave son los 8 primeros caracteres de su clave pública. */
export class VoucherSigner {
  private readonly privateKey: KeyObject;
  readonly current: VoucherKey;
  private readonly verifiers = new Map<string, KeyObject>();

  constructor(seedHex: string, retired: string[] = []) {
    this.privateKey = createPrivateKey({
      key: Buffer.concat([PKCS8_ED25519, Buffer.from(seedHex, 'hex')]),
      format: 'der',
      type: 'pkcs8',
    });
    const raw = createPublicKey(this.privateKey)
      .export({ format: 'der', type: 'spki' })
      .subarray(-32);
    this.current = { ...this.keyOf(raw), retired: false };
    for (const pub of retired) this.keyOf(Buffer.from(pub, 'base64url'));
  }

  private keyOf(raw: Buffer): { id: string; publicKey: string } {
    const publicKey = toBase64Url(raw);
    const id = publicKey.slice(0, 8);
    this.verifiers.set(
      id,
      createPublicKey({ key: Buffer.concat([SPKI_ED25519, raw]), format: 'der', type: 'spki' }),
    );
    return { id, publicKey };
  }

  keys(): VoucherKey[] {
    return [...this.verifiers.entries()].map(([id, key]) => ({
      id,
      publicKey: toBase64Url(key.export({ format: 'der', type: 'spki' }).subarray(-32)),
      retired: id !== this.current.id,
    }));
  }

  sign(claims: Omit<VoucherClaims, 'keyId'>): string {
    const payload = voucherPayload({ ...claims, keyId: this.current.id });
    return `${payload}.${sign(null, Buffer.from(payload), this.privateKey).toString('base64url')}`;
  }

  verify(text: string): VoucherClaims | null {
    const parsed = parseVoucher(text);
    const key = parsed && this.verifiers.get(parsed.claims.keyId);
    if (!parsed || !key) return null;
    return verify(null, Buffer.from(parsed.payload), key, parsed.signature) ? parsed.claims : null;
  }
}
