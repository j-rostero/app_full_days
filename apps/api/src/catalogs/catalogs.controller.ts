import {
  Body,
  Controller,
  Delete,
  Get,
  HttpCode,
  Inject,
  Param,
  Patch,
  Post,
  Put,
  Query,
} from '@nestjs/common';
import type { Destination, DestinationFee, PrismaClient } from '@fulldays/db';
import { todayInVenezuela } from '@fulldays/shared';
import type { z } from 'zod';
import { Can } from '../access/access.decorators.ts';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint, Public } from '../common/endpoint.ts';
import { Auth, type AuthContext, Trail, type AuditTrail } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  BoardingPointInput,
  BoardingPointListSchema,
  BoardingPointQuery,
  BoardingPointSchema,
  BoardingPointUpdateInput,
  DestinationFeeInput,
  DestinationInput,
  DestinationListSchema,
  DestinationSchema,
  DestinationUpdateInput,
  RateInput,
  RateListSchema,
  RateSchema,
  SettingsInput,
  SettingsViewSchema,
  ThemeInput,
  ThemeListSchema,
  ThemeSchema,
  ThemeUpdateInput,
} from './catalogs.schemas.ts';
import { SettingsService } from './settings.service.ts';

const PUBLIC = ['catalogos'];
const CENTRAL = ['central'];

const id = (value: string) => {
  if (!isUuid(value)) throw notFound();
  return value;
};

type DestinationRow = Destination & { fees: DestinationFee[] };
const place = (d: DestinationRow) => ({
  id: d.id,
  slug: d.slug,
  name: d.name,
  state: d.state,
  region: d.region,
  lat: d.lat,
  lng: d.lng,
  fees: d.fees.map((f) => ({
    id: f.id,
    name: f.name,
    amountUsd: Number(f.amountUsd),
    payment: f.payment,
  })),
});

/** Catálogos públicos y su gestión en Central: destinos, puntos de embarque, temáticas, tasa y ajustes. */
@Controller()
export class CatalogsController {
  constructor(
    @Inject(DB) private readonly db: PrismaClient,
    @Inject(SettingsService) private readonly settings: SettingsService,
  ) {}

  // ── Destinos ────────────────────────────────────────────────────────────────

  @Get('catalogos/destinos')
  @Public()
  @Endpoint({
    operationId: 'listDestinations',
    summary: 'Destinos con sus sitios y tasas conocidas',
    tags: PUBLIC,
    responses: { 200: DestinationListSchema },
  })
  async destinations() {
    const rows = await this.db.destination.findMany({
      include: { fees: true },
      orderBy: { name: 'asc' },
    });
    const tops = rows.filter((d) => d.parentId === null);
    return {
      items: tops.map((d) => ({
        ...place(d),
        sites: rows.filter((s) => s.parentId === d.id).map(place),
      })),
    };
  }

  @Post('central/catalogos/destinos')
  @HttpCode(201)
  @Can('catalogs')
  @Endpoint({
    operationId: 'createDestination',
    summary: 'Crea un destino o un sitio dentro de uno',
    tags: CENTRAL,
    body: DestinationInput,
    responses: { 201: DestinationSchema },
  })
  async createDestination(
    @Body(new ZodPipe(DestinationInput)) input: z.infer<typeof DestinationInput>,
  ) {
    await this.checkParent(input.parentId, null);
    const row = await this.db.destination.create({ data: input, include: { fees: true } });
    return { ...place(row), sites: [] };
  }

  @Patch('central/catalogos/destinos/:id')
  @Can('catalogs')
  @Endpoint({
    operationId: 'updateDestination',
    summary: 'Edita un destino',
    tags: CENTRAL,
    body: DestinationUpdateInput,
    responses: { 200: DestinationSchema },
  })
  async updateDestination(
    @Param('id') raw: string,
    @Body(new ZodPipe(DestinationUpdateInput)) input: z.infer<typeof DestinationUpdateInput>,
    @Trail() trail: AuditTrail,
  ) {
    const destinationId = id(raw);
    trail.before = await this.db.destination.findUniqueOrThrow({ where: { id: destinationId } });
    if (input.parentId !== undefined) await this.checkParent(input.parentId, destinationId);
    const row = await this.db.destination.update({
      where: { id: destinationId },
      data: input,
      include: { fees: true, children: { include: { fees: true } } },
    });
    return { ...place(row), sites: row.children.map(place) };
  }

  @Delete('central/catalogos/destinos/:id')
  @HttpCode(204)
  @Can('catalogs')
  @Endpoint({
    operationId: 'deleteDestination',
    summary: 'Borra un destino sin sitios',
    tags: CENTRAL,
    responses: { 204: null },
  })
  async deleteDestination(@Param('id') raw: string, @Trail() trail: AuditTrail) {
    const destinationId = id(raw);
    if (await this.db.destination.count({ where: { parentId: destinationId } }))
      throw conflict('Ese destino tiene sitios dentro. Bórralos o muévelos antes.');
    trail.before = await this.db.destination.delete({ where: { id: destinationId } });
  }

