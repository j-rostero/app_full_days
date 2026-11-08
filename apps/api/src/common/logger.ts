import { ConsoleLogger } from '@nestjs/common';

/** En producción el registro sale en JSON, una línea por evento, para el recolector de logs. */
export const productionLogger = () =>
  process.env.NODE_ENV === 'production' ? new ConsoleLogger({ json: true }) : undefined;
