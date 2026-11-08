import { createHmac } from 'node:crypto';
import {
  DeleteObjectCommand,
  GetObjectCommand,
  HeadObjectCommand,
  PutObjectCommand,
  S3Client,
  CreateBucketCommand,
  PutBucketCorsCommand,
  HeadBucketCommand,
} from '@aws-sdk/client-s3';
import { getSignedUrl } from '@aws-sdk/s3-request-presigner';
import type { Config } from '../config.ts';

export const STORAGE = Symbol('STORAGE');

export type Bucket = 'images' | 'documents';

/** Tamaños de imagen permitidos (ancho × alto, recorte centrado). */
export const IMAGE_SIZES = {
  sm: [320, 240],
  md: [640, 480],
  lg: [1280, 960],
  xl: [1920, 1440],
} as const;
export type ImageSize = keyof typeof IMAGE_SIZES;

export interface StoredObject {
  size: number;
  contentType: string;
}

/** Almacenamiento de archivos. La API nunca recibe los bytes: firma URLs y comprueba lo subido. */
export interface Storage {
  /** URL `PUT` firmada por diez minutos; tipo y tamaño forman parte de la firma. */
  uploadUrl(bucket: Bucket, key: string, contentType: string, size: number): Promise<string>;
  head(bucket: Bucket, key: string): Promise<StoredObject | null>;
  /** Descarga de un documento privado, cinco minutos. */
  downloadUrl(bucket: Bucket, key: string, filename: string): Promise<string>;
  delete(bucket: Bucket, key: string): Promise<void>;
  /** URL de imgproxy firmada para una imagen del depósito de imágenes. */
  imageUrl(key: string, size: ImageSize): string;
  /** Crea los depósitos y su CORS (solo local y pruebas). */
  ensureBuckets(origins: string[]): Promise<void>;
}

const UPLOAD_SECONDS = 600;
const DOWNLOAD_SECONDS = 300;

export class S3Storage implements Storage {
  private readonly client: S3Client;
  private readonly publicClient: S3Client;

  constructor(private readonly config: Config) {
    const base = {
      region: config.S3_REGION,
      forcePathStyle: true,
      credentials: { accessKeyId: config.S3_ACCESS_KEY, secretAccessKey: config.S3_SECRET_KEY },
    };
    this.client = new S3Client({ ...base, endpoint: config.S3_ENDPOINT });
    this.publicClient = new S3Client({
      ...base,
      endpoint: config.S3_PUBLIC_ENDPOINT ?? config.S3_ENDPOINT,
    });
  }

  private name(bucket: Bucket): string {
    return bucket === 'images' ? this.config.S3_BUCKET_IMAGES : this.config.S3_BUCKET_DOCUMENTS;
  }

  uploadUrl(bucket: Bucket, key: string, contentType: string, size: number): Promise<string> {
    const command = new PutObjectCommand({
      Bucket: this.name(bucket),
      Key: key,
      ContentType: contentType,
      ContentLength: size,
    });
    return getSignedUrl(this.publicClient, command, {
      expiresIn: UPLOAD_SECONDS,
      signableHeaders: new Set(['content-type', 'content-length']),
    });
  }

  async head(bucket: Bucket, key: string): Promise<StoredObject | null> {
    try {
      const res = await this.client.send(
        new HeadObjectCommand({ Bucket: this.name(bucket), Key: key }),
      );
      return { size: res.ContentLength ?? 0, contentType: res.ContentType ?? '' };
    } catch {
      return null;
    }
  }

  downloadUrl(bucket: Bucket, key: string, filename: string): Promise<string> {
    const command = new GetObjectCommand({
      Bucket: this.name(bucket),
      Key: key,
      ResponseContentDisposition: `attachment; filename="${filename.replace(/[^\w.-]/g, '_')}"`,
    });
    return getSignedUrl(this.publicClient, command, { expiresIn: DOWNLOAD_SECONDS });
  }

  async delete(bucket: Bucket, key: string): Promise<void> {
    await this.client.send(new DeleteObjectCommand({ Bucket: this.name(bucket), Key: key }));
  }

  imageUrl(key: string, size: ImageSize): string {
    return signedImgproxyUrl(this.config, `s3://${this.config.S3_BUCKET_IMAGES}/${key}`, size);
  }

  async ensureBuckets(origins: string[]): Promise<void> {
    for (const bucket of ['images', 'documents'] as const) {
      const Bucket = this.name(bucket);
      try {
        await this.client.send(new HeadBucketCommand({ Bucket }));
      } catch {
        await this.client.send(new CreateBucketCommand({ Bucket }));
      }
      if (origins.length === 0) continue;
      await this.client.send(
        new PutBucketCorsCommand({
          Bucket,
          CORSConfiguration: {
            CORSRules: [
              {
                AllowedOrigins: origins,
                AllowedMethods: ['PUT', 'GET'],
                AllowedHeaders: ['*'],
                MaxAgeSeconds: 3600,
              },
            ],
          },
        }),
      );
    }
  }
}

/** imgproxy: `/<firma>/rs:fill:<ancho>:<alto>/g:ce/plain/<origen>@webp`, firmado con HMAC-SHA256(clave, sal + ruta). */
export function signedImgproxyUrl(
  config: Pick<Config, 'IMGPROXY_URL' | 'IMGPROXY_KEY' | 'IMGPROXY_SALT'>,
  source: string,
  size: ImageSize,
): string {
  const [width, height] = IMAGE_SIZES[size];
  const path = `/rs:fill:${width}:${height}/g:ce/plain/${encodeURI(source)}@webp`;
  const signature = createHmac('sha256', Buffer.from(config.IMGPROXY_KEY, 'hex'))
    .update(Buffer.from(config.IMGPROXY_SALT, 'hex'))
    .update(path)
    .digest('base64url');
  return `${config.IMGPROXY_URL.replace(/\/$/, '')}/${signature}${path}`;
}

/** Almacenamiento en memoria para las pruebas: `put` simula la subida del cliente. */
export class MemoryStorage implements Storage {
  readonly objects = new Map<string, StoredObject>();

  constructor(private readonly config: Config) {}

  put(bucket: Bucket, key: string, object: StoredObject): void {
    this.objects.set(`${bucket}/${key}`, object);
  }

  async uploadUrl(bucket: Bucket, key: string): Promise<string> {
    return `memory://${bucket}/${key}`;
  }

  async head(bucket: Bucket, key: string): Promise<StoredObject | null> {
    return this.objects.get(`${bucket}/${key}`) ?? null;
  }

  async downloadUrl(bucket: Bucket, key: string): Promise<string> {
    return `memory://${bucket}/${key}?descarga`;
  }

  async delete(bucket: Bucket, key: string): Promise<void> {
    this.objects.delete(`${bucket}/${key}`);
  }

  imageUrl(key: string, size: ImageSize): string {
    return signedImgproxyUrl(this.config, `s3://${this.config.S3_BUCKET_IMAGES}/${key}`, size);
  }

  async ensureBuckets(): Promise<void> {}
}
