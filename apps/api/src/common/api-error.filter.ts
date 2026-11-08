import {
  type ArgumentsHost,
  Catch,
  type ExceptionFilter,
  HttpException,
  HttpStatus,
  Logger,
} from '@nestjs/common';
import { codeForStatus, type ApiError } from '@fulldays/shared';
import type { Response } from 'express';
import { ApiException } from './api-exception.ts';

/** Textos fijos por estado: los mensajes del framework y de librerías nunca se reenvían. */
const MESSAGES: Record<number, string> = {
  400: 'La petición no es válida.',
  401: 'Inicia sesión para continuar.',
  403: 'No tienes permiso para esto.',
  404: 'No encontrado.',
  409: 'La acción no se puede completar.',
  413: 'El contenido es demasiado grande.',
  429: 'Demasiados intentos. Espera un momento.',
};

/** Convierte cualquier error en la forma única `{ statusCode, code, message, issues? }`. */
@Catch()
export class ApiErrorFilter implements ExceptionFilter {
  private readonly logger = new Logger('ApiError');

  catch(exception: unknown, host: ArgumentsHost): void {
    const response = host.switchToHttp().getResponse<Response>();
    const body = toApiError(exception);
    if (body.statusCode >= 500) this.logger.error(exception);
    response.status(body.statusCode).json(body);
  }
}

export function toApiError(exception: unknown): ApiError {
  if (exception instanceof ApiException) {
    return {
      statusCode: exception.getStatus(),
      code: exception.code,
      message: exception.message,
      ...(exception.extra.issues ? { issues: exception.extra.issues } : {}),
    };
  }
  const prisma = prismaError(exception);
  if (prisma) return prisma;
  if (exception instanceof HttpException) {
    const status = exception.getStatus();
    if (status < 500) {
      return {
        statusCode: status,
        code: codeForStatus(status),
        message: MESSAGES[status] ?? MESSAGES[400]!,
      };
    }
  }
  return {
    statusCode: HttpStatus.INTERNAL_SERVER_ERROR,
    code: 'internal_error',
    message: 'Algo salió mal. Inténtalo de nuevo.',
  };
}

/**
 * Errores de la base que se explican a la persona: clave repetida o referencia a algo que
 * no existe (409) y registro inexistente (404). Los demás quedan como 500.
 */
function prismaError(exception: unknown): ApiError | null {
  const code = (exception as { code?: unknown } | null)?.code;
  const isPrisma =
    (exception as { name?: string } | null)?.name === 'PrismaClientKnownRequestError';
  if (!isPrisma || typeof code !== 'string') return null;
  if (code === 'P2002')
    return { statusCode: 409, code: 'conflict', message: 'Ya existe un registro con esos datos.' };
  if (code === 'P2003') {
    return {
      statusCode: 409,
      code: 'conflict',
      message: 'Otro registro depende de este o hace referencia a algo que no existe.',
    };
  }
  if (code === 'P2025') return { statusCode: 404, code: 'not_found', message: MESSAGES[404]! };
  return null;
}
