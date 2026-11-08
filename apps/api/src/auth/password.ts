import { randomBytes, scrypt as scryptCb, timingSafeEqual } from 'node:crypto';
import { promisify } from 'node:util';

const scrypt = promisify(scryptCb) as (
  password: string,
  salt: Buffer,
  keylen: number,
) => Promise<Buffer>;
const KEY_LENGTH = 64;

/** `scrypt$sal$clave` en base64url. La contraseña se normaliza NFKC antes de derivar. */
export async function hashPassword(password: string): Promise<string> {
  const salt = randomBytes(16);
  const key = await scrypt(password.normalize('NFKC'), salt, KEY_LENGTH);
  return ['scrypt', salt.toString('base64url'), key.toString('base64url')].join('$');
}

// Hash fijo para comparar cuando la cuenta no existe: así la respuesta tarda lo mismo.
const DUMMY = ['scrypt', 'A'.repeat(22), 'A'.repeat(86)].join('$');

/** Compara en tiempo constante. Con `hash` nulo compara contra un hash ficticio y devuelve false. */
export async function verifyPassword(
  password: string,
  hash: string | null | undefined,
): Promise<boolean> {
  const [scheme, saltText, keyText] = (hash ?? DUMMY).split('$');
  if (scheme !== 'scrypt' || !saltText || !keyText) return false;
  const expected = Buffer.from(keyText, 'base64url');
  const actual = await scrypt(
    password.normalize('NFKC'),
    Buffer.from(saltText, 'base64url'),
    KEY_LENGTH,
  );
  return Boolean(hash) && expected.length === actual.length && timingSafeEqual(expected, actual);
}
