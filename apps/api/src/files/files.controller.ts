import { Body, Controller, Get, HttpCode, Param, Post, Inject } from '@nestjs/common';
import type { z } from 'zod';
import { notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Auth, type AuthContext } from '../common/request.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  DeclaredFileSchema,
  DeclareFileInput,
  FileSchema,
  type FileView,
} from './files.schemas.ts';
import { FilesService } from './files.service.ts';

const TAG = ['archivos'];

/** Subida en tres pasos: declarar, subir directo al almacenamiento con la URL firmada y confirmar. */
@Controller('archivos')
export class FilesController {
  constructor(@Inject(FilesService) private readonly files: FilesService) {}

  @Post()
  @HttpCode(201)
  @Endpoint({
    operationId: 'declareFile',
    summary: 'Declara un archivo y devuelve la URL firmada para subirlo (diez minutos)',
    tags: TAG,
    body: DeclareFileInput,
    responses: { 201: DeclaredFileSchema },
  })
  declare(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(DeclareFileInput)) input: z.infer<typeof DeclareFileInput>,
  ) {
    return this.files.declare(auth.userId, input);
  }

  @Post(':fileId/confirmar')
  @HttpCode(200)
  @Endpoint({
    operationId: 'confirmFile',
    summary: 'Comprueba que lo subido coincide con lo declarado y deja el archivo listo',
    tags: TAG,
    responses: { 200: FileSchema },
  })
  confirm(@Auth() auth: AuthContext, @Param('fileId') fileId: string): Promise<FileView> {
    if (!isUuid(fileId)) throw notFound();
    return this.files.confirm(auth.userId, fileId);
  }

  @Get(':fileId')
  @Endpoint({
    operationId: 'getFile',
    summary: 'Un archivo propio; los documentos traen un enlace de descarga de cinco minutos',
    tags: TAG,
    responses: { 200: FileSchema },
  })
  async get(@Auth() auth: AuthContext, @Param('fileId') fileId: string): Promise<FileView> {
    if (!isUuid(fileId)) throw notFound();
    return this.files.view(await this.files.own(auth.userId, fileId));
  }
}
