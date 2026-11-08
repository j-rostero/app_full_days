'use client';

import { confirmFile, declareFile } from './files.ts';

/**
 * Sube un archivo en tres pasos: la API lo declara y firma la subida, el navegador lo envía
 * directo al almacenamiento y la API confirma que llegó lo declarado. Devuelve su id.
 */
export async function uploadFile(file: File, kind: 'image' | 'document'): Promise<string> {
  const declared = await declareFile(kind, file.type, file.size);
  if (!declared.fileId || !declared.url)
    throw new Error(declared.error ?? 'No pudimos preparar la subida.');
  const put = await fetch(declared.url, { method: 'PUT', headers: declared.headers, body: file });
  if (!put.ok) throw new Error('No pudimos subir el archivo. Inténtalo de nuevo.');
  const confirmed = await confirmFile(declared.fileId);
  if (confirmed.error) throw new Error(confirmed.error);
  return declared.fileId;
}
