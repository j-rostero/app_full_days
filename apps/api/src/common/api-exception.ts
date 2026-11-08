import { HttpException } from '@nestjs/common';
import type { ApiErrorCode, ApiIssue } from '@fulldays/shared';

/**
 * Excepción con código estable y un mensaje escrito para la persona usuaria, que se envía
 * tal cual. Es la forma de responder un error desde un módulo.
 */
export class ApiException extends HttpException {
  constructor(
    status: number,
    readonly code: ApiErrorCode,
    message: string,
    readonly extra: { issues?: ApiIssue[] } = {},
  ) {
    super(message, status);
  }
}

export const notFound = (message = 'No encontrado.') => new ApiException(404, 'not_found', message);
export const conflict = (message: string) => new ApiException(409, 'conflict', message);
export const forbidden = (message = 'No tienes permiso para esto.') =>
  new ApiException(403, 'forbidden', message);
export const unauthorized = (message = 'Inicia sesión para continuar.') =>
  new ApiException(401, 'unauthorized', message);
export const rateLimited = (message = 'Demasiados intentos. Espera un momento.') =>
  new ApiException(429, 'rate_limited', message);
