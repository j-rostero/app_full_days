import { expect, test } from '@playwright/test';
import { E2E } from '../entorno.ts';
import { datos, entrar, registrarViajero } from './apoyo.ts';

test('la sesión vive en cookies que los scripts no leen y se cierra', async ({ page, context }) => {
  await registrarViajero(page);
  const cookies = await context.cookies(E2E.web);
  expect(cookies.length).toBeGreaterThan(0);
  expect(cookies.every((c) => c.httpOnly)).toBe(true);
  expect(await page.evaluate(() => document.cookie)).toBe('');
  await page.getByRole('button', { name: 'Salir' }).click();
  await expect(page.getByRole('link', { name: 'Entrar' })).toBeVisible();
});

test('Central no se abre con una cuenta sin permisos', async ({ page }) => {
  const d = datos();
  await entrar(page, E2E.central, d.owner);
  await expect(page.getByRole('link', { name: 'Reclamos' })).toHaveCount(0);
  await page.goto(`${E2E.central}/reclamos`);
  await expect(page.getByText(/404|no encontr/i).first()).toBeVisible();
});
