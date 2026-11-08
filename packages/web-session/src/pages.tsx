import Link from 'next/link';
import { redirect } from 'next/navigation';
import {
  recoverAction,
  registerAction,
  resetAction,
  signInAction,
  verifyAction,
} from './actions.ts';
import { safeNext } from './cookies.ts';
import { AuthForm } from './forms.tsx';
import { getMe } from './session.ts';

type Search = Promise<Record<string, string | string[] | undefined>>;
type PageProps = { searchParams: Search };

const one = (value: string | string[] | undefined) =>
  (Array.isArray(value) ? value[0] : value) ?? '';

const EMAIL = {
  name: 'email',
  label: 'Correo',
  type: 'email',
  autoComplete: 'email',
  inputMode: 'email',
} as const;
const CODE = {
  name: 'code',
  label: 'Código de 6 dígitos',
  inputMode: 'numeric',
  autoComplete: 'one-time-code',
  pattern: '\\d{6}',
  maxLength: 6,
} as const;
const newPassword = (label: string) =>
  ({
    name: 'password',
    label,
    type: 'password',
    autoComplete: 'new-password',
    minLength: 8,
    maxLength: 128,
  }) as const;
const CONFIRM = {
  name: 'confirmar',
  label: 'Repite la contraseña',
  type: 'password',
  autoComplete: 'new-password',
  minLength: 8,
  maxLength: 128,
} as const;

export interface AccessOptions {
  /** Central no admite registro abierto: sus cuentas las crea un super. */
  allowRegister: boolean;
}

/** Páginas de acceso de una web. Cada web las monta en sus rutas `/entrar`, `/registrar`, etc. */
export function accessPages({ allowRegister }: AccessOptions) {
  async function SignInPage({ searchParams }: PageProps) {
    const params = await searchParams;
    const next = safeNext(one(params.siguiente));
    if (await getMe()) redirect(next);
    return (
      <main>
        <h1>Entrar</h1>
        <AuthForm
          action={signInAction}
          submit="Entrar"
          fields={[
            { ...EMAIL, value: one(params.correo) },
            {
              name: 'password',
              label: 'Contraseña',
              type: 'password',
              autoComplete: 'current-password',
            },
            { name: 'siguiente', label: '', hidden: true, value: next },
          ]}
        />
        <p className="fd-links">
          <Link href="/recuperar">Olvidé mi contraseña</Link>
          {allowRegister ? <Link href="/registrar">Crear una cuenta</Link> : null}
        </p>
      </main>
    );
  }

  async function RegisterPage() {
    if (!allowRegister) redirect('/entrar');
    if (await getMe()) redirect('/');
    return (
      <main>
        <h1>Crear una cuenta</h1>
        <p className="suave">Te enviaremos un código para confirmar tu correo.</p>
        <AuthForm
          action={registerAction}
          submit="Crear cuenta"
          fields={[EMAIL, newPassword('Contraseña (mínimo 8 caracteres)'), CONFIRM]}
        />
        <p className="fd-links">
          <Link href="/entrar">Ya tengo cuenta</Link>
        </p>
      </main>
    );
  }

  async function VerifyPage({ searchParams }: PageProps) {
    const email = one((await searchParams).correo);
    return (
      <main>
        <h1>Confirma tu correo</h1>
        <p className="suave">
          {email
            ? `Escribe el código que enviamos a ${email}.`
            : 'Escribe el código que te enviamos.'}{' '}
          Vence en 5 minutos.
        </p>
        <AuthForm
          action={verifyAction}
          submit="Confirmar"
          fields={email ? [{ ...EMAIL, hidden: true, value: email }, CODE] : [EMAIL, CODE]}
        />
        <p className="fd-links">
          <Link href={`/entrar${email ? `?correo=${encodeURIComponent(email)}` : ''}`}>
            ¿No llegó? Entra de nuevo para recibir otro
          </Link>
        </p>
      </main>
    );
  }

  async function RecoverPage() {
    return (
      <main>
        <h1>Recuperar contraseña</h1>
        <p className="suave">Si hay una cuenta con ese correo, te enviaremos un código.</p>
        <AuthForm action={recoverAction} submit="Enviar código" fields={[EMAIL]} />
        <p className="fd-links">
          <Link href="/entrar">Volver a entrar</Link>
        </p>
      </main>
    );
  }

  async function ResetPage({ searchParams }: PageProps) {
    const email = one((await searchParams).correo);
    return (
      <main>
        <h1>Elige una contraseña nueva</h1>
        <p className="suave">Al cambiarla se cierran tus sesiones en otros dispositivos.</p>
        <AuthForm
          action={resetAction}
          submit="Guardar y entrar"
          fields={[
            email ? { ...EMAIL, hidden: true, value: email } : EMAIL,
            CODE,
            newPassword('Contraseña nueva'),
            CONFIRM,
          ]}
        />
      </main>
    );
  }

  return { SignInPage, RegisterPage, VerifyPage, RecoverPage, ResetPage };
}
