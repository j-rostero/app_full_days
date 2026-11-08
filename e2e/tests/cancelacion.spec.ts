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
  usd,
} from './apoyo.ts';

/** Cancelar con tiempo devuelve todo; la agencia lo paga y la liquidación lo descuenta. */
test('cancelar, reembolsar y liquidar', async ({ browser }) => {
  const d = datos();
  const viajero = await (await browser.newContext()).newPage();
  const agencia = await (await browser.newContext()).newPage();
  for (const p of [viajero, agencia]) aceptarDialogos(p);

  await registrarViajero(viajero);
  const code = await reservar(viajero, d.productId, d.later, 1);
  await reportarPago(viajero);
  await entrar(agencia, E2E.pro, d.owner);
  await confirmarPago(agencia, d.providerId, code);

  await viajero.reload();
  await expect(viajero.getByText(`Si cancelas hoy, te devuelven ${usd(40)}`)).toBeVisible();
  await viajero.getByRole('button', { name: 'Cancelar reserva' }).click();
  await expect(viajero.getByText(`Te corresponden ${usd(40)}`)).toBeVisible();

  await agencia.goto(`${E2E.pro}/agencia/${d.providerId}/reembolsos`);
  const r = agencia.locator('article.bloque', { hasText: code });
  await r.getByLabel('Referencia de la transferencia').fill('ZL-REEMBOLSO-1');
  await r.getByRole('button', { name: 'Marcar pagado' }).click();
  await expect(r).toHaveCount(0);
  await viajero.reload();
  await expect(viajero.getByText('ya te los devolvió (ref. ZL-REEMBOLSO-1)')).toBeVisible();

  await agencia.goto(`${E2E.pro}/agencia/${d.providerId}/liquidaciones`);
  const fila = agencia.getByRole('row', { name: new RegExp(`Reembolso ${code}`) });
  await expect(fila).toBeVisible();
  const href = await agencia.getByRole('link', { name: 'Descargar CSV' }).getAttribute('href');
  const csv = await agencia.request.get(`${E2E.pro}${href}`);
  expect(csv.headers()['content-type']).toContain('text/csv');
  expect((await csv.body()).toString('utf8')).toContain(`Reembolso;${code};40.00`);
});