  @Post('central/catalogos/destinos/:id/tasas')
  @HttpCode(201)
  @Can('catalogs')
  @Endpoint({
    operationId: 'addDestinationFee',
    summary: 'Añade una tasa conocida a un destino',
    tags: CENTRAL,
    body: DestinationFeeInput,
    responses: { 201: DestinationSchema },
  })
  async addFee(
    @Param('id') raw: string,
    @Body(new ZodPipe(DestinationFeeInput)) input: z.infer<typeof DestinationFeeInput>,
  ) {
    const destinationId = id(raw);
    await this.db.destinationFee.create({ data: { ...input, destinationId } });
    const row = await this.db.destination.findUniqueOrThrow({
      where: { id: destinationId },
      include: { fees: true, children: { include: { fees: true } } },
    });
    return { ...place(row), sites: row.children.map(place) };
  }

  @Delete('central/catalogos/tasas/:id')
  @HttpCode(204)
  @Can('catalogs')
  @Endpoint({
    operationId: 'deleteDestinationFee',
    summary: 'Borra una tasa de destino',
    tags: CENTRAL,
    responses: { 204: null },
  })
  async deleteFee(@Param('id') raw: string, @Trail() trail: AuditTrail) {
    trail.before = await this.db.destinationFee.delete({ where: { id: id(raw) } });
  }

  private async checkParent(parentId: string | null, selfId: string | null) {
    if (!parentId) return;
    const parent = await this.db.destination.findUnique({ where: { id: parentId } });
    if (!parent) throw notFound('El destino superior no existe.');
    if (parent.parentId !== null || parent.id === selfId)
      throw conflict('Solo hay dos niveles: un sitio no puede tener sitios dentro.');
    if (selfId && (await this.db.destination.count({ where: { parentId: selfId } })))
      throw conflict('Un destino con sitios no puede ir dentro de otro.');
  }

  // ── Puntos de embarque ──────────────────────────────────────────────────────

  @Get('catalogos/puntos-de-embarque')
  @Public()
  @Endpoint({
    operationId: 'listBoardingPoints',
    summary: 'Puntos de embarque conocidos; filtro por ciudad',
    tags: PUBLIC,
    query: BoardingPointQuery,
    responses: { 200: BoardingPointListSchema },
  })
  async boardingPoints(
    @Query(new ZodPipe(BoardingPointQuery)) query: z.infer<typeof BoardingPointQuery>,
  ) {
    const items = await this.db.boardingPoint.findMany({
      where: query.city ? { city: { equals: query.city, mode: 'insensitive' } } : {},
      orderBy: [{ city: 'asc' }, { name: 'asc' }],
      select: { id: true, city: true, name: true, address: true, lat: true, lng: true },
    });
    return { items };
  }

  @Post('central/catalogos/puntos-de-embarque')
  @HttpCode(201)
  @Can('catalogs')
  @Endpoint({
    operationId: 'createBoardingPoint',
    summary: 'Crea un punto de embarque',
    tags: CENTRAL,
    body: BoardingPointInput,
    responses: { 201: BoardingPointSchema },
  })
  createPoint(
    @Body(new ZodPipe(BoardingPointInput)) input: z.infer<typeof BoardingPointInput>,
  ): Promise<PointView> {
    return this.db.boardingPoint.create({ data: input, select: POINT });
  }

  @Patch('central/catalogos/puntos-de-embarque/:id')
  @Can('catalogs')
  @Endpoint({
    operationId: 'updateBoardingPoint',
    summary: 'Edita un punto de embarque',
    tags: CENTRAL,
    body: BoardingPointUpdateInput,
    responses: { 200: BoardingPointSchema },
  })
  updatePoint(
    @Param('id') raw: string,
    @Body(new ZodPipe(BoardingPointUpdateInput)) input: z.infer<typeof BoardingPointUpdateInput>,
  ): Promise<PointView> {
    return this.db.boardingPoint.update({ where: { id: id(raw) }, data: input, select: POINT });
  }

  @Delete('central/catalogos/puntos-de-embarque/:id')
  @HttpCode(204)
  @Can('catalogs')
  @Endpoint({
    operationId: 'deleteBoardingPoint',
    summary: 'Borra un punto de embarque',
    tags: CENTRAL,
    responses: { 204: null },
  })
  async deletePoint(@Param('id') raw: string, @Trail() trail: AuditTrail) {
    trail.before = await this.db.boardingPoint.delete({ where: { id: id(raw) } });
  }

  // ── Temáticas ───────────────────────────────────────────────────────────────

