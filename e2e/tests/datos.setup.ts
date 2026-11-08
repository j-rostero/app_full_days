import { mkdirSync, writeFileSync } from 'node:fs';
import { randomUUID } from 'node:crypto';
import { test as setup } from '@playwright/test';
import { createDb } from '@fulldays/db';
import { exampleSheet, todayInVenezuela } from '@fulldays/shared';
import { E2E } from '../entorno.ts';
import { correo, cuenta, ESTADO, type Datos } from './apoyo.ts';

const day = (plus: number) =>
  new Date(Date.parse(`${todayInVenezuela()}T00:00:00Z`) + plus * 86_400_000);

/**
 * Lo que en la vida real hacen el alta de la agencia y la revisión de Central (cubiertos por
 * las pruebas de la API): una agencia aprobada con un viaje publicado, una salida hoy y otra en
 * doce días, y una persona de Central.
 */
setup('agencia aprobada con un viaje en venta y Central', async () => {
  const db = createDb(E2E.databaseUrl);
  try {
    const owner = correo('agencia');
    const boss = correo('central');
    await Promise.all([cuenta(owner), cuenta(boss)]);
    const [o, b] = await Promise.all([
      db.user.findUniqueOrThrow({ where: { email: owner } }),
      db.user.findUniqueOrThrow({ where: { email: boss } }),
    ]);
    await db.staffMember.create({ data: { userId: b.id, role: 'super' } });
    const provider = await db.provider.create({
      data: {
        kind: 'company',
        name: 'Rutas de Prueba',
        legalName: 'Rutas de Prueba C.A.',
        rif: `J-${String(Math.floor(Math.random() * 1e8)).padStart(8, '0')}-1`,
        baseCity: 'Caracas',
        phone: '+584141234567',
        status: 'approved',
        paymentInstructions: 'Zelle a pagos@rutas.test',
      },
    });
    await db.providerMember.create({
      data: { providerId: provider.id, userId: o.id, role: 'owner' },
    });
    const sheet = exampleSheet('fullday', { destinationId: randomUUID(), photoIds: [] });
    sheet.general.destinationId = null;
    sheet.general.title = 'Fullday a Cayo de Prueba';
    sheet.pricing.fares = { adult: 40, child: null, senior: null, infant: null };
    sheet.pricing.deposit = null;
    const product = await db.product.create({
      data: {
        providerId: provider.id,
        type: 'fullday',
        status: 'published',
        sheet: sheet as never,
      },
    });
    for (const plus of [0, 12])
      await db.departure.create({
        data: {
          providerId: provider.id,
          productId: product.id,
          date: day(plus),
          capacity: 30,
          sheet: sheet as never,
          productType: 'fullday',
          priceUsd: 40,
          cities: ['caracas'],
        },
      });
    const datos: Datos = {
      providerId: provider.id,
      productId: product.id,
      title: sheet.general.title,
      owner,
      boss,
      today: day(0).toISOString().slice(0, 10),
      later: day(12).toISOString().slice(0, 10),
    };
    mkdirSync(new URL('.', ESTADO), { recursive: true });
    writeFileSync(ESTADO, JSON.stringify(datos, null, 2));
  } finally {
    await db.$disconnect();
  }
});
