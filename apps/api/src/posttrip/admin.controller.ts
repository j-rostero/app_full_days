import {
  Body,
  Controller,
  Get,
  Header,
  HttpCode,
  Inject,
  Param,
  Post,
  Query,
} from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import {
  CONFIRMED_STATUSES,
  monthRange,
  type ProductSheet,
  reputation,
  type ReviewAspect,
  settlementTotals,
  todayInVenezuela,
  toCsv,
} from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Membership, type MembershipContext, Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import { SessionService } from '../auth/session.service.ts';
import { CsvSchema } from '../tripday/tripday.schemas.ts';
import {
  AdminUserListSchema,
  CentralSettlementsSchema,
  MetricsQuery,
  MetricsSchema,
  MonthQuery,
  ProviderReportSchema,
  ReasonInput,
  SettlementSchema,
  UserQuery,
} from './posttrip.schemas.ts';

const TAG = ['liquidaciones'];
const thisMonth = () => todayInVenezuela().slice(0, 7);
const cents = (n: unknown) => Math.round(Number(n) * 100);
type Settlement = z.infer<typeof SettlementSchema>;

/** Liquidaciones, reportes y métricas, leídos del libro; y soporte a personas en Central. */
@Controller()
export class AdminController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(SessionService) private readonly sessions: SessionService,
  ) {}

  @Get('pro/:providerId/liquidaciones')
  @Can('settlements')
  @Endpoint({
    operationId: 'getSettlement',
    summary:
      'Liquidación de un mes (por defecto el actual): pagos, reembolsos, comisión, neto y líneas',
    tags: TAG,
    query: MonthQuery,
    responses: { 200: SettlementSchema },
  })
  settlement(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(MonthQuery)) q: z.infer<typeof MonthQuery>,
  ): Promise<Settlement> {
    return this.settle(m.providerId, q.mes ?? thisMonth());
  }

  @Get('pro/:providerId/liquidaciones.csv')
  @Can('settlements')
  @Header('content-type', 'text/csv; charset=utf-8')
  @Header('content-disposition', 'attachment; filename="liquidacion.csv"')
  @Endpoint({
    operationId: 'getSettlementCsv',
    summary: 'La liquidación del mes en CSV',
    tags: TAG,
    query: MonthQuery,
    contentType: 'text/csv',
    responses: { 200: CsvSchema },
  })
  async settlementCsv(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(MonthQuery)) q: z.infer<typeof MonthQuery>,
  ): Promise<string> {
    const s = await this.settle(m.providerId, q.mes ?? thisMonth());
    return toCsv([
      ['Fecha', 'Movimiento', 'Reserva', 'Monto USD', 'Comisión USD'],
      ...s.lines.map((l) => [
        l.at.slice(0, 10),
        l.kind === 'payment' ? 'Pago' : 'Reembolso',
        l.bookingCode,
        l.amountUsd.toFixed(2),
        l.commissionUsd.toFixed(2),
      ]),
      [],
      ['Cobrado', '', '', s.paymentsUsd.toFixed(2), ''],
      ['Devuelto', '', '', s.refundsUsd.toFixed(2), ''],
      ['Comisión', '', '', s.commissionUsd.toFixed(2), ''],
      ['Neto', '', '', s.netUsd.toFixed(2), ''],
    ]);
  }

  @Get('pro/:providerId/reportes')
  @Can('reports')
  @Endpoint({
    operationId: 'getProviderReport',
    summary: 'Ventas del mes, reservas confirmadas, cancelaciones, ocupación y reputación',
    tags: TAG,
    query: MonthQuery,
    responses: { 200: ProviderReportSchema },
  })
  async report(
    @Membership() m: MembershipContext,
    @Query(new ZodPipe(MonthQuery)) q: z.infer<typeof MonthQuery>,
  ): Promise<z.infer<typeof ProviderReportSchema>> {
    const month = q.mes ?? thisMonth();
    const { from, to } = monthRange(month);
    const settlement = await this.settle(m.providerId, month);
    const [confirmed, cancellations, occupancy, reviews] = await Promise.all([
      this.db.booking.count({
        where: {
          providerId: m.providerId,
          status: { in: [...CONFIRMED_STATUSES] },
          createdAt: { gte: from, lt: to },
        },
      }),
      this.db.booking.count({
        where: { providerId: m.providerId, cancelledAt: { gte: from, lt: to } },
      }),
      this.occupancy({ providerId: m.providerId }, from, to),
      this.db.review.findMany({
        where: { providerId: m.providerId, status: 'visible' },
        select: { rating: true, asDescribed: true, aspects: true },
      }),
    ]);
    return {
      month,
      salesUsd: settlement.paymentsUsd,
      confirmedBookings: confirmed,
      cancellations,
      occupancyPercent: occupancy,
      reputation: reputation(
        reviews.map((r) => ({
          ...r,
          aspects: r.aspects as Partial<Record<ReviewAspect, number>>,
        })),
      ),
    };
  }

  @Get('central/liquidaciones')
  @Can('settlements')
  @Endpoint({
    operationId: 'listSettlements',
    summary: 'Totales del mes por cada agencia con movimientos en el libro',
    tags: TAG,
    query: MonthQuery,
    responses: { 200: CentralSettlementsSchema },
  })
  async all(
    @Query(new ZodPipe(MonthQuery)) q: z.infer<typeof MonthQuery>,
  ): Promise<z.infer<typeof CentralSettlementsSchema>> {
    const month = q.mes ?? thisMonth();
    const { from, to } = monthRange(month);
    const entries = await this.db.ledgerEntry.findMany({
      where: { createdAt: { gte: from, lt: to } },
      include: { provider: { select: { name: true } } },
    });
    const byProvider = new Map<string, { name: string; rows: typeof entries }>();
    for (const e of entries) {
      const slot = byProvider.get(e.providerId) ?? { name: e.provider.name, rows: [] };
      slot.rows.push(e);
      byProvider.set(e.providerId, slot);
    }
    return {
      month,
      items: [...byProvider]
        .map(([providerId, { name, rows }]) => ({
          providerId,
          providerName: name,
          ...settlementTotals(rows.map(plain)),
        }))
        .sort((a, b) => b.paymentsUsd - a.paymentsUsd),
    };
  }

  @Get('central/metricas')
  @Can('metrics')
  @Endpoint({
    operationId: 'getMetrics',
    summary:
      'Actividad de un periodo (por defecto los últimos 7 días): reservas, GMV, comisión, ocupación y búsquedas',
    tags: TAG,
    query: MetricsQuery,
    responses: { 200: MetricsSchema },
  })
  async metrics(
    @Query(new ZodPipe(MetricsQuery)) q: z.infer<typeof MetricsQuery>,
  ): Promise<z.infer<typeof MetricsSchema>> {
    const today = todayInVenezuela();
    const toDay = q.hasta ?? today;
    const fromDay =
      q.desde ??
      new Date(Date.parse(`${toDay}T00:00:00Z`) - 6 * 86_400_000).toISOString().slice(0, 10);
    // Días de Venezuela (UTC−4) como instantes; `hasta` incluido.
    const from = new Date(Date.parse(`${fromDay}T04:00:00Z`));
    const to = new Date(Date.parse(`${toDay}T04:00:00Z`) + 86_400_000);
    const range = { gte: from, lt: to };
    const [bookings, confirmed, entries, occupancy, selling, searches, top, empty] =
      await Promise.all([
        this.db.booking.count({ where: { createdAt: range } }),
        this.db.booking.count({
          where: { createdAt: range, status: { in: [...CONFIRMED_STATUSES] } },
        }),
        this.db.ledgerEntry.findMany({ where: { createdAt: range } }),
        this.occupancy(
          {},
          new Date(`${fromDay}T00:00:00Z`),
          new Date(Date.parse(`${toDay}T00:00:00Z`) + 86_400_000),
        ),
        this.db.departure
          .groupBy({
            by: ['providerId'],
            where: { status: 'open', date: { gte: new Date(`${today}T00:00:00Z`) } },
          })
          .then((g) => g.length),
        this.db.searchLog.count({ where: { createdAt: range } }),
        this.terms(from, to, false),
        this.terms(from, to, true),
      ]);
    const totals = settlementTotals(entries.map(plain));
    return {
      from: fromDay,
      to: toDay,
      bookings,
      confirmed,
      gmvUsd: (cents(totals.paymentsUsd) - cents(totals.refundsUsd)) / 100,
      commissionUsd: totals.commissionUsd,
      occupancyPercent: occupancy,
      sellingProviders: selling,
      searches,
      topSearches: top,
      emptySearches: empty,
    };
  }

  @Get('central/usuarios')
  @Can('users')
  @Endpoint({
    operationId: 'searchUsers',
    summary:
      'Busca personas por nombre, correo, teléfono o código de reserva (máximo 30), con sus últimas reservas',
    tags: ['usuarios'],
    query: UserQuery,
    responses: { 200: AdminUserListSchema },
  })
  async users(
    @Query(new ZodPipe(UserQuery)) q: z.infer<typeof UserQuery>,
  ): Promise<z.infer<typeof AdminUserListSchema>> {
    const text = { contains: q.q, mode: 'insensitive' as const };
    const rows = await this.db.user.findMany({
      where: {
        OR: [
          { email: text },
          { name: text },
          { phone: { contains: q.q.replace(/\D/g, '') || q.q } },
          { bookings: { some: { code: q.q.toUpperCase() } } },
        ],
      },
      include: {
        bookings: {
          include: { departure: { select: { date: true, sheet: true } } },
          orderBy: { createdAt: 'desc' },
          take: 20,
        },
      },
      take: 30,
    });
    return {
      items: rows.map((u) => ({
        id: u.id,
        email: u.email,
        name: u.name,
        phone: u.phone,
        blockedAt: u.blockedAt?.toISOString() ?? null,
        createdAt: u.createdAt.toISOString(),
        bookings: u.bookings.map((b) => ({
          id: b.id,
          code: b.code,
          status: b.status,
          title: (b.departure.sheet as unknown as ProductSheet).general.title,
          date: b.departure.date.toISOString().slice(0, 10),
        })),
      })),
    };
  }

  @Post('central/usuarios/:id/bloquear')
  @HttpCode(204)
  @Can('users')
  @Endpoint({
    operationId: 'blockUser',
    summary: 'Bloquea con motivo y cierra todas sus sesiones al instante',
    tags: ['usuarios'],
    body: ReasonInput,
    responses: { 204: null },
  })
  async block(
    @Param('id') id: string,
    @Body(new ZodPipe(ReasonInput)) input: z.infer<typeof ReasonInput>,
    @Trail() trail: AuditTrail,
  ): Promise<void> {
    if (!isUuid(id)) throw notFound();
    const done = await this.db.user.updateMany({ where: { id }, data: { blockedAt: new Date() } });
    if (done.count === 0) throw notFound('Esa persona no existe.');
    await this.sessions.revokeAll(id);
    trail.after = { blocked: true, reason: input.reason };
  }

  @Post('central/usuarios/:id/desbloquear')
  @HttpCode(204)
  @Can('users')
  @Endpoint({
    operationId: 'unblockUser',
    summary: 'Quita el bloqueo',
    tags: ['usuarios'],
    responses: { 204: null },
  })
  async unblock(@Param('id') id: string): Promise<void> {
    if (!isUuid(id)) throw notFound();
    const done = await this.db.user.updateMany({ where: { id }, data: { blockedAt: null } });
    if (done.count === 0) throw notFound('Esa persona no existe.');
  }

  /** La liquidación sale de los asientos: una línea por transacción del libro. */
  private async settle(providerId: string, month: string): Promise<Settlement> {
    const { from, to } = monthRange(month);
    const entries = await this.db.ledgerEntry.findMany({
      where: { providerId, createdAt: { gte: from, lt: to } },
      orderBy: { createdAt: 'asc' },
    });
    const codes = new Map(
      (
        await this.db.booking.findMany({
          where: {
            id: { in: [...new Set(entries.map((e) => e.bookingId).filter(Boolean))] as string[] },
          },
          select: { id: true, code: true },
        })
      ).map((b) => [b.id, b.code]),
    );
    const byTx = new Map<string, typeof entries>();
    for (const e of entries) byTx.set(e.transactionId, [...(byTx.get(e.transactionId) ?? []), e]);
    const lines = [...byTx.values()].map((rows) => {
      const t = settlementTotals(rows.map(plain));
      const refund = rows.some((r) => r.refundId);
      return {
        at: rows[0]!.createdAt.toISOString(),
        kind: refund ? ('refund' as const) : ('payment' as const),
        bookingCode: rows[0]!.bookingId ? (codes.get(rows[0]!.bookingId) ?? null) : null,
        amountUsd: refund ? t.refundsUsd : t.paymentsUsd,
        commissionUsd: t.commissionUsd,
      };
    });
    return { month, ...settlementTotals(entries.map(plain)), lines };
  }

  /** Puestos reservados entre cupo de las salidas no canceladas cuya fecha cae en el periodo. */
  private async occupancy(where: { providerId?: string }, from: Date, to: Date) {
    const agg = await this.db.departure.aggregate({
      where: { ...where, status: { not: 'cancelled' }, date: { gte: from, lt: to } },
      _sum: { reserved: true, capacity: true },
    });
    const capacity = agg._sum.capacity ?? 0;
    return capacity ? Math.round(((agg._sum.reserved ?? 0) * 100) / capacity) : null;
  }

  private async terms(from: Date, to: Date, empty: boolean) {
    const rows = await this.db.searchLog.groupBy({
      by: ['text'],
      where: {
        createdAt: { gte: from, lt: to },
        text: { not: null },
        ...(empty ? { results: 0 } : {}),
      },
      _count: { _all: true },
      orderBy: { _count: { text: 'desc' } },
      take: 10,
    });
    return rows.map((r) => ({ text: r.text!, count: r._count._all }));
  }
}

const plain = (e: {
  account: string;
  debitUsd: unknown;
  creditUsd: unknown;
  paymentId: string | null;
  refundId: string | null;
}) => ({
  account: e.account,
  debitUsd: Number(e.debitUsd),
  creditUsd: Number(e.creditUsd),
  paymentId: e.paymentId,
  refundId: e.refundId,
});
