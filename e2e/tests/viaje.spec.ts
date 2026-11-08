import { expect, test } from '@playwright/test';
import { E2E } from '../entorno.ts';
import {
  aceptarDialogos,
  confirmarPago,
  datos,
  entrar,
  registrarViajero,
  reportarPago,
  reservar,
} from './apoyo.ts';

/** Del apartado a la reseña: reservar, pagar, pasar lista, viajar, reseñar y reclamar. */
test('un viaje de punta a punta entre las tres webs', async ({ browser }) => {
  const d = datos();
  const viajero = await (await browser.newContext()).newPage();
  const agencia = await (await browser.newContext()).newPage();
  const central = await (await browser.newContext()).newPage();
  for (const p of [viajero, agencia, central]) aceptarDialogos(p);

  let code = '';
  await test.step('la viajera aparta, nombra a los pasajeros y reporta el pago', async () => {
    await registrarViajero(viajero);
    code = await reservar(viajero, d.productId, d.today, 2);
    for (const [i, [name, born]] of [
      ['Ana Pérez', '1990-05-01'],
      ['Luis Pérez', '1988-02-11'],
    ].entries()) {
      await viajero.getByLabel('Nombre y apellido').nth(i).fill(name!);
      await viajero.getByLabel('Fecha de nacimiento').nth(i).fill(born!);
    }
    await viajero.getByRole('button', { name: 'Guardar pasajeros' }).click();
    await expect(viajero.getByText('Pasajeros guardados')).toBeVisible();
    await reportarPago(viajero);
  });

  await test.step('la agencia confirma, pasa lista y publica un aviso', async () => {
    await entrar(agencia, E2E.pro, d.owner);
    await confirmarPago(agencia, d.providerId, code);
    await agencia.goto(`${E2E.pro}/agencia/${d.providerId}/hoy`);
    await agencia.getByRole('link', { name: d.title }).click();
    await agencia.waitForURL(/salidas\/[0-9a-f-]{36}$/);
    const ana = agencia.locator('article.bloque', { hasText: 'Ana Pérez' });
    await ana.getByRole('button', { name: 'Abordó' }).click();
    await expect(ana.locator('.fd-pill', { hasText: 'Abordó' })).toBeVisible();
    await agencia.getByLabel('Aviso').fill('Nos vemos a las 6:15 en la salida norte del metro.');
    await agencia.getByRole('button', { name: 'Publicar' }).click();
    await expect(agencia.getByText('Aviso publicado')).toBeVisible();
    const href = await agencia
      .getByRole('link', { name: 'Descargar lista (Excel)' })
      .getAttribute('href');
    const csv = (await (await agencia.request.get(`${E2E.pro}${href}`)).body()).toString('utf8');
    expect(csv).toContain('Ana Pérez');
  });

  await test.step('la viajera ve el aviso y, al terminar la salida, el viaje queda realizado', async () => {
    await viajero.reload();
    await expect(viajero.getByText('Nos vemos a las 6:15').first()).toBeVisible();
    await agencia.getByRole('button', { name: 'Iniciar salida' }).click();
    await agencia.getByRole('button', { name: 'Finalizar salida' }).click();
    await expect(agencia.getByRole('button', { name: 'Finalizar salida' })).toHaveCount(0);
    await viajero.reload();
    await expect(viajero.locator('.fd-pill').first()).toHaveText('Realizada');
  });

  await test.step('la viajera reseña y abre un reclamo', async () => {
    await viajero.getByLabel('Calificación general').selectOption('4');
    await viajero.getByLabel('Guía').selectOption('5');
    await viajero.getByLabel('Comentario').fill('Muy puntuales y el guía excelente.');
    await viajero.getByRole('button', { name: 'Publicar reseña' }).click();
    await expect(viajero.getByRole('heading', { name: '¿Cómo te fue?' })).toHaveCount(0);
    await viajero.getByText('Abrir un reclamo').click();
    await viajero.getByLabel('Asunto').fill('Faltó el toldo');
    await viajero.getByLabel('Qué pasó').fill('El toldo prometido no estaba en la playa.');
    await viajero.getByRole('button', { name: 'Enviar a la agencia' }).click();
    await expect(viajero.locator('.reclamo', { hasText: 'Faltó el toldo' })).toBeVisible();
  });

  await test.step('la agencia responde la reseña y el reclamo', async () => {
    await agencia.goto(`${E2E.pro}/agencia/${d.providerId}/resenas`);
    const r = agencia.locator('article.bloque', { hasText: 'guía excelente' });
    await r.getByLabel('Respuesta pública').fill('¡Gracias por viajar con nosotros!');
    await r.getByRole('button', { name: 'Responder' }).click();
    await expect(agencia.getByText('Tu respuesta: ¡Gracias')).toBeVisible();
    await agencia.goto(`${E2E.pro}/agencia/${d.providerId}/reclamos`);
    const c = agencia.locator('article.bloque', { hasText: code });
    await c.getByLabel('Tu respuesta').fill('Lo sentimos, el proveedor del toldo falló.');
    await c.getByRole('button', { name: 'Responder' }).click();
    await expect(c.getByText('el proveedor del toldo falló')).toBeVisible();
  });

  await test.step('la viajera escala, ve sus avisos y Central resuelve', async () => {
    await viajero.goto(`${E2E.web}/reclamos`);
    await viajero.getByRole('button', { name: 'Pedir que FullDays intervenga' }).click();
    await expect(viajero.locator('.fd-pill', { hasText: 'Con FullDays' })).toBeVisible();
    await viajero.goto(`${E2E.web}/avisos`);
    await expect(viajero.getByText('respondió tu reclamo')).toBeVisible();
    await expect(viajero.getByText('respondió tu reseña')).toBeVisible();

    await entrar(central, E2E.central, d.boss);
    await central.goto(`${E2E.central}/reclamos?estado=escalated`);
    const c = central.locator('article.bloque', { hasText: code });
    await c.getByLabel('Resolución').fill('La agencia devuelve 5 USD por el toldo.');
    await c.getByRole('button', { name: 'Resolver' }).click();
    await expect(c).toHaveCount(0);
    await viajero.goto(`${E2E.web}/reclamos`);
    await expect(viajero.getByText('La agencia devuelve 5 USD')).toBeVisible();
  });

  await test.step('la ficha del viaje muestra la reseña y la respuesta', async () => {
    await viajero.goto(`${E2E.web}/viajes/${d.productId}`);
    const resenas = viajero.locator('.resenas');
    await expect(resenas.getByText('guía excelente')).toBeVisible();
    await expect(resenas.getByText('Respuesta de la agencia')).toBeVisible();
  });
});
