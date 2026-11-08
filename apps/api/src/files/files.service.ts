import { Inject, Injectable } from '@nestjs/common';
import type { File, PrismaClient } from '@fulldays/db';
import { ApiException, conflict, notFound } from '../common/api-exception.ts';
import { DB } from '../common/tokens.ts';
import type { FileView, ImageUrls } from './files.schemas.ts';
import { type Bucket, IMAGE_SIZES, type ImageSize, STORAGE, type Storage } from './storage.ts';

const EXTENSIONS: Record<string, string> = {
  'image/jpeg': 'jpg',
  'image/png': 'png',
  'image/webp': 'webp',
  'application/pdf': 'pdf',
};

export const bucketOf = (file: Pick<File, 'kind'>): Bucket =>
  file.kind === 'image' ? 'images' : 'documents';

/** Archivos: declaración, confirmación y cómo otros módulos los adjuntan y los muestran. */
@Injectable()
export class FilesService {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(STORAGE) readonly storage: Storage,
  ) {}

  async declare(
    uploaderId: string,
    input: { kind: 'image' | 'document'; contentType: string; size: number },
  ) {
    const key = `${crypto.randomUUID()}.${EXTENSIONS[input.contentType]}`;
    const file = await this.db.file.create({ data: { uploaderId, ...input, key } });
    const url = await this.storage.uploadUrl(bucketOf(file), key, input.contentType, input.size);
    return {
      file: await this.view(file),
      upload: { url, method: 'PUT' as const, headers: { 'Content-Type': input.contentType } },
    };
  }

  /** Comprueba que lo subido es lo declarado. Si no, borra objeto y fila. */
  async confirm(uploaderId: string, fileId: string): Promise<FileView> {
    const file = await this.own(uploaderId, fileId);
    if (file.status === 'ready') return this.view(file);
    const stored = await this.storage.head(bucketOf(file), file.key);
    if (!stored) throw conflict('Todavía no recibimos el archivo. Súbelo y vuelve a confirmar.');
    if (stored.size !== file.size || stored.contentType !== file.contentType) {
      await this.storage.delete(bucketOf(file), file.key);
      await this.db.file.delete({ where: { id: file.id } });
      throw conflict('El archivo subido no coincide con lo declarado. Vuelve a subirlo.');
    }
    return this.view(
      await this.db.file.update({ where: { id: file.id }, data: { status: 'ready' } }),
    );
  }

  async own(uploaderId: string, fileId: string): Promise<File> {
    const file = await this.db.file.findFirst({ where: { id: fileId, uploaderId } });
    if (!file) throw notFound();
    return file;
  }

  /**
   * Archivos listos de un tipo, subidos por alguna de estas personas. Un id que no cumple
   * responde 400 con el campo indicado.
   */
  async requireReady(
    ids: string[],
    kind: 'image' | 'document',
    uploaderIds: string[],
    field: string[],
  ): Promise<File[]> {
    if (ids.length === 0) return [];
    const files = await this.db.file.findMany({
      where: { id: { in: ids }, kind, status: 'ready', uploaderId: { in: uploaderIds } },
    });
    if (files.length !== new Set(ids).size) {
      throw new ApiException(400, 'validation_error', 'Revisa los datos.', {
        issues: [
          {
            path: field,
            message:
              kind === 'image'
                ? 'Hay fotos que no existen o no son de tu equipo.'
                : 'El archivo no existe o no es tuyo.',
          },
        ],
      });
    }
    return files;
  }

  imageUrls(key: string): ImageUrls {
    const out = {} as ImageUrls;
    for (const size of Object.keys(IMAGE_SIZES) as ImageSize[])
      out[size] = this.storage.imageUrl(key, size);
    return out;
  }

  /** Imágenes por id, en el orden dado; las que ya no existen se omiten. */
  async images(ids: string[]): Promise<{ id: string; urls: ImageUrls }[]> {
    if (ids.length === 0) return [];
    const files = await this.db.file.findMany({
      where: { id: { in: ids }, kind: 'image', status: 'ready' },
    });
    const byId = new Map(files.map((f) => [f.id, f]));
    return ids.flatMap((id) => {
      const file = byId.get(id);
      return file ? [{ id, urls: this.imageUrls(file.key) }] : [];
    });
  }

  async view(file: File): Promise<FileView> {
    const ready = file.status === 'ready';
    return {
      id: file.id,
      kind: file.kind,
      contentType: file.contentType,
      size: file.size,
      status: file.status,
      image: ready && file.kind === 'image' ? this.imageUrls(file.key) : null,
      downloadUrl:
        ready && file.kind === 'document'
          ? await this.storage.downloadUrl('documents', file.key, file.key)
          : null,
    };
  }
}
