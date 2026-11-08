/** Nombres y opciones de las cookies de sesión. Las dos son `httpOnly`: el navegador nunca ve los tokens. */
export const ACCESS_COOKIE = 'fd_acceso';
export const REFRESH_COOKIE = 'fd_renovacion';

/** Días que vive la cookie de renovación; la API decide la vigencia real del token. */
const REFRESH_DAYS = 60;

export interface Tokens {
  accessToken: string;
  refreshToken: string;
  expiresIn: number;
}

export interface CookieSpec {
  name: string;
  value: string;
  httpOnly: true;
  sameSite: 'lax';
  secure: boolean;
  path: '/';
  maxAge: number;
}

/** Cookies a fijar tras entrar o renovar. El acceso vence unos segundos antes que su token. */
export function sessionCookies(
  tokens: Tokens,
  secure = process.env.NODE_ENV === 'production',
): CookieSpec[] {
  const base = { httpOnly: true, sameSite: 'lax', secure, path: '/' } as const;
  return [
    {
      ...base,
      name: ACCESS_COOKIE,
      value: tokens.accessToken,
      maxAge: Math.max(tokens.expiresIn - 30, 1),
    },
    { ...base, name: REFRESH_COOKIE, value: tokens.refreshToken, maxAge: REFRESH_DAYS * 86_400 },
  ];
}

/** Solo rutas internas: evita que `?siguiente=https://otro.sitio` saque a la persona de la web. */
export function safeNext(value: unknown, fallback = '/'): string {
  return typeof value === 'string' && /^\/(?![/\\])/.test(value) ? value : fallback;
}
