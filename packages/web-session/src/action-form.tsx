'use client';

import { type ReactNode, useActionState } from 'react';
import { useFormStatus } from 'react-dom';
import type { ActionState } from './act.ts';

type Action = (state: ActionState, form: FormData) => Promise<ActionState>;

/** Formulario de una acción de servidor con su mensaje de error o de éxito. */
export function ActionForm({
  action,
  children,
  submit,
  className,
  submitClassName,
  confirm,
}: {
  action: Action;
  children?: ReactNode;
  submit: string;
  className?: string;
  submitClassName?: string;
  /** Pregunta antes de enviar (acciones que no se deshacen fácil). */
  confirm?: string;
}) {
  const [state, formAction] = useActionState(action, {});
  return (
    <form
      action={formAction}
      className={className ?? 'fd-form'}
      onSubmit={(event) => {
        if (confirm && !window.confirm(confirm)) event.preventDefault();
      }}
    >
      {state.error ? (
        <p className="fd-form-error" role="alert">
          {state.error}
        </p>
      ) : null}
      {state.ok ? (
        <p className="fd-form-ok" role="status">
          {state.ok}
        </p>
      ) : null}
      {children}
      <Submit label={submit} className={submitClassName} />
    </form>
  );
}

export function Submit({ label, className }: { label: string; className?: string }) {
  const { pending } = useFormStatus();
  return (
    <button type="submit" className={className ?? 'fd-button'} disabled={pending}>
      {pending ? 'Un momento…' : label}
    </button>
  );
}
