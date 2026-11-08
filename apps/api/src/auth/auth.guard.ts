import { type CanActivate, type ExecutionContext, Inject, Injectable } from '@nestjs/common';
import { Reflector } from '@nestjs/core';
import { unauthorized } from '../common/api-exception.ts';
import { PUBLIC_METADATA } from '../common/endpoint.ts';
import type { ApiRequest } from '../common/request.ts';
import { SessionService } from './session.service.ts';
import { TokenService } from './token.service.ts';

/**
 * Cerrado por defecto: todo endpoint exige `Authorization: Bearer <token>` salvo los
 * marcados `@Public()`. Comprueba la firma, la vigencia y que la sesión no esté revocada.
 */
@Injectable()
export class AuthGuard implements CanActivate {
  constructor(
    private readonly reflector: Reflector,
    @Inject(TokenService) private readonly tokens: TokenService,
    @Inject(SessionService) private readonly sessions: SessionService,
  ) {}

  async canActivate(context: ExecutionContext): Promise<boolean> {
    const isPublic = this.reflector.getAllAndOverride<boolean>(PUBLIC_METADATA, [
      context.getHandler(),
      context.getClass(),
    ]);
    const request = context.switchToHttp().getRequest<ApiRequest>();
    const header = request.headers.authorization ?? '';
    const token = header.startsWith('Bearer ') ? header.slice(7).trim() : '';

    if (!token) {
      if (isPublic) return true;
      throw unauthorized();
    }
    const claims = await this.tokens.verifyAccess(token);
    if (!claims || (await this.sessions.isRevoked(claims.sessionId))) {
      // Un token vencido en un endpoint público no impide usarlo sin sesión.
      if (isPublic) return true;
      throw unauthorized('Tu sesión venció. Vuelve a entrar.');
    }
    request.auth = claims;
    return true;
  }
}
