import { signOutAction } from './actions.ts';

/** Botón para salir. Es un formulario: funciona sin JavaScript. */
export function SignOutButton() {
  return (
    <form action={signOutAction}>
      <button type="submit" className="fd-button fd-button-secundario">
        Salir
      </button>
    </form>
  );
}
