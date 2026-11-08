import { type ProductSheet, ProductSheetSchema, type ProductType } from './product.ts';

const randomUUID = () => globalThis.crypto.randomUUID();

/**
 * Ficha completa de ejemplo, lista para publicar. La usan las pruebas y los datos de
 * demostración. `photoIds` y `destinationId` deben existir en la base.
 */
export function exampleSheet(
  type: ProductType,
  refs: { destinationId: string; photoIds: string[] },
): ProductSheet {
  const days = type === 'tour' ? 3 : 1;
  const nights = type === 'tour' ? 2 : 0;
  const meals =
    type === 'excursion'
      ? []
      : Array.from({ length: days }, (_, i) => ({
          id: randomUUID(),
          day: i + 1,
          moment: 'lunch' as const,
          mode: 'choice' as const,
          options: [
            { id: randomUUID(), name: 'Pescado frito', isDefault: true },
            { id: randomUUID(), name: 'Pollo a la plancha', limit: 20 },
          ],
        }));
  return ProductSheetSchema.parse({
    general: {
      title: type === 'tour' ? 'Los Roques en tres días' : 'Fullday a Cayo Sombrero',
      summary: 'Playas de arena blanca, agua cristalina y almuerzo frente al mar.',
      description:
        'Salimos temprano, navegamos entre cayos y pasamos el día en la playa con toldo, hidratación y almuerzo. Regresamos al atardecer.',
      category: 'beach',
      destinationId: refs.destinationId,
      photoIds: refs.photoIds,
      tags: ['family', 'friends'],
    },
    duration: type === 'excursion' ? { days: 1, hours: 4 } : { days, nights },
    itinerary: Array.from({ length: days }, (_, i) => ({
      day: i + 1,
      time: '06:00',
      title: `Día ${i + 1}: salida y playa`,
    })),
    transfer: {
      vehicle: type === 'excursion' ? 'none' : 'bus',
      boardingPoints: [
        {
          id: randomUUID(),
          name: 'Plaza Venezuela',
          city: 'Caracas',
          departureTime: '05:00',
          returnTime: '19:00',
        },
        {
          id: randomUUID(),
          name: 'C.C. Las Américas',
          city: 'Maracay',
          departureTime: '06:00',
          returnTime: '18:00',
          priceDeltaUsd: -5,
        },
      ],
    },
    meals,
    items: [
      { id: randomUUID(), type: 'hydration', name: 'Agua y refrescos', modality: 'included' },
      { id: randomUUID(), type: 'shade', name: 'Toldo', modality: 'included' },
      {
        id: randomUUID(),
        type: 'access',
        name: 'Tasa del parque',
        modality: 'pay_at_destination',
        priceUsd: 5,
        payment: 'cash_usd',
      },
    ],
    lodging:
      type === 'tour'
        ? {
            name: 'Posada El Botuto',
            regime: 'full_board',
            rooms: [
              { id: randomUUID(), type: 'double', occupancy: 2, quantity: 6 },
              { id: randomUUID(), type: 'shared', occupancy: 1, priceDeltaUsd: -20 },
            ],
          }
        : null,
    whatToBring: ['Traje de baño', 'Protector solar'],
    pricing: {
      fares: { adult: type === 'tour' ? 450 : 45, child: type === 'tour' ? 350 : 35 },
      deposit: { kind: 'percent', value: 30 },
      balanceDueDaysBefore: 2,
      cancellation: { template: 'moderate' },
    },
  });
}
