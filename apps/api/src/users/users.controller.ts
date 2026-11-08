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
} from '@nestjs/common';
import type { PrismaClient, Passenger as PassengerRow } from '@fulldays/db';
import { providerPermissions, staffPermissions } from '@fulldays/shared';
import type { z } from 'zod';
import { conflict, notFound } from '../common/api-exception.ts';
import { isUuid } from '../common/db.ts';
import { Endpoint } from '../common/endpoint.ts';
import { Auth, type AuthContext } from '../common/request.ts';
import { DB } from '../common/tokens.ts';
import { ZodPipe } from '../common/zod.pipe.ts';
import {
  type Me,
  MeSchema,
  type Passenger,
  PassengerInput,
  PassengerListSchema,
  PassengerSchema,
  ProfileUpdateInput,
} from './users.schemas.ts';

const TAG = ['yo'];
/** Tope de pasajeros frecuentes por persona. */
const MAX_PASSENGERS = 30;

/** La cuenta de quien llama: perfil, pertenencias y pasajeros frecuentes. */
@Controller('yo')
export class UsersController {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  @Get()
  @Endpoint({
    operationId: 'getMe',
    summary: 'Mi cuenta, mis agencias con su rol y mis roles de Central',
    tags: TAG,
    responses: { 200: MeSchema },
  })
  async me(@Auth() auth: AuthContext): Promise<Me> {
    return this.load(auth.userId);
  }

  @Patch()
  @Endpoint({
    operationId: 'updateMe',
    summary: 'Cambia mi nombre o mi teléfono',
    tags: TAG,
    body: ProfileUpdateInput,
    responses: { 200: MeSchema },
  })
  async update(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(ProfileUpdateInput)) input: z.infer<typeof ProfileUpdateInput>,
  ): Promise<Me> {
    await this.db.user.update({ where: { id: auth.userId }, data: input });
    return this.load(auth.userId);
  }

  @Get('pasajeros')
  @Endpoint({
    operationId: 'listPassengers',
    summary: 'Mis pasajeros frecuentes',
    tags: TAG,
    responses: { 200: PassengerListSchema },
  })
  async passengers(@Auth() auth: AuthContext): Promise<{ items: Passenger[] }> {
    const rows = await this.db.passenger.findMany({
      where: { userId: auth.userId },
      orderBy: { name: 'asc' },
    });
    return { items: rows.map(toPassenger) };
  }

  @Post('pasajeros')
  @HttpCode(201)
  @Endpoint({
    operationId: 'createPassenger',
    summary: 'Guarda un pasajero frecuente',
    tags: TAG,
    body: PassengerInput,
    responses: { 201: PassengerSchema },
  })
  async createPassenger(
    @Auth() auth: AuthContext,
    @Body(new ZodPipe(PassengerInput)) input: z.infer<typeof PassengerInput>,
  ): Promise<Passenger> {
    const count = await this.db.passenger.count({ where: { userId: auth.userId } });
    if (count >= MAX_PASSENGERS) {
      throw conflict(
        `Puedes guardar hasta ${MAX_PASSENGERS} pasajeros. Borra alguno para agregar otro.`,
      );
    }
    const row = await this.db.passenger.create({
      data: { ...input, birthDate: new Date(`${input.birthDate}T00:00:00Z`), userId: auth.userId },
    });
    return toPassenger(row);
  }

  @Put('pasajeros/:passengerId')
  @Endpoint({
    operationId: 'updatePassenger',
    summary: 'Cambia un pasajero frecuente',
    tags: TAG,
    body: PassengerInput,
    responses: { 200: PassengerSchema },
  })
  async updatePassenger(
    @Auth() auth: AuthContext,
    @Param('passengerId') passengerId: string,
    @Body(new ZodPipe(PassengerInput)) input: z.infer<typeof PassengerInput>,
  ): Promise<Passenger> {
    const owned = await this.owned(auth.userId, passengerId);
    const row = await this.db.passenger.update({
      where: { id: owned.id },
      data: { ...input, birthDate: new Date(`${input.birthDate}T00:00:00Z`) },
    });
    return toPassenger(row);
  }

  @Delete('pasajeros/:passengerId')
  @HttpCode(204)
  @Endpoint({
    operationId: 'deletePassenger',
    summary: 'Borra un pasajero frecuente',
    tags: TAG,
    responses: { 204: null },
  })
  async deletePassenger(
    @Auth() auth: AuthContext,
    @Param('passengerId') passengerId: string,
  ): Promise<void> {
    const owned = await this.owned(auth.userId, passengerId);
    await this.db.passenger.delete({ where: { id: owned.id } });
  }

  private async owned(userId: string, passengerId: string): Promise<PassengerRow> {
    if (!isUuid(passengerId)) throw notFound();
    const row = await this.db.passenger.findFirst({ where: { id: passengerId, userId } });
    if (!row) throw notFound();
    return row;
  }

  private async load(userId: string): Promise<Me> {
    const user = await this.db.user.findUnique({
      where: { id: userId },
      include: {
        memberships: { include: { provider: true }, orderBy: { createdAt: 'asc' } },
        staffRoles: { orderBy: { createdAt: 'asc' } },
      },
    });
    if (!user) throw notFound();
    const roles = user.staffRoles.map((s) => s.role);
    return {
      id: user.id,
      email: user.email,
      name: user.name,
      phone: user.phone,
      hasPassword: user.passwordHash !== null,
      hasGoogle: user.googleId !== null,
      memberships: user.memberships.map((m) => ({
        providerId: m.providerId,
        providerName: m.provider.name,
        providerStatus: m.provider.status,
        role: m.role,
        permissions: providerPermissions(m.role),
      })),
      staff: { roles, permissions: staffPermissions(roles) },
    };
  }
}

function toPassenger(row: PassengerRow): Passenger {
  return {
    id: row.id,
    name: row.name,
    cedula: row.cedula,
    birthDate: row.birthDate.toISOString().slice(0, 10),
    restrictions: row.restrictions,
  };
}
