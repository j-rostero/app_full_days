import 'server-only';
import { revalidatePath } from 'next/cache';

/** Resultado de una acción de servidor que un formulario muestra. */
export interface ActionState {
  ok?: string;
  error?: string;
  /** Mensajes por campo, con la ruta unida por puntos (`sheet.general.title`). */
  fields?: Record<string, string>;
  /** Datos que la acción devuelve al componente (por ejemplo, la ficha guardada). */
  data?: unknown;
}

interface ApiErrorBody {
  message?: string;
  issues?: { path: string[]; message: string }[];
}

const UNREACHABLE = 'No pudimos conectar. Revisa tu conexión e inténtalo de nuevo.';

/** Convierte el error de la API en un estado de formulario. */
export function failure(error: unknown): { error: string; fields?: Record<string, string> } {
  const body = error as ApiErrorBody | undefined;
  const fields = Object.fromEntries((body?.issues ?? []).map((i) => [i.path.join('.'), i.message]));
  return {
    error: body?.issues?.[0]?.message ?? body?.message ?? UNREACHABLE,
    ...(body?.issues?.length ? { fields } : {}),
  };
}

/**
 * Corre una llamada a la API desde una acción de servidor: si responde bien, revalida las
 * rutas dadas y devuelve `ok`; si no, el mensaje de la API.
 */
export async function act<T>(
  call: () => Promise<{ data?: T; error?: unknown; response: Response }>,
  options: { ok?: string; revalidate?: string[] } = {},
): Promise<ActionState & { data?: T }> {
  try {
    const { data, error, response } = await call();
    if (!response.ok) return failure(error);
    for (const path of options.revalidate ?? []) revalidatePath(path, 'layout');
    return { ok: options.ok ?? 'Listo.', data };
  } catch {
    return { error: UNREACHABLE };
  }
}

/** Texto de un campo de formulario (vacío si no vino). */
export function text(form: FormData, name: string): string {
  const value = form.get(name);
  return typeof value === 'string' ? value.trim() : '';
}

/** Texto o `null` si quedó vacío. */
export function optional(form: FormData, name: string): string | null {
  return text(form, name) || null;
}

/** Número o `null` si quedó vacío. */
export function numberOrNull(form: FormData, name: string): number | null {
  const value = text(form, name).replace(',', '.');
  return value === '' ? null : Number(value);
}
