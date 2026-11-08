const usdFormat = new Intl.NumberFormat('es-VE', {
  style: 'currency',
  currency: 'USD',
  maximumFractionDigits: 2,
});
const bsFormat = new Intl.NumberFormat('es-VE', {
  maximumFractionDigits: 2,
  minimumFractionDigits: 2,
});

export const usd = (value: number) => usdFormat.format(value);
export const bs = (value: number) => `${bsFormat.format(value)} Bs`;

/** «sábado 20 de diciembre», sin pasar por la zona horaria del servidor. */
export function longDate(isoDate: string): string {
  return new Date(`${isoDate}T12:00:00Z`).toLocaleDateString('es-VE', {
    weekday: 'long',
    day: 'numeric',
    month: 'long',
    timeZone: 'UTC',
  });
}
export function shortDate(isoDate: string): string {
  return new Date(`${isoDate}T12:00:00Z`).toLocaleDateString('es-VE', {
    day: 'numeric',
    month: 'short',
    timeZone: 'UTC',
  });
}

export const SITE_URL = process.env.SITE_URL ?? 'http://localhost:3100';
