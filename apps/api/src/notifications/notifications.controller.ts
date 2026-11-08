import { Body, Controller, Get, HttpCode, Inject, Post, Put } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import { z } from 'zod';
import { Endpoint } from '../common/endpoint.ts';
import { Auth, type AuthContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';

const TAG = ['notificaciones'];

export const InboxSchema = z
  .object({
    unread: z.number().int(),
    items: z.array(
      z.object({
        id: z.uuid(),
        event: z.string(),
        title: z.string(),
        body: z.string(),
        link: z.string().nullable(),
        read: z.boolean(),
        createdAt: z.iso.datetime(),
      }),
    ),
  })
  .meta({ id: 'Inbox' });
export const MarkReadInput = z
  .strictObject({ ids: z.array(z.uuid()).max(200).optional() })
  .meta({ id: 'MarkReadInput' });
export const DeviceInput = z
  .strictObject({ token: z.string().min(20).max(4096), platform: z.enum(['android', 'ios']) })
  .meta({ id: 'DeviceInput' });
export const ForgetDeviceInput = z
  .strictObject({ token: z.string().min(20).max(4096) })
  .meta({ id: 'ForgetDeviceInput' });

/** Bandeja de notificaciones y teléfonos que reciben push. */
@Controller('yo')
export class NotificationsController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get('notificaciones')
  @Endpoint({
    operationId: 'getInbox',
    summary: 'Las últimas 50 notificaciones y cuántas faltan por leer',
    tags: TAG,
    responses: { 200: InboxSchema },
  })
  async inbox(@Auth() auth: AuthContext): Promise<z.infer<typeof InboxSchema>> {
    const where = { userId: auth.userId, channel: 'push' as const };
    const [rows, unread] = await Promise.all([
      this.db.notification.findMany({ where, orderBy: { createdAt: 'desc' }, take: 50 }),
      this.db.notification.count({ where: { ...where, readAt: null } }),
    ]);
    return {
      unread,
      items: rows.map((n) => ({
        id: n.id,
        event: n.event,
        title: n.title,
        body: n.body,
        link: n.link,
        read: n.readAt !== null,
        createdAt: n.createdAt.toISOString(),
      })),
    };
  }

  @Post('notificaciones/leidas')
  @HttpCode(204)
  @Endpoint({
    operationId: 'markInboxRead',
    summary: 'Marca como leídas las indicadas, o todas si no se indica ninguna',
    tags: TAG,
    body: MarkReadInput,
    responses: { 204: null },
  })
  async read(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(MarkReadInput)) input: z.infer<typeof MarkReadInput>,
  ): Promise<void> {
    await this.db.notification.updateMany({
      where: {
        userId: auth.userId,
        channel: 'push',
        readAt: null,
        ...(input.ids ? { id: { in: input.ids } } : {}),
      },
      data: { readAt: new Date() },
    });
  }

  @Put('dispositivos')
  @HttpCode(204)
  @Endpoint({
    operationId: 'registerDevice',
    summary: 'Registra el token de push de este teléfono (pasa a la cuenta actual si era de otra)',
    tags: TAG,
    body: DeviceInput,
    responses: { 204: null },
  })
  async register(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(DeviceInput)) input: z.infer<typeof DeviceInput>,
  ): Promise<void> {
    await this.db.deviceToken.upsert({
      where: { token: input.token },
      create: { userId: auth.userId, token: input.token, platform: input.platform },
      update: { userId: auth.userId, platform: input.platform },
    });
  }

  @Post('dispositivos/quitar')
  @HttpCode(204)
  @Endpoint({
    operationId: 'forgetDevice',
    summary: 'Deja de enviar push a este teléfono (al cerrar sesión)',
    tags: TAG,
    body: ForgetDeviceInput,
    responses: { 204: null },
  })
  async forget(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(ForgetDeviceInput)) input: z.infer<typeof ForgetDeviceInput>,
  ): Promise<void> {
    await this.db.deviceToken.deleteMany({ where: { userId: auth.userId, token: input.token } });
  }
}
