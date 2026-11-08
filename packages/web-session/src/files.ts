'use server';

import { sessionApi } from '@fulldays/web-session';

export interface Declared {
  error?: string;
  fileId?: string;
  url?: string;
  headers?: Record<string, string>;
}

/** Declara un archivo y devuelve la URL firmada para subirlo directo al almacenamiento. */
export async function declareFile(
  kind: 'image' | 'document',
  contentType: string,
  size: number,
): Promise<Declared> {
  const { data, error } = await (
    await sessionApi()
  ).POST('/v1/archivos', { body: { kind, contentType, size } });
  if (!data)
    return {
      error:
        (error as { message?: string; issues?: { message: string }[] })?.issues?.[0]?.message ??
        'No pudimos preparar la subida.',
    };
  return { fileId: data.file.id, url: data.upload.url, headers: data.upload.headers };
}

export async function confirmFile(fileId: string): Promise<{ error?: string }> {
  const { error, response } = await (
    await sessionApi()
  ).POST('/v1/archivos/{fileId}/confirmar', { params: { path: { fileId } } });
  return response.ok
    ? {}
    : { error: (error as { message?: string })?.message ?? 'No pudimos confirmar el archivo.' };
}
