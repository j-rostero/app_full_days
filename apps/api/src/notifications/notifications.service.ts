import { Inject, Injectable, Logger } from '@nestjs/common';
import type { Notification, PrismaClient } from '@fulldays/db';
import {
  MAX_NOTIFICATION_ATTEMPTS,
  NOTIFICATION_EVENTS,
  type NotificationEvent,
  retryDelayMs,
} from '@fulldays/shared';
import { DB } from '../common/tokens.ts';
import { EMAIL_SENDER, type EmailSender, PUSH_SENDER, type PushSender } from './senders.ts';

export interface NotificationInput {
  userId: string;
  event: NotificationEvent;
  body: string;
  title?: string;
  /** Adónde lleva al tocarla, por ejemplo `reserva:<id>`. */
  link?: string | null;
  /** Mismo valor, mismo mensaje: no se encola dos veces. */
  dedupeKey?: string;
}

/** Cuánto se reserva una notificación tomada para enviarla antes de que otra instancia la reintente. */
const LEASE_MS = 5 * 60_000;

/**
 * Cola de mensajes a personas por push y correo. Encolar nunca falla por un proveedor lento:
 * la entrega la hace el worker después, con reintentos, y varias instancias se reparten la cola
 * sin repetir mensajes (`FOR UPDATE SKIP LOCKED` y una reserva de cinco minutos).
 */
@Injectable()
export class NotificationsService {
  private readonly log = new Logger('Notificaciones');

  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(PUSH_SENDER) private readonly push: PushSender,
    @Inject(EMAIL_SENDER) private readonly email: EmailSender,
  ) {}

  async enqueue(messages: NotificationInput[]): Promise<number> {
    if (messages.length === 0) return 0;
    const rows = messages.flatMap((m) =>
      (['push', 'email'] as const).map((channel) => ({
        userId: m.userId,
        event: m.event,
        title: m.title ?? NOTIFICATION_EVENTS[m.event],
        body: m.body,
        link: m.link ?? null,
        channel,
        dedupeKey: m.dedupeKey ?? null,
      })),
    );
    const { count } = await this.db.notification.createMany({ data: rows, skipDuplicates: true });
    return count;
  }

  /** Avisa a los dueños y a operaciones de una agencia (decisiones de Central). */
  async tellTeam(providerId: string, body: string, link: string | null = null): Promise<number> {
    const members = await this.db.providerMember.findMany({
      where: { providerId, role: { in: ['owner', 'operations'] } },
      select: { userId: true },
    });
    return this.enqueue(
      members.map((m) => ({ userId: m.userId, event: 'team_decision' as const, body, link })),
    );
  }

  /** Toma hasta `limit` pendientes vencidas y las reserva para esta instancia. */
  private async claim(limit: number): Promise<Notification[]> {
    return this.db.$queryRaw<Notification[]>`
      UPDATE notifications SET attempts = attempts + 1,
        next_attempt_at = now() + ${`${LEASE_MS} milliseconds`}::interval
      WHERE id IN (
        SELECT id FROM notifications
        WHERE status = 'pending' AND next_attempt_at <= now()
        ORDER BY next_attempt_at
        LIMIT ${limit}
        FOR UPDATE SKIP LOCKED
      )
      RETURNING id, user_id AS "userId", event, title, body, link, channel, attempts`;
  }

  /** Entrega lo pendiente. Devuelve cuántas se enviaron. */
  async deliverPending(limit = 50): Promise<number> {
    const batch = await this.claim(limit);
    let sent = 0;
    for (const n of batch) {
      try {
        const done = await this.deliver(n);
        await this.db.notification.update({
          where: { id: n.id },
          data: {
            status: done ? 'sent' : 'skipped',
            sentAt: done ? new Date() : null,
            error: null,
          },
        });
        if (done) sent++;
      } catch (e) {
        const error = (e as Error).message.slice(0, 500);
        const failed = n.attempts >= MAX_NOTIFICATION_ATTEMPTS;
        await this.db.notification.update({
          where: { id: n.id },
          data: {
            status: failed ? 'failed' : 'pending',
            error,
            nextAttemptAt: new Date(Date.now() + retryDelayMs(n.attempts)),
          },
        });
        this.log.warn(
          `No se entregó ${n.event} por ${n.channel} (intento ${n.attempts}): ${error}`,
        );
      }
    }
    return sent;
  }

  /** `false` si no hay a dónde enviarla (sin teléfono registrado o push apagado). */
  private async deliver(n: Notification): Promise<boolean> {
    const message = { title: n.title, body: n.body, link: n.link };
    if (n.channel === 'email') {
      const user = await this.db.user.findUniqueOrThrow({ where: { id: n.userId } });
      if (user.blockedAt) return false;
      await this.email.send(user.email, message);
      return true;
    }
    if (!this.push.enabled) return false;
    const devices = await this.db.deviceToken.findMany({ where: { userId: n.userId } });
    if (devices.length === 0) return false;
    const result = await this.push.send(
      devices.map((d) => d.token),
      message,
    );
    if (result.invalidTokens.length)
      await this.db.deviceToken.deleteMany({ where: { token: { in: result.invalidTokens } } });
    return result.delivered > 0;
  }
}
