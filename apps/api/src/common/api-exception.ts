import { HttpException } from '@nestjs/common';
import type { ApiErrorCode, ApiIssue } from '@fulldays/shared';

/** Excepción con código estable. Es la forma preferida de responder un error desde un módulo. */
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
