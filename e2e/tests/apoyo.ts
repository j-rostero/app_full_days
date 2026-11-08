import { readFileSync } from 'node:fs';
import { expect, type Page } from '@playwright/test';
import { E2E } from '../entorno.ts';

export const ESTADO = new URL('../.estado/datos.json', import.meta.url);

export interface Datos {
  providerId: string;
  productId: string;
  title: string;
  owner: string;
  boss: string;
  today: string;
  later: string;
}

export const datos = (): Datos => JSON.parse(readFileSync(ESTADO, 'utf8')) as Datos;

/** Crea y confirma una cuenta en la API; devuelve el token de acceso. */
export async function cuenta(email: string): Promise<string> {
  const post = (path: string, body: unknown) =>
    fetch(`${E2E.api}/v1/auth/${path}`, {
      method: 'POST',
      headers: { 'content-type': 'application/json' },
      body: JSON.stringify(body),
    });
  await post('registrar', { email, password: E2E.password });
  const res = await post('verificar', { email, code: E2E.code });
  if (!res.ok) throw new Error(`verificar ${email}: ${res.status} ${await res.text()}`);
  return ((await res.json()) as { accessToken: string }).accessToken;
}

export const correo = (quien: string) =>
  `${quien}-${Date.now()}-${Math.floor(Math.random() * 1e4)}@ejemplo.com`;

export async function entrar(page: Page, base: string, email: string): Promise<void> {
  await page.goto(`${base}/entrar`);
  await page.getByLabel('Correo').fill(email);
  await page.getByLabel('Contraseña').fill(E2E.password);
  await page.getByRole('button', { name: 'Entrar' }).click();
  await page.waitForURL((u) => !u.pathname.startsWith('/entrar'));
}

/** Registro del viajero por la web, con el código fijo de las pruebas. */
export async function registrarViajero(page: Page): Promise<string> {
  const email = correo('viajero');
  await page.goto(`${E2E.web}/registrar`);
  await page.getByLabel('Correo').fill(email);
  await page.getByLabel('Contraseña (mínimo 8 caracteres)').fill(E2E.password);
  await page.getByLabel('Repite la contraseña').fill(E2E.password);
  await page.getByRole('button', { name: 'Crear cuenta' }).click();
  await page.waitForURL(/verificar/);
  await page.getByLabel(/[Cc]ódigo/).fill(E2E.code);
  await page.getByRole('button').first().click();
  await page.waitForURL((u) => !u.pathname.startsWith('/verificar'));
  return email;
}

/** Aparta puestos en una salida desde la ficha del viaje y devuelve el código de la reserva. */
export async function reservar(page: Page, productId: string, fecha: string, adultos: number) {
  await page.goto(`${E2E.web}/viajes/${productId}`);
  const fila = page.locator('.fechas li', { hasText: fechaLarga(fecha) });
  await fila.getByRole('link', { name: 'Reservar' }).click();
  await page.waitForURL(/\/reservar\//);
  await page.getByRole('spinbutton').first().fill(String(adultos));
  await page.getByText('Para reservar pagas').waitFor();
  await page.getByRole('button', { name: 'Apartar mis puestos' }).click();
  await page.waitForURL(/\/reservas\/[0-9a-f-]{36}$/);
  return (await page.locator('p.suave strong').first().innerText()).trim();
}

export async function reportarPago(page: Page) {
  await page.getByLabel('Método').selectOption('zelle');
  await page.getByLabel('Referencia o número de confirmación').fill(`ZL-${Date.now()}`);
  await page.getByRole('button', { name: 'Reportar pago' }).click();
  await expect(page.getByText('Pago reportado')).toBeVisible({ timeout: 20_000 });
}

export async function confirmarPago(page: Page, providerId: string, code: string) {
  await page.goto(`${E2E.pro}/agencia/${providerId}/pagos`);
  const fila = page.locator('article.bloque', { hasText: code });
  await fila.getByRole('button', { name: 'Confirmar' }).click();
  await expect(fila).toHaveCount(0);
}

/** «viernes, 20 de noviembre», igual que la escribe la web. */
export const fechaLarga = (iso: string) =>
  new Date(`${iso}T12:00:00Z`).toLocaleDateString('es-VE', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    timeZone: 'UTC',
  });

/** Acepta los diálogos de confirmación de la página. */
export const aceptarDialogos = (page: Page) => page.on('dialog', (d) => void d.accept());

/** Como lo escribe la web: «USD 40,00». */
export const usd = (n: number) =>
  n.toLocaleString('es-VE', { style: 'currency', currency: 'USD' }).replace(/\u00a0/g, ' ');
