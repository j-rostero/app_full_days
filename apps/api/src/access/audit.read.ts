import type { PrismaClient, Prisma } from '@fulldays/db';
import type { AuditEntry, AuditPage } from './access.schemas.ts';

/** Página de auditoría, de la más reciente a la más antigua. Los ids `uuid(7)` ordenan por tiempo. */
export async function readAudit(
  db: PrismaClient,
  where: Prisma.AuditLogWhereInput,
  page: { cursor?: string; limit: number },
): Promise<AuditPage> {
  const rows = await db.auditLog.findMany({
    where: { ...where, ...(page.cursor ? { id: { lt: page.cursor } } : {}) },
    include: { actor: { select: { id: true, email: true, name: true } } },
    orderBy: { id: 'desc' },
    take: page.limit + 1,
  });
  const items: AuditEntry[] = rows.slice(0, page.limit).map((row) => ({
    id: row.id,
    actor: row.actor,
    scope: row.scope,
    providerId: row.providerId,
    action: row.action,
    params: row.params,
    input: row.input,
    before: row.before,
    after: row.after,
    createdAt: row.createdAt.toISOString(),
  }));
  return { items, nextCursor: rows.length > page.limit ? (items.at(-1)?.id ?? null) : null };
}
