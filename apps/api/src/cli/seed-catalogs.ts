/**
 * Carga catálogos iniciales (destinos con sus sitios, puntos de embarque y temáticas). Se
 * puede repetir: lo que ya existe por su slug o su nombre no se duplica.
 *
 *   pnpm --filter @fulldays/api seed-catalogs
 */
import { createDb } from '@fulldays/db';
import { loadConfig } from '../config.ts';

const DESTINATIONS = [
  {
    slug: 'los-roques',
    name: 'Los Roques',
    state: 'Dependencias Federales',
    region: 'Caribe',
    sites: ['Cayo de Agua', 'Francisquí', 'Madrisquí'],
  },
  {
    slug: 'morrocoy',
    name: 'Morrocoy',
    state: 'Falcón',
    region: 'Occidente',
    sites: ['Cayo Sombrero', 'Cayo Sal', 'Playa Mero'],
  },
  {
    slug: 'mochima',
    name: 'Mochima',
    state: 'Sucre',
    region: 'Oriente',
    sites: ['Playa Blanca', 'Isla de Plata'],
  },
  {
    slug: 'choroni',
    name: 'Choroní',
    state: 'Aragua',
    region: 'Centro',
    sites: ['Playa Grande', 'Chuao'],
  },
  {
    slug: 'merida',
    name: 'Mérida',
    state: 'Mérida',
    region: 'Andes',
    sites: ['Pico Espejo', 'Los Nevados'],
  },
  {
    slug: 'canaima',
    name: 'Canaima',
    state: 'Bolívar',
    region: 'Guayana',
    sites: ['Salto Ángel', 'Laguna de Canaima'],
  },
  { slug: 'colonia-tovar', name: 'Colonia Tovar', state: 'Aragua', region: 'Centro', sites: [] },
];
const POINTS = [
  { city: 'Caracas', name: 'Plaza Venezuela', address: 'Av. Libertador, frente a la fuente' },
  { city: 'Caracas', name: 'C.C. Millennium Mall', address: 'Los Dos Caminos, estacionamiento' },
  { city: 'Caracas', name: 'Terminal La Bandera', address: 'Av. Nueva Granada' },
  { city: 'Maracay', name: 'C.C. Las Américas', address: 'Av. Las Delicias' },
  { city: 'Valencia', name: 'C.C. Sambil Valencia', address: 'Av. Paseo Cabriales' },
];
const THEMES = [
  { slug: 'playas', name: 'Playas', description: 'Arena, sol y mar.' },
  {
    slug: 'con-ninos',
    name: 'Para ir con niños',
    description: 'Planes pensados para toda la familia.',
  },
  { slug: 'montana', name: 'Montaña', description: 'Frío, caminatas y paisajes.' },
  { slug: 'fin-de-semana', name: 'Fin de semana largo', description: 'Tours de dos o tres días.' },
];

const slugify = (text: string) =>
  text
    .normalize('NFD')
    .replace(/\p{Diacritic}/gu, '')
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, '-')
    .replace(/^-|-$/g, '');

const db = createDb(loadConfig().DATABASE_URL);
try {
  for (const d of DESTINATIONS) {
    const parent = await db.destination.upsert({
      where: { slug: d.slug },
      create: { slug: d.slug, name: d.name, state: d.state, region: d.region },
      update: {},
    });
    for (const site of d.sites) {
      const slug = `${d.slug}-${slugify(site)}`;
      await db.destination.upsert({
        where: { slug },
        create: { slug, name: site, state: d.state, region: d.region, parentId: parent.id },
        update: {},
      });
    }
  }
  for (const p of POINTS) {
    if (!(await db.boardingPoint.findFirst({ where: { city: p.city, name: p.name } })))
      await db.boardingPoint.create({ data: p });
  }
  for (const t of THEMES) await db.theme.upsert({ where: { slug: t.slug }, create: t, update: {} });
  console.log('Catálogos cargados.');
} finally {
  await db.$disconnect();
}
