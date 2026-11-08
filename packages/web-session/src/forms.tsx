'use client';

import { useActionState } from 'react';
import type { FormState } from './actions.ts';

type Action = (state: FormState, form: FormData) => Promise<FormState>;

export interface Field {
  name: string;
  label: string;
  type?: 'email' | 'password' | 'text';
  autoComplete?: string;
  inputMode?: 'numeric' | 'email' | 'text';
  /** Valor inicial (por ejemplo, el correo que viene en la URL). */
  value?: string;
  hidden?: boolean;
  minLength?: number;
  maxLength?: number;
  pattern?: string;
}

/**
 * Formulario de acceso con acción de servidor. Funciona sin JavaScript (envío normal); con
 * JavaScript muestra el error sin recargar y conserva lo escrito, salvo contraseñas y códigos.
 */
export function AuthForm({
  action,
  fields,
  submit,
}: {
  action: Action;
  fields: Field[];
  submit: string;
}) {
  const [state, formAction, pending] = useActionState(action, {});
  return (
    <form action={formAction} className="fd-form" noValidate={false}>
      {state.error ? (
        <p className="fd-form-error" role="alert">
          {state.error}
        </p>
      ) : null}
      {fields.map((f) =>
        f.hidden ? (
          <input key={f.name} type="hidden" name={f.name} value={f.value ?? ''} />
        ) : (
          <label key={f.name} className="fd-field">
            <span>{f.label}</span>
            <input
              name={f.name}
              type={f.type ?? 'text'}
              autoComplete={f.autoComplete}
              inputMode={f.inputMode}
              defaultValue={state.values?.[f.name] ?? f.value}
              minLength={f.minLength}
              maxLength={f.maxLength}
              pattern={f.pattern}
              required
            />
          </label>
        ),
      )}
      <button type="submit" className="fd-button" disabled={pending}>
        {pending ? 'Un momento…' : submit}
      </button>
    </form>
  );
}
