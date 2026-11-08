import {
  BoardingPointInputSchema,
  DestinationFeeInputSchema,
  DestinationInputSchema,
  PAYMENT_METHODS,
  RateInputSchema,
  SettingsSchema,
  ThemeInputSchema,
} from '@fulldays/shared';
import { z } from 'zod';

export const DestinationInput = DestinationInputSchema.meta({ id: 'DestinationInput' });
export const DestinationUpdateInput = DestinationInputSchema.partial().meta({
  id: 'DestinationUpdateInput',
});
export const DestinationFeeInput = DestinationFeeInputSchema.meta({ id: 'DestinationFeeInput' });
export const BoardingPointInput = BoardingPointInputSchema.meta({ id: 'BoardingPointInput' });
export const BoardingPointUpdateInput = BoardingPointInputSchema.partial().meta({
  id: 'BoardingPointUpdateInput',
});
export const ThemeInput = ThemeInputSchema.meta({ id: 'ThemeInput' });
export const ThemeUpdateInput = ThemeInputSchema.partial().meta({ id: 'ThemeUpdateInput' });
export const RateInput = RateInputSchema.meta({ id: 'RateInput' });
export const SettingsInput = SettingsSchema.meta({ id: 'SettingsInput' });

const FeeSchema = z
  .object({ id: z.uuid(), name: z.string(), amountUsd: z.number(), payment: z.string() })
  .meta({ id: 'DestinationFee' });
const Place = {
  id: z.uuid(),
  slug: z.string(),
  name: z.string(),
  state: z.string(),
  region: z.string(),
  lat: z.number().nullable(),
  lng: z.number().nullable(),
  fees: z.array(FeeSchema),
};
export const SiteSchema = z.object(Place).meta({ id: 'Site' });
export const DestinationSchema = z
  .object({ ...Place, sites: z.array(SiteSchema) })
  .meta({ id: 'Destination' });
export const DestinationListSchema = z
  .object({ items: z.array(DestinationSchema) })
  .meta({ id: 'DestinationList' });

export const BoardingPointSchema = z
  .object({
    id: z.uuid(),
    city: z.string(),
    name: z.string(),
    address: z.string(),
    lat: z.number().nullable(),
    lng: z.number().nullable(),
  })
  .meta({ id: 'BoardingPoint' });
export const BoardingPointListSchema = z
  .object({ items: z.array(BoardingPointSchema) })
  .meta({ id: 'BoardingPointList' });
export const BoardingPointQuery = z.strictObject({ city: z.string().trim().max(80).optional() });

export const ThemeSchema = z
  .object({ id: z.uuid(), slug: z.string(), name: z.string(), description: z.string() })
  .meta({ id: 'TravelTheme' });
export const ThemeListSchema = z.object({ items: z.array(ThemeSchema) }).meta({ id: 'ThemeList' });

export const RateSchema = z
  .object({ date: z.iso.date(), bsPerUsd: z.number() })
  .meta({ id: 'Rate' });
export const RateListSchema = z.object({ items: z.array(RateSchema) }).meta({ id: 'RateList' });

export const SettingsViewSchema = SettingsSchema.extend({
  paymentMethods: z.array(z.enum(Object.keys(PAYMENT_METHODS) as [keyof typeof PAYMENT_METHODS])),
}).meta({ id: 'Settings' });
