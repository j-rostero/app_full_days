import { test, after } from 'node:test';
import assert from 'node:assert/strict';
import { randomUUID } from 'node:crypto';
import { createDb } from './index.ts';
import { scopeToProvider } from './scope.ts';

// Contra PostgreSQL real (DATABASE_URL), con la migración aplicada.
const db = createDb(
  process.env.DATABASE_URL ?? 'postgresql://fulldays:fulldays@localhost:5432/fulldays',
);
after(() => db.$disconnect());

async function fixture() {
  const tag = randomUUID().slice(0, 8);
  const provider = (name: string) =>
    db.provider.create({
      data: {
        kind: 'company',
        name,
        legalName: `${name} C.A.`,
        rif: `J-${String(Math.floor(Math.random() * 1e8)).padStart(8, '0')}-${Math.floor(Math.random() * 10)}`,
        baseCity: 'Caracas',
        phone: '+584120000000',
      },
    });
  const [a, b] = await Promise.all([provider(`A ${tag}`), provider(`B ${tag}`)]);
  const [ana, beto] = await Promise.all([
    db.user.create({ data: { email: `ana-${tag}@x.com` } }),
    db.user.create({ data: { email: `beto-${tag}@x.com` } }),
  ]);
  await db.providerMember.create({ data: { providerId: a.id, userId: ana.id, role: 'owner' } });
  await db.providerMember.create({ data: { providerId: b.id, userId: beto.id, role: 'owner' } });
  return { a, b, ana, beto };
}

test('solo ve filas de su agencia', async () => {
  const { a, b, beto } = await fixture();
  const scoped = scopeToProvider(db, a.id);
  const members = await scoped.providerMember.findMany();
  assert.ok(members.every((m) => m.providerId === a.id));
  assert.equal(await scoped.providerMember.findFirst({ where: { userId: beto.id } }), null);
  assert.equal(
    await scopeToProvider(db, b.id).providerMember.count({ where: { userId: beto.id } }),
    1,
  );
});

test('no puede actualizar ni borrar filas de otra agencia', async () => {
  const { a, beto } = await fixture();
  const scoped = scopeToProvider(db, a.id);
  const updated = await scoped.providerMember.updateMany({
    where: { userId: beto.id },
    data: { role: 'guide' },
  });
  assert.equal(updated.count, 0);
  const deleted = await scoped.providerMember.deleteMany({ where: { userId: beto.id } });
  assert.equal(deleted.count, 0);
  const memberOfB = await db.providerMember.findFirstOrThrow({ where: { userId: beto.id } });
  await assert.rejects(
    scoped.providerMember.update({ where: { id: memberOfB.id }, data: { role: 'guide' } }),
  );
});

test('crea siempre en su agencia y no deja mover filas a otra', async () => {
  const { a, b, beto } = await fixture();
  const scoped = scopeToProvider(db, a.id);
  const created = await scoped.providerMember.create({
    data: { providerId: b.id, userId: beto.id, role: 'guide' },
  });
  assert.equal(created.providerId, a.id);
  const moved = await scoped.providerMember.update({
    where: { id: created.id },
    data: { providerId: b.id, role: 'finance' },
  });
  assert.equal(moved.providerId, a.id);
  assert.equal(moved.role, 'finance');
});

test('también limita dentro de una transacción', async () => {
  const { a, beto } = await fixture();
  await db.$transaction(async (tx) => {
    const scoped = scopeToProvider(tx, a.id);
    assert.equal(await scoped.providerMember.count({ where: { userId: beto.id } }), 0);
  });
});
