import { Inject, Injectable } from '@nestjs/common';
import type { PrismaClient } from '@fulldays/db';
import { DEFAULT_SETTINGS, type Settings, SettingsSchema } from '@fulldays/shared';
import { DB } from '../common/tokens.ts';

/** Reglas de reserva ajustables. Mientras Central no guarde nada valen las de fábrica. */
@Injectable()
export class SettingsService {
  constructor(@Inject(DB) private readonly db: PrismaClient) {}

  async get(): Promise<Settings> {
    const row = await this.db.setting.findUnique({ where: { id: 1 } });
    const parsed = SettingsSchema.safeParse({
      ...DEFAULT_SETTINGS,
      ...((row?.value as object | null) ?? {}),
    });
    return parsed.success ? parsed.data : DEFAULT_SETTINGS;
  }

  async set(value: Settings): Promise<Settings> {
    await this.db.setting.upsert({ where: { id: 1 }, create: { id: 1, value }, update: { value } });
    return value;
  }
}