  @Get('tematicas')
  @Public()
  @Endpoint({
    operationId: 'listThemes',
    summary: 'Temáticas por nombre',
    tags: PUBLIC,
    responses: { 200: ThemeListSchema },
  })
  async themes() {
    return { items: await this.db.theme.findMany({ orderBy: { name: 'asc' }, select: THEME }) };
  }

  @Post('central/tematicas')
  @HttpCode(201)
  @Can('themes')
  @Endpoint({
    operationId: 'createTheme',
    summary: 'Crea una temática',
    tags: CENTRAL,
    body: ThemeInput,
    responses: { 201: ThemeSchema },
  })
  createTheme(
    @Body(new ZodPipe(ThemeInput)) input: z.infer<typeof ThemeInput>,
  ): Promise<ThemeView> {
    return this.db.theme.create({ data: input, select: THEME });
  }

  @Patch('central/tematicas/:id')
  @Can('themes')
  @Endpoint({
    operationId: 'updateTheme',
    summary: 'Edita una temática',
    tags: CENTRAL,
    body: ThemeUpdateInput,
    responses: { 200: ThemeSchema },
  })
  updateTheme(
    @Param('id') raw: string,
    @Body(new ZodPipe(ThemeUpdateInput)) input: z.infer<typeof ThemeUpdateInput>,
  ): Promise<ThemeView> {
    return this.db.theme.update({ where: { id: id(raw) }, data: input, select: THEME });
  }

  @Delete('central/tematicas/:id')
  @HttpCode(204)
  @Can('themes')
  @Endpoint({
    operationId: 'deleteTheme',
    summary: 'Borra una temática; sus productos quedan sin ella',
    tags: CENTRAL,
    responses: { 204: null },
  })
  async deleteTheme(@Param('id') raw: string, @Trail() trail: AuditTrail) {
    trail.before = await this.db.theme.delete({ where: { id: id(raw) } });
  }

  // ── Tasa del día ────────────────────────────────────────────────────────────

  @Get('tasa')
  @Public()
  @Endpoint({
    operationId: 'getRate',
    summary: 'Tasa bolívares por dólar vigente (la más reciente que no sea futura)',
    tags: PUBLIC,
    responses: { 200: RateSchema },
  })
  async rate() {
    const row = await this.db.exchangeRate.findFirst({
      where: { date: { lte: new Date(`${todayInVenezuela()}T00:00:00Z`) } },
      orderBy: { date: 'desc' },
    });
    if (!row) throw notFound('Todavía no hay tasa cargada.');
    return toRate(row);
  }

  @Get('central/tasas')
  @Can('rates')
  @Endpoint({
    operationId: 'listRates',
    summary: 'Historial de tasas (hasta 365)',
    tags: CENTRAL,
    responses: { 200: RateListSchema },
  })
  async rates() {
    const rows = await this.db.exchangeRate.findMany({ orderBy: { date: 'desc' }, take: 365 });
    return { items: rows.map(toRate) };
  }

  @Put('central/tasas')
  @Can('rates')
  @Endpoint({
    operationId: 'setRate',
    summary: 'Fija la tasa de un día; repetir el día la corrige',
    tags: CENTRAL,
    body: RateInput,
    responses: { 200: RateSchema },
  })
  async setRate(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(RateInput)) input: z.infer<typeof RateInput>,
  ) {
    const date = new Date(`${input.date}T00:00:00Z`);
    const row = await this.db.exchangeRate.upsert({
      where: { date },
      create: { date, bsPerUsd: input.bsPerUsd, setById: auth.userId },
      update: { bsPerUsd: input.bsPerUsd, setById: auth.userId },
    });
    return toRate(row);
  }

  // ── Ajustes ─────────────────────────────────────────────────────────────────

  @Get('ajustes')
  @Public()
  @Endpoint({
    operationId: 'getSettings',
    summary: 'Reglas de reserva vigentes',
    tags: PUBLIC,
    responses: { 200: SettingsViewSchema },
  })
  getSettings() {
    return this.settings.get();
  }

  @Put('central/ajustes')
  @Can('settings')
  @Endpoint({
    operationId: 'setSettings',
    summary: 'Reemplaza las reglas de reserva',
    tags: CENTRAL,
    body: SettingsInput,
    responses: { 200: SettingsViewSchema },
  })
  async setSettings(
    @Body(new ZodPipe(SettingsInput)) input: z.infer<typeof SettingsInput>,
    @Trail() trail: AuditTrail,
  ) {
    trail.before = await this.settings.get();
    return this.settings.set(input);
  }
}

type PointView = z.infer<typeof BoardingPointSchema>;
type ThemeView = z.infer<typeof ThemeSchema>;

const POINT = { id: true, city: true, name: true, address: true, lat: true, lng: true } as const;
const THEME = { id: true, slug: true, name: true, description: true } as const;
const toRate = (row: { date: Date; bsPerUsd: unknown }) => ({
  date: row.date.toISOString().slice(0, 10),
  bsPerUsd: Number(row.bsPerUsd),
});
