/**
 * Da el rol `super` de Central a una persona por su correo (crea la cuenta si no existe; al
 * registrarse con ese correo la confirma y elige su contraseña). Es la única forma de tener
 * el primer super:
 *
 *   pnpm --filter @fulldays/api grant-super ana@ejemplo.com
 */
import { createDb } from '@fulldays/db';
import { EmailSchema } from '@fulldays/shared';
import { loadConfig } from '../config.ts';

const email = EmailSchema.safeParse(process.argv[2]);
if (!email.success) {
  console.error('Uso: grant-super <correo>');
  process.exit(1);
}
const db = createDb(loadConfig().DATABASE_URL);
try {
  const user = await db.user.upsert({
    where: { email: email.data },
    create: { email: email.data },
    update: {},
  });
  await db.staffMember.upsert({
    where: { userId_role: { userId: user.id, role: 'super' } },
    create: { userId: user.id, role: 'super' },
    update: {},
  });
  console.log(`${email.data} ahora es super de Central.`);
} finally {
  await db.$disconnect();
}
