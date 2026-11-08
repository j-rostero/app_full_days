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
