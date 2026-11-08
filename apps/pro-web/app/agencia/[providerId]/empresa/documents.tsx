'use client';

import { useState, useTransition } from 'react';
import { PROVIDER_DOCUMENT_LABELS, type ProviderDocumentType } from '@fulldays/shared';
import { uploadFile } from '@fulldays/web-session/upload';
import { attachDocument, removeDocument, submitCompany } from './actions';

interface Doc {
  id: string;
  type: ProviderDocumentType;
  downloadUrl: string;
}

/** Documentos de verificación: subir, ver, quitar y enviar a Central. */
export function Documents({
  providerId,
  documents,
  locked,
  canSubmit,
}: {
  providerId: string;
  documents: Doc[];
  locked: boolean;
  canSubmit: boolean;
}) {
  const [type, setType] = useState<ProviderDocumentType>('rif');
  const [message, setMessage] = useState<{ error?: string; ok?: string }>({});
  const [pending, start] = useTransition();

  const run = (task: () => Promise<{ error?: string; ok?: string }>) =>
    start(async () => {
      try {
        setMessage(await task());
      } catch (error) {
        setMessage({ error: (error as Error).message });
      }
    });

  return (
    <section className="tarjeta">
      <h2>Documentos de verificación</h2>
      {message.error ? (
        <p className="fd-form-error" role="alert">
          {message.error}
        </p>
      ) : null}
      {message.ok ? (
        <p className="fd-form-ok" role="status">
          {message.ok}
        </p>
      ) : null}
      {documents.length === 0 ? <p className="suave">Aún no has subido documentos.</p> : null}
      <ul>
        {documents.map((d) => (
          <li key={d.id}>
            <a href={d.downloadUrl}>{PROVIDER_DOCUMENT_LABELS[d.type]}</a>{' '}
            {locked ? null : (
              <button
                type="button"
                className="fd-link-button"
                disabled={pending}
                onClick={() => run(() => removeDocument(providerId, d.id))}
              >
                Quitar
              </button>
            )}
          </li>
        ))}
      </ul>
      {locked ? (
        <p className="suave">Mientras Central revisa tu agencia no puedes cambiar documentos.</p>
      ) : (
        <div className="fd-inline">
          <label className="fd-field">
            <span>Tipo de documento</span>
            <select value={type} onChange={(e) => setType(e.target.value as ProviderDocumentType)}>
              {Object.entries(PROVIDER_DOCUMENT_LABELS).map(([value, label]) => (
                <option key={value} value={value}>
                  {label}
                </option>
              ))}
            </select>
          </label>
          <label className="fd-field">
            <span>Archivo (PDF, JPG o PNG, hasta 10 MB)</span>
            <input
              type="file"
              accept="application/pdf,image/jpeg,image/png"
              disabled={pending}
              onChange={(e) => {
                const file = e.target.files?.[0];
                e.target.value = '';
                if (file)
                  run(async () =>
                    attachDocument(providerId, type, await uploadFile(file, 'document')),
                  );
              }}
            />
          </label>
        </div>
      )}
      {canSubmit ? (
        <p>
          <button
            type="button"
            className="fd-button"
            disabled={pending}
            onClick={() => run(() => submitCompany(providerId))}
          >
            Enviar a verificación
          </button>
        </p>
      ) : null}
    </section>
  );
}
