# API (`apps/api`)

Documentación técnica del backend: cómo arranca, cómo procesa cada petición y qué hace cada módulo, con sus endpoints, reglas, tablas, tareas en segundo plano y errores. Todo lo descrito sale del código actual; cada sección cita los archivos que lo implementan.

Documentos relacionados:

- [Arquitectura de la API](../arquitectura/api.md): convenciones y resumen por área.
- [Modelo de datos](../arquitectura/modelo-de-datos.md): tablas y columnas.
- [Seguridad y datos personales](../arquitectura/seguridad.md).
- [Entornos](../arquitectura/entornos.md): cómo levantar todo en local y en la nube.
- [Paquetes compartidos](paquetes.md), [webs](webs.md), [apps móviles](apps-moviles.md) e [integración entre subproyectos](integracion.md).

## Contenido

1. [Visión general y stack](#visión-general-y-stack)
2. [Arranque y configuración](#arranque-y-configuración)
3. [Canal de una petición](#canal-de-una-petición)
4. [Módulos](#módulos)
5. [Tareas en segundo plano](#tareas-en-segundo-plano)
6. [Comandos de línea de comandos](#comandos-de-línea-de-comandos)
7. [Pruebas](#pruebas)
8. [Contrato OpenAPI y cliente generado](#contrato-openapi-y-cliente-generado)
9. [Lo que todavía no está](#lo-que-todavía-no-está)

## Visión general y stack

`@salimos/api` es un único proceso HTTP que sirve a todos los clientes: la web pública, Salimos Pro (web y app de agencias y guías), Salimos Central (web interna) y la app de viajeros. No hay servicios separados: cada área del negocio es un módulo de NestJS dentro del mismo proceso.

| Pieza                        | Uso                                                                                            | Dónde                                                                      |
| ---------------------------- | ---------------------------------------------------------------------------------------------- | -------------------------------------------------------------------------- |
| NestJS 12 sobre Express      | Controladores, inyección de dependencias, guards, interceptores                                | `apps/api/src/app.module.ts`                                               |
| Zod 4                        | Validación de entradas y fuente de los esquemas OpenAPI                                        | `apps/api/src/common/zod.pipe.ts`, `apps/api/src/openapi.ts`               |
| Prisma 7 + PostgreSQL        | Datos de negocio, con adaptador `@prisma/adapter-pg`                                           | `packages/db/src/index.ts`, `packages/db/prisma/schema.prisma`             |
| Redis (ioredis)              | Límite de peticiones, códigos de un solo uso, sesiones revocadas, intentos fallidos            | `apps/api/src/common/redis.ts`, `apps/api/src/common/throttler-storage.ts` |
| Almacenamiento S3 compatible | Imágenes y documentos privados, con subida firmada                                             | `apps/api/src/files/storage.service.ts`                                    |
| imgproxy                     | Sirve las imágenes redimensionadas con URL firmadas                                            | `apps/api/src/files/storage.service.ts`                                    |
| jose                         | Tokens de acceso JWT HS256 y verificación de tokens de Google                                  | `apps/api/src/auth/token.service.ts`, `apps/api/src/auth/google.ts`        |
| nodemailer                   | Envío de códigos por SMTP                                                                      | `apps/api/src/auth/otp-sender.ts`                                          |
| `@salimos/shared`            | Reglas puras compartidas con las apps: precios, estados, permisos, firma de vouchers, búsqueda | `packages/shared/src/*.ts`                                                 |
| `@salimos/db`                | Cliente Prisma y cliente limitado a una agencia (`scopeToProvider`)                            | `packages/db/src/scope.ts`                                                 |

Las reglas que también necesitan las apps (cotizar una reserva, transiciones de estado, reembolsos, permisos por rol, completitud de la ficha) viven en `@salimos/shared` y la API las aplica; así la web, la app y el servidor calculan lo mismo. Ver [paquetes](paquetes.md).

### Mapa de módulos

```mermaid
flowchart LR
  subgraph Global
    Core[CoreModule<br/>CONFIG · DB · REDIS]
    Settings[SettingsModule]
    Notif[NotificationsModule]
  end
  Auth[AuthModule] --> Core
  Users[UsersModule]
  Access[AccessModule]
  Audit[AuditModule]
  Files[FilesModule<br/>StorageService]
  Providers[ProvidersModule] --> Files
  Catalogs[CatalogsModule]
  Fulldays[FulldaysModule] --> Files
  Fulldays -.-> Notif
  Bookings[BookingsModule<br/>BookingsService] -.-> Settings
  Departures[DeparturesModule] --> Bookings
  Departures -.-> Notif
  Search[SearchModule] --> Files
  Themes[ThemesModule]
  Rates[RatesModule]
  Payments[PaymentsModule<br/>PaymentsService] --> Bookings
  Payments --> Files
  Payments -.-> Notif
  TripDay[TripDayModule] --> Bookings
  TripDay -.-> Notif
  PostTrip[PostTripModule] --> Auth
  PostTrip -.-> Notif
```

Las flechas continuas son `imports` explícitos; las punteadas, módulos globales (`@Global()`) que se inyectan sin importarlos: `SettingsModule` (`apps/api/src/settings/settings.module.ts`) y `NotificationsModule` (`apps/api/src/notifications/notifications.service.ts`). `CoreModule` (`apps/api/src/common/core.module.ts`) también es global y expone `CONFIG`, `DB` y `REDIS` a todos.

## Arranque y configuración

### Proceso de arranque

`apps/api/src/main.ts`:

1. Carga el `.env` de la raíz del repositorio si existe (`process.loadEnvFile`); si no, valen los valores por defecto, que coinciden con `infra/docker`.
2. Valida el entorno con `loadConfig()` (`apps/api/src/config.ts`). Un valor inválido detiene el proceso antes de abrir el puerto.
3. Crea la aplicación con `AppModule.register(config)`; en producción el registro es JSON (`ConsoleLogger({ json: true })`).
4. Aplica `configureApp()` (`apps/api/src/app.setup.ts`), activa los hooks de apagado (cierran Redis y Prisma en `CoreModule`) y, fuera de producción, publica la documentación interactiva Swagger en `/docs`.
5. Escucha en `PORT`.

`configureApp()` es compartido por el servidor, las pruebas y la exportación del contrato, de modo que los tres se comportan igual:

- Mensajes de error de Zod en español (`z.config(z.locales.es())`).
- Versionado por URI con versión por defecto `1`: todo vive bajo `/v1`, salvo controladores marcados `VERSION_NEUTRAL` (solo `/salud`).
- CORS limitado a `CORS_ORIGINS`.
- Sin `X-Powered-By`; cabeceras `X-Content-Type-Options: nosniff`, `X-Frame-Options: DENY` y `Referrer-Policy: no-referrer` en todas las respuestas.
- Filtro global de errores `ApiErrorFilter`.
- `trust proxy` = `TRUST_PROXY`, y el límite de las rutas de acceso (`AUTH_RATE_LIMIT_PER_MINUTE`) guardado como ajuste de Express para que lo lean los decoradores de `AuthController`.

`AppModule` (`apps/api/src/app.module.ts`) registra `ThrottlerModule` con almacenamiento en Redis y los guards e interceptor globales descritos en [Canal de una petición](#canal-de-una-petición).

### Variables de entorno

Todas se validan en `apps/api/src/config.ts`. Las listas separadas por comas se convierten en arreglos.

| Variable                          | Por defecto                                                                 | Significado                                                                                                                                                                                                         |
| --------------------------------- | --------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `NODE_ENV`                        | `development`                                                               | `development`, `test` o `production`. Activa las comprobaciones de producción.                                                                                                                                      |
| `PORT`                            | `4000`                                                                      | Puerto HTTP.                                                                                                                                                                                                        |
| `DATABASE_URL`                    | `postgresql://salimos:salimos@localhost:5432/salimos`                       | PostgreSQL.                                                                                                                                                                                                         |
| `REDIS_URL`                       | `redis://localhost:6379`                                                    | Redis. La conexión es perezosa (`lazyConnect`) para que exportar el contrato no necesite Redis.                                                                                                                     |
| `CORS_ORIGINS`                    | `http://localhost:3100,3101,3102,3010,3011` (cada una como origen completo) | Orígenes de navegador admitidos. También se usa como CORS de los buckets al crearlos en local.                                                                                                                      |
| `TRUST_PROXY`                     | `0`                                                                         | Número de proxies delante de la API. Sin el valor correcto el límite de peticiones ve la IP del proxy.                                                                                                              |
| `RATE_LIMIT_PER_MINUTE`           | `120`                                                                       | Peticiones por minuto y por IP en toda la API.                                                                                                                                                                      |
| `AUTH_RATE_LIMIT_PER_MINUTE`      | `20`                                                                        | Peticiones por minuto y por IP en registrar, verificar, entrar, recuperar, restablecer y Google.                                                                                                                    |
| `JWT_SECRET`                      | secreto de desarrollo                                                       | Firma los tokens de acceso; también es la clave HMAC de los códigos y de la rotación de tokens de renovación. Mínimo 32 caracteres.                                                                                 |
| `ACCESS_TOKEN_MINUTES`            | `15`                                                                        | Vida del token de acceso.                                                                                                                                                                                           |
| `REFRESH_TOKEN_DAYS`              | `60`                                                                        | Vida de la sesión desde la última renovación.                                                                                                                                                                       |
| `OTP_SENDER`                      | `log`                                                                       | `log` imprime el código en la salida; `smtp` lo envía por `SMTP_URL`.                                                                                                                                               |
| `SMTP_URL`                        | `smtp://localhost:1025`                                                     | Servidor SMTP (Mailpit en local).                                                                                                                                                                                   |
| `MAIL_FROM`                       | `Salimos <no-responder@salimos.local>`                                      | Remitente de los correos.                                                                                                                                                                                           |
| `GOOGLE_CLIENT_IDS`               | vacío                                                                       | Client ids de Google cuyos tokens se aceptan. Vacío: entrar con Google está apagado.                                                                                                                                |
| `NOTIFICATION_SENDER`             | `log`                                                                       | Único valor admitido hoy: `log`. Ver **Todavía no** en [Notificaciones](#notificaciones).                                                                                                                           |
| `MONEY_MODEL`                     | `direct`                                                                    | Quién recibe el dinero del viajero: `direct` (la agencia) o `retained` (Salimos). Solo cambia los asientos del libro ([ADR-F4-003](../fases/F4-reserva-y-pagos/decisiones/ADR-F4-003-pagos-reportados-y-libro.md)). |
| `COMMISSION_PERCENT`              | `0`                                                                         | Comisión de la plataforma sobre cada pago confirmado (0 a 50). Una agencia puede tener la suya.                                                                                                                     |
| `MAX_HELD_BOOKINGS`               | `3`                                                                         | Reservas apartadas sin pagar que un viajero puede tener a la vez.                                                                                                                                                   |
| `HOLD_MINUTES`                    | `15`                                                                        | Minutos de apartado por defecto (1 a 120), mientras Central no guarde ajustes.                                                                                                                                      |
| `EXPIRE_HOLDS_EVERY_SECONDS`      | `60`                                                                        | Periodo de los temporizadores de reservas y notificaciones. `0` los apaga (las pruebas los llaman a mano).                                                                                                          |
| `OTP_MAX_SENDS`                   | `3`                                                                         | Códigos por buzón cada 15 minutos.                                                                                                                                                                                  |
| `OTP_FIXED_CODE`                  | sin valor                                                                   | Seis dígitos fijos para pruebas de extremo a extremo.                                                                                                                                                               |
| `S3_ENDPOINT`                     | sin valor (fuera de producción: `http://localhost:9000`)                    | Servicio S3 compatible. Sin valor en producción se usa AWS S3.                                                                                                                                                      |
| `S3_REGION`                       | `us-east-1`                                                                 | Región.                                                                                                                                                                                                             |
| `S3_ACCESS_KEY` / `S3_SECRET_KEY` | sin valor (fuera de producción: `salimos` / `salimos-dev`)                  | Credenciales. Sin ellas se usa el rol de la máquina.                                                                                                                                                                |
| `S3_IMAGES_BUCKET`                | `salimos-images`                                                            | Bucket de imágenes.                                                                                                                                                                                                 |
| `S3_DOCUMENTS_BUCKET`             | `salimos-documents`                                                         | Bucket de documentos privados.                                                                                                                                                                                      |
| `IMAGES_URL`                      | `http://localhost:8082`                                                     | Dirección pública de imgproxy.                                                                                                                                                                                      |
| `IMGPROXY_KEY` / `IMGPROXY_SALT`  | valores de desarrollo (hex)                                                 | Firman las URL de imgproxy; deben coincidir con los de imgproxy.                                                                                                                                                    |
| `VOUCHER_SIGNING_KEY`             | semilla de desarrollo                                                       | Semilla Ed25519 (64 hex) que firma los vouchers.                                                                                                                                                                    |
| `VOUCHER_RETIRED_PUBLIC_KEYS`     | vacío                                                                       | Claves públicas retiradas como `id:clave`, para que los vouchers ya emitidos sigan validando.                                                                                                                       |

Con `NODE_ENV=production`, `loadConfig()` rechaza arrancar si:

| Variable                         | Condición rechazada               |
| -------------------------------- | --------------------------------- |
| `JWT_SECRET`                     | Es el secreto de desarrollo.      |
| `OTP_FIXED_CODE`                 | Tiene cualquier valor.            |
| `NOTIFICATION_SENDER`            | Es `log`.                         |
| `OTP_SENDER`                     | Es `log`.                         |
| `VOUCHER_SIGNING_KEY`            | Es la semilla de desarrollo.      |
| `IMGPROXY_KEY` / `IMGPROXY_SALT` | Alguno es el valor de desarrollo. |

**Todavía no:** como `NOTIFICATION_SENDER` solo acepta `log` y producción rechaza `log`, la API no puede arrancar hoy con `NODE_ENV=production`. Se resuelve cuando existan los proveedores reales de push y WhatsApp (ver [Notificaciones](#notificaciones)).

## Canal de una petición

```mermaid
flowchart TD
  R[Petición HTTP] --> H[Cabeceras de seguridad + CORS<br/>app.setup.ts]
  H --> V{Versión URI<br/>/v1 o neutral}
  V --> T[ThrottlerGuard<br/>Redis, por IP]
  T --> A[AuthGuard<br/>JWT + sesión no revocada<br/>salvo @Public]
  A --> X[AccessGuard<br/>por URL: /v1/pro/:providerId, /v1/central<br/>+ permiso de @Can]
  X --> I[AuditInterceptor<br/>solo escrituras en /v1/pro y /v1/central]
  I --> P[ZodPipe<br/>body / query]
  P --> C[Controlador y servicio<br/>DB completa o ScopedDb]
  C --> I2[AuditInterceptor escribe audit_log<br/>con before/after]
  I2 --> OK[Respuesta JSON]
  T -. 429 .-> E[ApiErrorFilter]
  A -. 401 .-> E
  X -. 403 .-> E
  P -. 400 validation_error .-> E
  C -. DomainError / 404 / 500 .-> E
  E --> ERR[ApiError JSON]
```

### Versionado

`app.enableVersioning({ type: URI, defaultVersion: '1' })` antepone `/v1` a cada controlador. El único endpoint fuera de versión es `GET /salud` (`apps/api/src/health.controller.ts`), marcado `VERSION_NEUTRAL`.

### Validación con Zod

`ZodPipe` (`apps/api/src/common/zod.pipe.ts`) valida y transforma una parte de la petición: `@Body(new ZodPipe(Schema))` o `@Query(new ZodPipe(Schema))`. Si falla, lanza `ValidationError` con una lista `issues` de `{ path, message }` (ruta con puntos, mensaje en español). Los esquemas usan `z.strictObject`, así que un campo desconocido también es error de validación. Los ids de la URL no pasan por Zod: los controladores comprueban que sean UUID y, si no lo son, responden 404 en vez de dejar fallar a la base de datos.

### Forma única de error

`ApiErrorSchema` (`apps/api/src/common/api-error.ts`) define la única forma de error y `ApiErrorFilter` (`apps/api/src/common/error.filter.ts`) convierte cualquier excepción en ella:

```json
{
  "statusCode": 409,
  "code": "conflict",
  "message": "No quedan suficientes puestos en esta salida."
}
```

| `code`               | Estado                            | Cuándo                                                                         |
| -------------------- | --------------------------------- | ------------------------------------------------------------------------------ |
| `validation_error`   | 400                               | `ZodPipe` o `ValidationError` lanzado por un controlador; trae `issues`.       |
| `bad_request`        | 400 y otros 4xx sin código propio | Petición mal formada.                                                          |
| `unauthorized`       | 401                               | Sin sesión, token inválido o sesión revocada; código o contraseña incorrectos. |
| `forbidden`          | 403                               | Sin permiso, o cuenta bloqueada.                                               |
| `not_found`          | 404                               | No existe o no es de quien pregunta.                                           |
| `conflict`           | 409                               | Regla de negocio incumplida (estado, cupos, duplicados).                       |
| `rate_limited`       | 429                               | Límite por IP, por buzón o por intentos fallidos.                              |
| `email_not_verified` | 403                               | Contraseña correcta pero correo sin confirmar; el cliente pide el código.      |
| `internal_error`     | 5xx                               | Cualquier fallo no previsto; el detalle va solo al registro.                   |

Los mensajes de framework y librerías no se reenvían nunca: se sustituyen por los textos fijos de `errorMessages`. La excepción es `DomainError(status, publicMessage, code?)`, cuyo mensaje está escrito para la persona usuaria y se envía tal cual. Los clientes deben ramificar por `code`, nunca por `message`. Ver también [ADR-F1-005](../fases/F1-fundamentos/decisiones/ADR-F1-005-convenciones-de-la-api.md).

### Guards, en el orden en que corren

Declarados en `AppModule` (`apps/api/src/app.module.ts`):

1. **`ThrottlerGuard`** (`@nestjs/throttler`): ventana fija de 60 s, `RATE_LIMIT_PER_MINUTE` por IP, con contadores compartidos en Redis (`RedisThrottlerStorage`, `apps/api/src/common/throttler-storage.ts`, script Lua `INCR` + `PEXPIRE`). Las rutas de acceso usan `@Throttle` con `AUTH_RATE_LIMIT_PER_MINUTE`. `/salud` tiene `@SkipThrottle()`.
2. **`AuthGuard`** (`apps/api/src/auth/auth.guard.ts`): cerrado por defecto. Todo endpoint exige `Authorization: Bearer <token>` salvo los marcados `@Public()`. Verifica el JWT y que la sesión no esté en la lista de revocadas de Redis; deja los datos en `request.auth` (`@Auth()` en los controladores).
3. **`AccessGuard`** (`apps/api/src/access/access.guard.ts`): decide por la URL, para que ninguna ruta quede fuera por olvidar un decorador.
   - `/v1/pro/:providerId/...`: exige ser miembro de esa agencia (`provider_members`) con un rol que tenga el permiso declarado con `@Can(...)`. Deja `request.membership` (`@Membership()`) y un cliente de base de datos limitado a esa agencia (`@ScopedDb()`).
   - `/v1/central/...`: exige roles de Central (`staff_members`) cuya suma de permisos incluya el de `@Can(...)`.
   - Un endpoint bajo esos prefijos sin `@Can` responde 403 a todo el mundo.
   - Cualquier otra ruta pasa sin comprobación de rol.

### Permisos por rol

Definidos en `packages/shared/src/access.ts` ([ADR-F1-007](../fases/F1-fundamentos/decisiones/ADR-F1-007-modelo-de-permisos.md)). Una persona de Central puede tener varios roles y sus permisos se suman.

| Rol de agencia | Permisos                                                                                                                   |
| -------------- | -------------------------------------------------------------------------------------------------------------------------- |
| `owner`        | Todos: `team`, `company`, `fulldays`, `departures`, `bookings`, `notices`, `payments`, `settlements`, `reports`, `checkin` |
| `operations`   | `fulldays`, `departures`, `bookings`, `notices`                                                                            |
| `finance`      | `payments`, `settlements`, `reports`                                                                                       |
| `guide`        | `checkin`, `notices`                                                                                                       |

| Rol de Central | Permisos                                                                                                                                                                                                         |
| -------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `super`        | Todos: `staff`, `audit`, `providers`, `users`, `bookings`, `claims`, `reviews`, `content`, `fulldays`, `catalogs`, `themes`, `commissions`, `payments`, `refunds`, `settlements`, `rates`, `settings`, `metrics` |
| `support`      | `users`, `bookings`, `claims`                                                                                                                                                                                    |
| `moderation`   | `reviews`, `content`, `fulldays`                                                                                                                                                                                 |
| `content`      | `catalogs`, `themes`                                                                                                                                                                                             |
| `finance`      | `commissions`, `payments`, `refunds`, `settlements`, `rates`, `metrics`                                                                                                                                          |

Los permisos `content`, `bookings`, `payments` y `refunds` de Central existen en el modelo pero ningún endpoint los exige todavía.

### Base de datos limitada por agencia

`scopeToProvider(db, providerId)` (`packages/db/src/scope.ts`) extiende el cliente Prisma: en las tablas con `providerId` (lista `PROVIDER_OWNED_MODELS`: miembros, auditoría, documentos, fulldays, salidas, reservas, pagos, libro, avisos, reembolsos, reseñas y reclamos) añade `AND providerId = <agencia>` a toda lectura, actualización y borrado, fuerza `providerId` en toda fila creada y borra cualquier intento de cambiar `providerId` en una actualización. Los endpoints de agencia usan este cliente (`@ScopedDb()`); un handler que olvide filtrar no puede ver datos de otra agencia.

Límite conocido (anotado en el código): no filtra lo que se alcanza a través de una relación de otro modelo (`include`). Ver [seguridad](../arquitectura/seguridad.md).

### Auditoría

`AuditInterceptor` (`apps/api/src/audit/audit.interceptor.ts`) registra en `audit_log` toda escritura exitosa (método distinto de GET, HEAD, OPTIONS) bajo `/v1/pro/` o `/v1/central/`: autor, ámbito (`provider` o `central`), agencia, acción (`MÉTODO /ruta/con/:parametros`), parámetros, cuerpo enviado, `before` y `after`. Por defecto `after` es el cuerpo de la respuesta. Los endpoints que cambian algo que ya existía reciben el objeto `@Trail()` y rellenan `trail.before` (y a veces `trail.after`, para guardar solo el estado y no un documento entero). Ver [ADR-F1-008](../fases/F1-fundamentos/decisiones/ADR-F1-008-auditoria.md).

La entrada se escribe después de la acción, fuera de su transacción: si esa escritura falla, la petición responde error pero la acción queda hecha (decisión anotada en el código).

## Módulos

Convenciones de las tablas de endpoints:

- **Quién**: `Público` (sin sesión), `Sesión` (cualquier persona con sesión), `Pro: permiso` (miembro de la agencia de la URL con ese permiso) o `Central: permiso`.
- Las rutas se escriben como en el contrato OpenAPI, con parámetros entre llaves.
- Los errores 400 de validación, 401 y 403 de los guards valen para todos y no se repiten.

### auth: cuentas, códigos y sesiones

Responsabilidad: crear cuentas con correo y contraseña, confirmar el buzón con un código de seis dígitos, entrar con contraseña o con Google, renovar y cerrar sesiones ([ADR-F1-006](../fases/F1-fundamentos/decisiones/ADR-F1-006-acceso-y-sesiones.md), [ADR-F6-004](../fases/F6-post-viaje-y-central/decisiones/ADR-F6-004-entrar-con-correo-y-contrasena.md)).

Archivos: `apps/api/src/auth/auth.controller.ts`, `auth.guard.ts`, `auth.module.ts`, `auth.schemas.ts`, `otp.service.ts`, `otp-sender.ts`, `password.ts`, `session.service.ts`, `token.service.ts`, `google.ts`.

| Método | Ruta                      | Quién   | Qué hace                                                                                          |
| ------ | ------------------------- | ------- | ------------------------------------------------------------------------------------------------- |
| POST   | `/v1/auth/registrar`      | Público | Crea o actualiza la cuenta sin confirmar con la contraseña dada y envía un código al correo. 204. |
| POST   | `/v1/auth/verificar`      | Público | Comprueba el código, marca el correo como confirmado y abre sesión.                               |
| POST   | `/v1/auth/entrar`         | Público | Entra con correo y contraseña.                                                                    |
| POST   | `/v1/auth/recuperar`      | Público | Envía un código para fijar una contraseña nueva. Responde 204 exista o no la cuenta.              |
| POST   | `/v1/auth/restablecer`    | Público | Fija la contraseña nueva con el código, cierra todas las demás sesiones y abre una.               |
| POST   | `/v1/auth/google`         | Público | Entra con un token de Google; crea la cuenta la primera vez.                                      |
| POST   | `/v1/auth/renovar`        | Público | Cambia un token de renovación por un par nuevo.                                                   |
| POST   | `/v1/auth/salir`          | Sesión  | Cierra la sesión de este dispositivo.                                                             |
| POST   | `/v1/auth/salir-de-todos` | Sesión  | Cierra las sesiones de todos los dispositivos de la persona.                                      |

Las respuestas de entrada (`SignedInSchema`) traen `accessToken`, `refreshToken`, `expiresIn` (segundos) y `user` (`id`, `email`, `name`, `phone`). Las seis primeras rutas tienen el límite `AUTH_RATE_LIMIT_PER_MINUTE`; `renovar` solo el global.

Reglas principales:

- **Registro.** Si el correo ya está confirmado: 409 "Ya hay una cuenta con ese correo…". Si existe sin confirmar (registro a medias o persona añadida a un equipo por correo), gana la contraseña más reciente: no vale nada hasta confirmar el código.
- **Contraseñas** (`password.ts`): scrypt con sal propia, guardadas como `scrypt$sal$clave`, normalizadas NFKC. Comparación en tiempo constante; si la cuenta no existe se compara contra un hash ficticio para tardar lo mismo.
- **Entrar.** Misma respuesta 401 para correo desconocido y contraseña errónea. Tras 10 fallos en 15 minutos por correo (`signin:failed:<correo>` en Redis) responde 429 incluso con la contraseña correcta. Contraseña correcta con correo sin confirmar: envía un código nuevo y responde 403 `email_not_verified`. Cuenta bloqueada (`users.blocked_at`): 403.
- **Códigos** (`otp.service.ts`): seis dígitos aleatorios (o `OTP_FIXED_CODE`), guardados en Redis solo como HMAC-SHA256 con `JWT_SECRET`, cinco minutos de vida, cinco intentos; se borran al acertar. Un buzón recibe como mucho `OTP_MAX_SENDS` códigos cada 15 minutos (429 al pasarse; en `recuperar` el exceso se calla para no revelar si la cuenta existe).
- **Envío de códigos** (`otp-sender.ts`): `LogOtpSender` los imprime; `SmtpOtpSender` envía el correo "`<código>` es tu código de Salimos" por `SMTP_URL`.
- **Google** (`google.ts`): verifica la firma contra las claves públicas de Google, el emisor, que la audiencia sea uno de `GOOGLE_CLIENT_IDS` y que `email_verified` sea verdadero. Une la cuenta por `googleId` o por correo; si se une a una cuenta cuyo correo nunca se confirmó, borra esa contraseña (pudo escribirla otra persona). Sin client ids: 409 "Entrar con Google todavía no está disponible."
- **Tokens de acceso** (`token.service.ts`): JWT HS256 con `sub` = usuario y `sid` = sesión, vida `ACCESS_TOKEN_MINUTES`.
- **Sesiones** (`session.service.ts`): una fila en `sessions` por dispositivo con el SHA-256 del token de renovación, el dispositivo (User-Agent, 200 caracteres) y la expiración. Cada renovación rota el token; el siguiente se deriva del anterior con HMAC, así que la misma renovación repetida (respuesta perdida, dos pestañas a la vez) recibe el mismo token. Presentar un token ya rotado dentro de los 60 s siguientes se trata como reintento; después, como robo: se revoca la sesión entera.
- **Revocación**: `revokedAt` en la fila y, para cortar los tokens de acceso aún vigentes, `revoked:<sesión>` en Redis durante la vida de un token de acceso. `AuthGuard` consulta esa clave en cada petición.

Tablas: `users`, `sessions`. Claves Redis: `otp:code:*`, `otp:sent:*`, `signin:failed:*`, `revoked:*`.

Errores propios: 401 "El código no es correcto o ya venció.", 401 "El correo o la contraseña no son correctos.", 403 `email_not_verified`, 403 cuenta bloqueada, 409 cuenta ya confirmada, 409 Google apagado, 429.

```mermaid
sequenceDiagram
  autonumber
  participant C as Cliente
  participant API as AuthController
  participant R as Redis
  participant DB as PostgreSQL
  participant M as OtpSender (log/SMTP)
  C->>API: POST /v1/auth/registrar {email, password}
  API->>DB: upsert users (passwordHash, sin emailVerifiedAt)
  API->>R: otp:sent (límite) + otp:code (HMAC, 5 min)
  API->>M: send(email, código)
  API-->>C: 204
  C->>API: POST /v1/auth/verificar {email, code}
  API->>R: hincrby attempts, compara HMAC, borra código
  API->>DB: users.emailVerifiedAt = ahora
  API->>DB: insert sessions (hash del refresh)
  API-->>C: 200 {accessToken, refreshToken, expiresIn, user}
  Note over C,API: Peticiones siguientes con Authorization: Bearer
  C->>API: POST /v1/auth/renovar {refreshToken}
  API->>DB: update sessions where tokenHash = hash(token) (rota)
  API-->>C: 200 {accessToken, refreshToken nuevo}
  C->>API: POST /v1/auth/salir
  API->>DB: sessions.revokedAt
  API->>R: SET revoked:<sesión> EX vida del token
  API-->>C: 204
```

### users: la persona y sus pasajeros frecuentes

Responsabilidad: los datos propios de la persona con sesión y su lista de pasajeros frecuentes. Toda consulta va filtrada por `auth.userId`.

Archivos: `apps/api/src/users/users.controller.ts`, `users.schemas.ts`, `users.module.ts`.

| Método | Ruta                    | Quién  | Qué hace                                                                                                                                                                |
| ------ | ----------------------- | ------ | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/yo`                | Sesión | La persona con sus membresías de agencia (agencia, rol, permisos) y, si es de Central, sus roles y permisos (`staff`, o `null`). Las apps deciden qué mostrar con esto. |
| PATCH  | `/v1/yo`                | Sesión | Cambia nombre y teléfono. El correo no se cambia aquí.                                                                                                                  |
| GET    | `/v1/yo/pasajeros`      | Sesión | Pasajeros frecuentes, en orden de alta.                                                                                                                                 |
| POST   | `/v1/yo/pasajeros`      | Sesión | Añade un pasajero (nombre, cédula opcional, fecha de nacimiento, restricciones).                                                                                        |
| PUT    | `/v1/yo/pasajeros/{id}` | Sesión | Reemplaza los datos; los campos omitidos se vacían.                                                                                                                     |
| DELETE | `/v1/yo/pasajeros/{id}` | Sesión | Borra un pasajero.                                                                                                                                                      |

Tablas: `users`, `passengers`; lee `provider_members`, `providers`, `staff_members`. Errores: 404 si el pasajero no existe o es de otra persona.

### access: equipos de agencia y equipo de Central

Responsabilidad: el `AccessGuard` descrito arriba, la gestión del equipo de cada agencia y la del equipo interno de Central.

Archivos: `apps/api/src/access/access.guard.ts`, `team.controller.ts`, `staff.controller.ts`, `access.schemas.ts`, `access.module.ts`.

| Método | Ruta                                     | Quién            | Qué hace                                                                                                                                           |
| ------ | ---------------------------------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/pro/{providerId}/equipo`            | Pro: `team`      | Miembros de la agencia con su rol.                                                                                                                 |
| POST   | `/v1/pro/{providerId}/equipo`            | Pro: `team`      | Añade a una persona por correo con un rol. Si no tiene cuenta, se crea la fila de usuario y ella la completa después registrándose con ese correo. |
| PATCH  | `/v1/pro/{providerId}/equipo/{memberId}` | Pro: `team`      | Cambia el rol de un miembro.                                                                                                                       |
| DELETE | `/v1/pro/{providerId}/equipo/{memberId}` | Pro: `team`      | Quita a un miembro.                                                                                                                                |
| GET    | `/v1/central/equipo`                     | Central: `staff` | Personas con algún rol de Central.                                                                                                                 |
| PUT    | `/v1/central/equipo`                     | Central: `staff` | Fija los roles de Central de la persona con ese correo; lista vacía la saca de Central.                                                            |

Reglas:

- Una agencia debe tener al menos un dueño: cambiar o quitar al último `owner` da 409. La comprobación corre dentro de una transacción con `SELECT … FOR UPDATE` sobre la fila de la agencia, para que dos cambios simultáneos no la burlen.
- Central debe tener al menos un Super: 409 "Central debe tener al menos un Super." La comprobación usa `pg_advisory_xact_lock(hashtext('central-staff'))`.
- No hay alta pública en Central: el primer Super se crea con el comando `grant-super` (ver [Comandos](#comandos-de-línea-de-comandos)).

Tablas: `provider_members`, `staff_members`, `users`. Errores: 409 "Esa persona ya está en el equipo.", 409 último dueño, 409 último Super, 404 miembro inexistente.

### audit: lectura de la auditoría

Responsabilidad: leer `audit_log`. La escritura la hace el interceptor global (ver [Auditoría](#auditoría)).

Archivos: `apps/api/src/audit/audit.controller.ts`, `audit.interceptor.ts`, `audit.module.ts`.

| Método | Ruta                    | Quién            | Qué hace                                                                                                                                                                                     |
| ------ | ----------------------- | ---------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/central/auditoria` | Central: `audit` | Entradas de la más nueva a la más vieja, con autor. Parámetros: `limit` (1 a 100, por defecto 50), `before` (id de la última vista, para paginar) y `providerId`. Devuelve `items` y `next`. |

Los ids son UUID v7, así que ordenar por id es ordenar por tiempo. Tablas: `audit_log`, `users`.

### providers: agencias y su verificación

Responsabilidad: alta de agencias, sus datos y documentos de verificación, la revisión en Central y la comisión por agencia ([ADR-F0-003](../fases/F0-preparacion/decisiones/ADR-F0-003-proveedores-sin-rtn.md), [ADR-F0-006](../fases/F0-preparacion/decisiones/ADR-F0-006-comision.md)).

Archivos: `apps/api/src/providers/providers.controller.ts`, `verification.controller.ts`, `providers.schemas.ts`, `providers.module.ts`; validación de entrada en `packages/shared/src/providers.ts`.

| Método | Ruta                                           | Quién                  | Qué hace                                                                                                                                                                          |
| ------ | ---------------------------------------------- | ---------------------- | --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| POST   | `/v1/proveedores`                              | Sesión                 | Registra una agencia (persona o empresa, nombre, razón social, RIF, RTN opcional, ciudad base, teléfono, Instagram, instrucciones de pago). Quien la registra queda como `owner`. |
| GET    | `/v1/pro/{providerId}/empresa`                 | Pro: `company`         | Datos de la agencia, estado, motivo y distintivo.                                                                                                                                 |
| PATCH  | `/v1/pro/{providerId}/empresa`                 | Pro: `company`         | Cambia datos, salvo el RIF.                                                                                                                                                       |
| POST   | `/v1/pro/{providerId}/empresa/enviar`          | Pro: `company`         | Envía la agencia a verificación (`in_review`).                                                                                                                                    |
| GET    | `/v1/pro/{providerId}/documentos`              | Pro: `company`         | Documentos adjuntos, con enlace de descarga de cinco minutos.                                                                                                                     |
| POST   | `/v1/pro/{providerId}/documentos`              | Pro: `company`         | Adjunta un archivo propio ya subido (`kind=document`, `ready`) como documento de un tipo.                                                                                         |
| DELETE | `/v1/pro/{providerId}/documentos/{documentId}` | Pro: `company`         | Quita un documento.                                                                                                                                                               |
| GET    | `/v1/central/proveedores`                      | Central: `providers`   | Cola de agencias por estado, la más antigua primero (máximo 200).                                                                                                                 |
| GET    | `/v1/central/proveedores/{id}`                 | Central: `providers`   | Detalle con documentos descargables y dueños.                                                                                                                                     |
| POST   | `/v1/central/proveedores/{id}/aprobar`         | Central: `providers`   | `in_review` o `suspended` → `approved`.                                                                                                                                           |
| POST   | `/v1/central/proveedores/{id}/rechazar`        | Central: `providers`   | `in_review` → `rejected`, con motivo.                                                                                                                                             |
| POST   | `/v1/central/proveedores/{id}/suspender`       | Central: `providers`   | `approved` → `suspended`, con motivo.                                                                                                                                             |
| PUT    | `/v1/central/proveedores/{id}/comision`        | Central: `commissions` | Fija la comisión propia de la agencia (0 a 50) o la quita (`null`) para volver a la de la plataforma.                                                                             |

Reglas:

- Estados de agencia: `pending` → `in_review` → `approved` / `rejected`; `approved` ↔ `suspended`. Cada cambio de Central es un `updateMany` condicionado al estado de origen, así que dos decisiones simultáneas no se pisan.
- Para enviar a revisión deben estar los documentos obligatorios (`REQUIRED_PROVIDER_DOCUMENTS`: RIF y cédula del representante); si faltan, 409 "Faltan documentos: …".
- Mientras está `in_review` no se pueden cambiar datos ni documentos (409).
- Distintivo público: `verified` si la agencia aprobada tiene RTN, `new` si no; `null` mientras no esté aprobada.
- Solo una agencia aprobada puede publicar fulldays; una agencia suspendida desaparece del catálogo público (las consultas públicas filtran `provider.status = 'approved'`).

Tablas: `providers`, `provider_members`, `provider_documents`, `files`. Errores: 409 RIF duplicado, 409 en revisión, 409 ya aprobada, 409 transición imposible, 409 archivo ya adjunto, 404.

### catalogs: destinos, tasas, puntos de embarque y platos

Responsabilidad: los catálogos base que usan los formularios de Pro y las páginas públicas ([ADR-F2-002](../fases/F2-proveedores-y-ficha/decisiones/ADR-F2-002-catalogos.md)).

Archivos: `apps/api/src/catalogs/catalogs.controller.ts`, `catalogs.schemas.ts`, `catalogs.module.ts`.

| Método | Ruta                                            | Quién               | Qué hace                                                                                    |
| ------ | ----------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------- |
| GET    | `/v1/catalogos/destinos`                        | Público             | Destinos de primer nivel con los sitios que contienen y sus tasas conocidas.                |
| GET    | `/v1/catalogos/puntos-de-embarque`              | Público             | Puntos de embarque; filtro opcional `city`.                                                 |
| GET    | `/v1/catalogos/platos`                          | Público             | Platos.                                                                                     |
| POST   | `/v1/central/catalogos/destinos`                | Central: `catalogs` | Crea un destino (slug, nombre, estado, región, coordenadas, destino superior opcional).     |
| PATCH  | `/v1/central/catalogos/destinos/{id}`           | Central: `catalogs` | Edita un destino.                                                                           |
| DELETE | `/v1/central/catalogos/destinos/{id}`           | Central: `catalogs` | Borra un destino; si tiene sitios dentro, 409.                                              |
| POST   | `/v1/central/catalogos/destinos/{id}/tasas`     | Central: `catalogs` | Añade una tasa (nombre, monto USD, forma de pago `cash_usd`, `cash_bs` o `mobile_payment`). |
| DELETE | `/v1/central/catalogos/tasas/{id}`              | Central: `catalogs` | Borra una tasa.                                                                             |
| POST   | `/v1/central/catalogos/puntos-de-embarque`      | Central: `catalogs` | Crea un punto (ciudad, nombre, dirección, coordenadas).                                     |
| PATCH  | `/v1/central/catalogos/puntos-de-embarque/{id}` | Central: `catalogs` | Edita un punto.                                                                             |
| DELETE | `/v1/central/catalogos/puntos-de-embarque/{id}` | Central: `catalogs` | Borra un punto.                                                                             |
| POST   | `/v1/central/catalogos/platos`                  | Central: `catalogs` | Crea un plato (nombre, descripción, vegetariano).                                           |
| PATCH  | `/v1/central/catalogos/platos/{id}`             | Central: `catalogs` | Edita un plato.                                                                             |
| DELETE | `/v1/central/catalogos/platos/{id}`             | Central: `catalogs` | Borra un plato.                                                                             |

Los errores de la base de datos se traducen en `writing()`: clave única (P2002) y clave foránea (P2003) → 409 con un texto para personas; registro inexistente (P2025) → 404.

Tablas: `destinations`, `destination_fees`, `boarding_points`, `dishes`. El comando `seed-catalogs` carga los catálogos iniciales.

### files: archivos e imágenes

Responsabilidad: subida directa al almacenamiento en tres pasos, descarga de documentos privados y URL firmadas de imágenes redimensionadas ([ADR-F1-009](../fases/F1-fundamentos/decisiones/ADR-F1-009-archivos-e-imagenes.md), [ADR-F0-011](../fases/F0-preparacion/decisiones/ADR-F0-011-almacenamiento-s3-local.md)).

Archivos: `apps/api/src/files/files.controller.ts`, `storage.service.ts`, `files.module.ts`. `StorageService` se exporta y lo usan providers, fulldays, search y payments.

| Método | Ruta                          | Quién  | Qué hace                                                                                                                                                                         |
| ------ | ----------------------------- | ------ | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| POST   | `/v1/archivos`                | Sesión | Declara un archivo (`kind` `image` con JPEG/PNG/WebP, o `document` con PDF/JPEG/PNG; tamaño hasta 10 MB) y devuelve la fila `pending` más la URL `PUT` firmada por diez minutos. |
| POST   | `/v1/archivos/{id}/confirmar` | Sesión | Comprueba con `HEAD` que lo subido tiene el tamaño y tipo declarados y marca el archivo `ready`. Si no coincide, borra objeto y fila y responde 409.                             |
| GET    | `/v1/archivos/{id}`           | Sesión | Archivo propio listo; para documentos, enlace de descarga de cinco minutos.                                                                                                      |

Reglas:

- Un archivo pertenece a quien lo subió (`uploaderId`); solo esa persona lo ve. Otros módulos lo adjuntan a sus registros (documentos de agencia, fotos de la ficha, comprobantes de pago).
- Tipo y tamaño forman parte de la firma de subida: no se puede subir otra cosa con la misma URL. SVG no se admite porque puede llevar scripts.
- Los dos buckets son privados. Los documentos salen con URL firmadas (`Content-Disposition: attachment`). Las imágenes salen solo por imgproxy con URL firmadas por HMAC (`IMGPROXY_KEY` + `IMGPROXY_SALT`) en los tamaños `sm`, `md`, `lg`, `xl`, que deben coincidir con `IMGPROXY_PRESETS` de la infraestructura.
- `ensureBuckets()` crea los buckets y su CORS de `PUT`; solo en local y pruebas, en la nube los crea Terraform.

Tabla: `files`.

**Todavía no:** los archivos `pending` que nunca se confirman y los `ready` que nadie adjunta no se limpian.

### fulldays: la ficha, su publicación y su revisión

Responsabilidad: la ficha del fullday que llena la agencia (un documento JSON validado por `FulldaySheetSchema`), su publicación y la revisión en Central ([ADR-F2-003](../fases/F2-proveedores-y-ficha/decisiones/ADR-F2-003-ficha-como-documento.md), [ADR-F2-004](../fases/F2-proveedores-y-ficha/decisiones/ADR-F2-004-completitud-y-revision.md)).

Archivos: `apps/api/src/fulldays/fulldays.controller.ts`, `fulldays.schemas.ts`, `fulldays.module.ts`; ficha, completitud y detección de contactos en `packages/shared/src/fullday.ts`.

| Método | Ruta                                                 | Quién               | Qué hace                                                                                               |
| ------ | ---------------------------------------------------- | ------------------- | ------------------------------------------------------------------------------------------------------ |
| GET    | `/v1/pro/{providerId}/fulldays`                      | Pro: `fulldays`     | Resumen de los fulldays de la agencia (estado, título, destino, completitud), el más reciente primero. |
| POST   | `/v1/pro/{providerId}/fulldays`                      | Pro: `fulldays`     | Crea un borrador, con ficha opcional.                                                                  |
| GET    | `/v1/pro/{providerId}/fulldays/{fulldayId}`          | Pro: `fulldays`     | Ficha completa con completitud por bloque, efectivo en destino y URL de las fotos.                     |
| PUT    | `/v1/pro/{providerId}/fulldays/{fulldayId}`          | Pro: `fulldays`     | Guarda la ficha entera con control de versión.                                                         |
| POST   | `/v1/pro/{providerId}/fulldays/{fulldayId}/publicar` | Pro: `fulldays`     | Publica, o envía a revisión cuando corresponde.                                                        |
| POST   | `/v1/pro/{providerId}/fulldays/{fulldayId}/pausar`   | Pro: `fulldays`     | `published` → `paused`.                                                                                |
| GET    | `/v1/central/fulldays`                               | Central: `fulldays` | Cola por estado, el cambio más antiguo primero (máximo 200), con nombre de la agencia.                 |
| GET    | `/v1/central/fulldays/{id}`                          | Central: `fulldays` | Ficha con agencia, contactos detectados en los textos, destacado y temáticas.                          |
| POST   | `/v1/central/fulldays/{id}/aprobar`                  | Central: `fulldays` | `in_review` → `published` y avisa al equipo de la agencia.                                             |
| POST   | `/v1/central/fulldays/{id}/devolver`                 | Central: `fulldays` | `in_review` → `draft` con motivo y avisa al equipo.                                                    |
| POST   | `/v1/central/fulldays/{id}/despublicar`              | Central: `fulldays` | `published` → `paused` con motivo, por contenido engañoso.                                             |

Reglas:

- Estados: `draft`, `in_review`, `published`, `paused`.
- **Guardar** es optimista: el cuerpo trae la `version` leída y el `updateMany` solo pasa si coincide; si no, 409 "Este fullday cambió en otra pestaña o dispositivo…". En `in_review` no se puede guardar. Un fullday publicado solo acepta fichas que sigan completas y sin datos de contacto; si no, hay que pausarlo.
- Las referencias de la ficha se comprueban: el destino debe existir y las fotos deben ser imágenes `ready` subidas por miembros de esta agencia, sin repetir (400 `validation_error`).
- Al guardar, las salidas que nadie ha reservado (`reserved = 0`, no canceladas) copian la ficha nueva, sus facetas de búsqueda y el precio; sus cupos de platos y habitaciones se borran para reconstruirse en la siguiente reserva. Las salidas con reservas conservan la ficha que se vendió.
- **Publicar** exige agencia aprobada y ficha sin faltantes (409 "Faltan datos para publicar: …"). Va a `in_review` en vez de `published` cuando la agencia no tiene RTN, cuando Central la devolvió antes (`statusReason` no nulo) o cuando los textos contienen teléfonos o enlaces de WhatsApp.
- Aprobar y devolver encolan una notificación (`fullday_approved`, `fullday_returned`) a cada miembro con permiso `fulldays`.

Tablas: `fulldays`, `departures`, `departure_quotas`, `destinations`, `files`, `providers`, `provider_members`; encola en `notifications`.

### departures: salidas y cupos

Responsabilidad: las fechas en que corre un fullday, con cupo, mínimo, precio, estado y guías asignados ([ADR-F3-002](../fases/F3-salidas-busqueda-y-catalogo/decisiones/ADR-F3-002-salidas-y-cupos.md)).

Archivos: `apps/api/src/departures/departures.controller.ts`, `facets.ts`, `departures.module.ts`; esquemas y transiciones en `packages/shared/src/departure.ts`.

| Método | Ruta                                         | Quién             | Qué hace                                                          |
| ------ | -------------------------------------------- | ----------------- | ----------------------------------------------------------------- |
| GET    | `/v1/pro/{providerId}/salidas`               | Pro: `departures` | Salidas de la agencia por fecha (máximo 500); filtro `fulldayId`. |
| POST   | `/v1/pro/{providerId}/salidas`               | Pro: `departures` | Programa una o varias fechas con el mismo cupo, mínimo y precio.  |
| PATCH  | `/v1/pro/{providerId}/salidas/{departureId}` | Pro: `departures` | Cambia cupo, mínimo, precio propio, estado o guías.               |

Reglas:

- Solo se programan salidas de un fullday `published`, en fechas desde hoy (día de Venezuela, UTC-4) y sin repetir fecha (409 con las fechas ya ocupadas). Una petición programa como mucho `MAX_DEPARTURES_PER_REQUEST` (60) fechas.
- Cada salida guarda una copia de la ficha (`sheet`) y las facetas de búsqueda calculadas por `departureFacets()`: categoría, duración, inclusiones, etiquetas, ciudades de embarque normalizadas (un punto propio de la agencia cuenta como su ciudad base), texto de búsqueda (ficha, destino y su padre, nombre de la agencia) y `adultPriceUsd` (precio propio o el de la ficha).
- Estados (`canMoveDeparture`): entre `open`, `paused` y `closed` se mueve libremente; de ahí a `in_progress` o `cancelled`; de `in_progress` a `finished`. `cancelled` y `finished` son finales.
- El cupo no puede bajar de lo reservado y el mínimo no puede superar el cupo (409). Los guías deben ser miembros de la agencia.
- Pasar a `finished` llama a `BookingsService.finishDeparture()`; pasar a `cancelled` llama a `cancelDeparture()` (cancela todas las reservas vivas con reembolso total) y encola `departure_cancelled` para cada viajero.

Tablas: `departures`, `fulldays`, `providers`, `destinations`, `boarding_points`, `provider_members`.

**Todavía no:** ninguna tarea mueve las salidas a `in_progress` o `finished` por fecha; lo hace la agencia a mano con este endpoint.

### search: catálogo público y favoritos

Responsabilidad: la búsqueda de salidas, la página pública de un fullday y la de una agencia, y los favoritos del viajero ([ADR-F3-003](../fases/F3-salidas-busqueda-y-catalogo/decisiones/ADR-F3-003-busqueda-en-postgresql.md), [ADR-F3-004](../fases/F3-salidas-busqueda-y-catalogo/decisiones/ADR-F3-004-web-publica-sin-cache-ni-mapa.md)).

Archivos: `apps/api/src/search/search.controller.ts`, `search.module.ts`; filtros y normalización en `packages/shared/src/search.ts`.

| Método | Ruta                           | Quién   | Qué hace                                                                                                                                                     |
| ------ | ------------------------------ | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GET    | `/v1/salidas`                  | Público | Busca salidas visibles con filtros y orden; páginas de 20.                                                                                                   |
| GET    | `/v1/fulldays/{id}`            | Público | Ficha publicada, fotos, efectivo en destino, agencia, destino y próximas fechas `open` o `closed` (hasta 60).                                                |
| GET    | `/v1/agencias/{id}`            | Público | Agencia aprobada (nombre, distintivo, ciudad base, Instagram) y sus fulldays publicados con la próxima fecha en venta. Datos legales y de contacto no salen. |
| GET    | `/v1/yo/favoritos`             | Sesión  | Fulldays guardados que siguen visibles.                                                                                                                      |
| PUT    | `/v1/yo/favoritos/{fulldayId}` | Sesión  | Guarda un fullday visible (idempotente, 204).                                                                                                                |
| DELETE | `/v1/yo/favoritos/{fulldayId}` | Sesión  | Lo quita (204).                                                                                                                                              |

Filtros de `/v1/salidas` (todos texto en la URL): `q`, `destino` (slug; incluye los sitios hijos), `desde` (ciudad de embarque), `fechaDesde`, `fechaHasta`, `categoria`, `tematica`, `duracion`, `precioMax`, `incluye` (lista separada por comas), `verificados`, `ninos`, `mascotas`, `orden` (`recomendados`, `fecha`, `precio`, `cupos`) y `pagina`.

Reglas:

- Visible significa: salida `open` o `closed`, fecha desde hoy, fullday `published` y agencia `approved`.
- El texto libre se normaliza (minúsculas, sin acentos) y busca por subcadena o por `word_similarity` de `pg_trgm` ≥ 0,45 sobre `departures.search_text`.
- `recomendados` pone primero lo destacado por Central (`fulldays.featured`), luego por fecha y precio.
- La primera página de cada búsqueda se registra en `search_log` (texto, filtros, número de resultados) para las métricas de Central; si esa escritura falla, la búsqueda no falla.

Tablas: `departures`, `fulldays`, `providers`, `destinations`, `themes`, `favorites`, `search_log`.

### themes: temáticas y destacados

Responsabilidad: las temáticas que navegan los viajeros y la curación de portada.

Archivos: `apps/api/src/themes/themes.controller.ts`, `themes.module.ts`.

| Método | Ruta                                | Quién             | Qué hace                                                                                      |
| ------ | ----------------------------------- | ----------------- | --------------------------------------------------------------------------------------------- |
| GET    | `/v1/tematicas`                     | Público           | Temáticas por nombre.                                                                         |
| POST   | `/v1/central/tematicas`             | Central: `themes` | Crea una temática (slug, nombre, descripción).                                                |
| PATCH  | `/v1/central/tematicas/{id}`        | Central: `themes` | Edita una temática.                                                                           |
| DELETE | `/v1/central/tematicas/{id}`        | Central: `themes` | La borra; sus fulldays quedan sin ella.                                                       |
| PUT    | `/v1/central/fulldays/{id}/portada` | Central: `themes` | Fija si un fullday es destacado y la lista completa de sus temáticas (reemplaza la anterior). |

Tablas: `themes`, `fulldays` y su relación con temáticas. Errores: 409 slug duplicado, 400 temáticas inexistentes.

### rates: tasa del día

Responsabilidad: la tasa bolívares por dólar que Central carga cada día; las apps la usan para mostrar la referencia en bolívares y los pagos en bolívares la guardan.

Archivos: `apps/api/src/rates/rates.controller.ts`, `rates.module.ts`.

| Método | Ruta                | Quién            | Qué hace                                                                                                  |
| ------ | ------------------- | ---------------- | --------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/tasa`          | Público          | La tasa vigente: la de fecha más reciente que no sea posterior a hoy en Venezuela. 404 si no hay ninguna. |
| GET    | `/v1/central/tasas` | Central: `rates` | Historial de hasta 365 tasas.                                                                             |
| PUT    | `/v1/central/tasas` | Central: `rates` | Fija la tasa de un día; repetir el día la corrige.                                                        |

Tabla: `exchange_rates`.

### settings: reglas de reserva ajustables

Responsabilidad: lo que Central ajusta sin desplegar. `SettingsService` es global y lo usan bookings y payments.

Archivos: `apps/api/src/settings/settings.controller.ts`, `settings.service.ts`, `settings.module.ts`.

| Método | Ruta                  | Quién               | Qué hace                                                                                             |
| ------ | --------------------- | ------------------- | ---------------------------------------------------------------------------------------------------- |
| GET    | `/v1/ajustes`         | Público             | Minutos de apartado, abono mínimo (%), plazo en horas para escoger platos y métodos de pago activos. |
| PUT    | `/v1/central/ajustes` | Central: `settings` | Los reemplaza todos (apartado 5 a 120 min, abono 0 a 100 %, plazo 0 a 720 h, al menos un método).    |

Mientras Central no guarde nada valen: `HOLD_MINUTES`, abono mínimo 0 %, plazo de platos 48 h y los tres métodos (`mobile_payment`, `bank_transfer`, `zelle`). Tabla: `settings` (una fila, `id = 1`).

### bookings: apartado de cupos y reservas del viajero

Responsabilidad: tomar puestos sin sobreventa, la máquina de estados de la reserva, pasajeros y platos, cancelación con reembolso y los temporizadores que liberan apartados vencidos ([ADR-F4-002](../fases/F4-reserva-y-pagos/decisiones/ADR-F4-002-apartado-de-cupos.md), [ADR-F6-001](../fases/F6-post-viaje-y-central/decisiones/ADR-F6-001-cancelaciones-y-reembolsos.md)).

Archivos: `apps/api/src/bookings/bookings.controller.ts`, `bookings.service.ts`, `bookings.schemas.ts`, `bookings.module.ts`; cotización, demanda, transiciones y reembolsos en `packages/shared/src/booking.ts`. `BookingsService` se exporta a departures, payments y tripday.

| Método | Ruta                            | Quién   | Qué hace                                                                                                                                                 |
| ------ | ------------------------------- | ------- | -------------------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/salidas/{id}`              | Público | Disponibilidad de una salida visible: estado, precio, puestos libres, ficha vendida, porciones libres por plato limitado y habitaciones libres por tipo. |
| POST   | `/v1/reservas`                  | Sesión  | Aparta: toma puestos, platos y habitaciones y crea la reserva `held`.                                                                                    |
| GET    | `/v1/reservas`                  | Sesión  | Reservas propias, la más nueva primero (máximo 100).                                                                                                     |
| GET    | `/v1/reservas/{id}`             | Sesión  | Una reserva propia con líneas de precio, abono, pagado, saldo, fecha límite, pasajeros, instrucciones de pago de la agencia y reembolso.                 |
| PUT    | `/v1/reservas/{id}/pasajeros`   | Sesión  | Nombres, cédula, fecha de nacimiento, restricciones y platos de cada pasajero (por posición).                                                            |
| GET    | `/v1/reservas/{id}/cancelacion` | Sesión  | Cuánto se devolvería si se cancela ahora y qué regla lo dice.                                                                                            |
| POST   | `/v1/reservas/{id}/cancelar`    | Sesión  | Cancela la reserva y deja el reembolso pendiente si corresponde.                                                                                         |

Las reservas que la agencia ve y crea, y su cancelación por la agencia, están en el módulo [payments](#payments-pagos-reportados-libro-ventas-propias-y-reembolsos).

**Apartado sin sobreventa** (`hold()`):

1. La salida debe ser visible y `open`; la selección se valida contra la ficha (`checkSelection`: punto de embarque de la ficha, al menos un adulto, habitación si hay noches, platos y extras existentes); los problemas salen como 400 `validation_error`.
2. Se cotiza con `quote()`: tarifas por tipo de pasajero (un tipo sin precio paga como adulto, un infante no ocupa puesto), suplementos de embarque y habitación, recargos de platos y extras. El abono es el mayor entre el de la ficha y el mínimo de Central, sin pasar del total. La fecha límite del saldo es la fecha de la salida menos `balanceDueDaysBefore`.
3. Un viajero no puede tener más de `MAX_HELD_BOOKINGS` reservas `held` (409).
4. En una transacción (con espera de hasta 20 s por conexión, para que muchos compradores del último puesto hagan cola en vez de fallar): `UPDATE departures SET reserved = reserved + n WHERE … AND reserved + n <= capacity`; si no actualiza, 409 "No quedan suficientes puestos…". Luego, por cada plato limitado y tipo de habitación, `INSERT … ON CONFLICT DO NOTHING` en `departure_quotas` y el mismo `UPDATE` condicionado (409 "Se agotó …"). Los cupos se toman siempre en el mismo orden para no bloquearse entre sí.
5. Se crea la reserva con código `SAL-XXXXXXXX` (alfabeto sin 0/O ni 1/I), `heldUntil` = ahora + minutos de apartado, la selección, las líneas de precio y una fila por pasajero.

**Máquina de estados** (`nextBookingStatus` en `packages/shared/src/booking.ts`, aplicada por `BookingsService.move()`):

```mermaid
stateDiagram-v2
  [*] --> held: apartar
  held --> in_review: submit_proof (pago reportado)
  held --> deposit_paid: confirm_payment ≥ abono
  held --> paid: confirm_payment ≥ total
  held --> expired: expire (venció el apartado)
  held --> cancelled: cancel
  in_review --> held: reject_proof / confirm_payment < abono
  in_review --> deposit_paid: confirm_payment ≥ abono
  in_review --> paid: confirm_payment ≥ total
  in_review --> cancelled: cancel
  deposit_paid --> paid: confirm_payment ≥ total
  deposit_paid --> cancelled: balance_overdue / cancel
  deposit_paid --> completed: finish (alguien abordó)
  deposit_paid --> no_show: finish (nadie abordó)
  paid --> completed: finish (alguien abordó)
  paid --> no_show: finish (nadie abordó)
  paid --> cancelled: cancel
  expired --> [*]
  cancelled --> [*]
  completed --> [*]
  no_show --> [*]
```

`move()` actualiza solo si la reserva sigue en el estado leído (`updateMany where status = leído`); si otra petición la movió antes, 409 "La reserva cambió mientras tanto…". Un evento imposible en el estado actual da 409 "La reserva ya no admite esa acción." Al pasar a `expired` o `cancelled` se liberan en la misma transacción los puestos y los cupos de platos y habitaciones. Los estados que conservan puestos son `held`, `in_review`, `deposit_paid` y `paid`.

**Pasajeros y platos** (`setPassengers()`): no se admite en reservas `expired` o `cancelled`. Cambiar platos después del plazo (`mealChoiceDeadlineHours` antes de la medianoche del día del viaje en Venezuela) da 409. Los platos se mueven entre cupos en una transacción: se devuelven los de la selección anterior y se toman los de la nueva.

**Cancelación** (`cancel()`): calcula el reembolso con `refundFor()` según la plantilla de la ficha (`flexible`: total hasta 2 días antes; `moderate`: total hasta 7 días, la mitad hasta 2; `strict`: todo menos el abono hasta 7 días; plantilla propia o sin plantilla: 0 y se acuerda con la agencia). Si cancela la agencia, se devuelve todo lo pagado. En la misma transacción mueve la reserva a `cancelled`, guarda `cancelledBy` y, si el monto es mayor que cero, crea un reembolso `pending` en `refunds`.

**Fin de la salida** (`finishDeparture()`): cada reserva `deposit_paid` o `paid` pasa a `completed` si algún pasajero tiene `checkin = boarded`, o a `no_show` si no.

Tablas: `bookings`, `booking_passengers`, `departures`, `departure_quotas`, `refunds`; lee `providers`, `reviews`, `settings`.

Tareas en segundo plano: ver [Tareas en segundo plano](#tareas-en-segundo-plano) (`expireHolds`, `cancelOverdueBalances`).

**Todavía no:** escoger después de reservar un plato con recargo no cambia el total (anotado en `apps/api/src/bookings/bookings.service.ts`); se cobrará cuando existan pagos de extras.

### payments: pagos reportados, libro, ventas propias y reembolsos

Responsabilidad: el viajero reporta pagos hechos fuera de Salimos; la agencia los concilia; cada pago confirmado y cada reembolso pagado se asientan en un libro de partida doble. También las reservas que ve y crea la agencia ([ADR-F4-003](../fases/F4-reserva-y-pagos/decisiones/ADR-F4-003-pagos-reportados-y-libro.md), [ADR-F0-004](../fases/F0-preparacion/decisiones/ADR-F0-004-retencion-del-dinero.md), [ADR-F0-005](../fases/F0-preparacion/decisiones/ADR-F0-005-metodos-de-pago-mvp.md)).

Archivos: `apps/api/src/payments/payments.controller.ts`, `payments.service.ts`, `ledger.ts`, `payments.module.ts`.

| Método | Ruta                                                 | Quién                        | Qué hace                                                                                                                                   |
| ------ | ---------------------------------------------------- | ---------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------ |
| POST   | `/v1/reservas/{id}/pagos`                            | Sesión (dueño de la reserva) | Reporta un pago: método (`mobile_payment`, `bank_transfer`, `zelle`), referencia, monto USD, comprobante opcional y clave de idempotencia. |
| GET    | `/v1/reservas/{id}/pagos`                            | Sesión (dueño de la reserva) | Pagos de la reserva con estado, motivo de rechazo y enlace al comprobante.                                                                 |
| GET    | `/v1/pro/{providerId}/pagos`                         | Pro: `payments`              | Bandeja de pagos por estado, el más antiguo primero (máximo 200).                                                                          |
| POST   | `/v1/pro/{providerId}/pagos/{paymentId}/confirmar`   | Pro: `payments`              | Confirma un pago pendiente: lo aplica a la reserva y lo asienta.                                                                           |
| POST   | `/v1/pro/{providerId}/pagos/{paymentId}/rechazar`    | Pro: `payments`              | Rechaza un pago pendiente con motivo.                                                                                                      |
| GET    | `/v1/pro/{providerId}/reservas`                      | Pro: `bookings`              | Reservas de la agencia; filtros `departureId` y `status` (máximo 300).                                                                     |
| POST   | `/v1/pro/{providerId}/reservas`                      | Pro: `bookings`              | Venta propia (WhatsApp, oficina) con contacto y, opcionalmente, el dinero ya recibido.                                                     |
| GET    | `/v1/pro/{providerId}/reservas/{bookingId}`          | Pro: `bookings`              | Una reserva de la agencia.                                                                                                                 |
| POST   | `/v1/pro/{providerId}/reservas/{bookingId}/cancelar` | Pro: `bookings`              | Cancela una reserva con reembolso total.                                                                                                   |
| GET    | `/v1/pro/{providerId}/reembolsos`                    | Pro: `payments`              | Reembolsos, pendientes primero (máximo 200).                                                                                               |
| POST   | `/v1/pro/{providerId}/reembolsos/{refundId}/pagar`   | Pro: `payments`              | Registra que se envió el reembolso (referencia opcional) y lo asienta.                                                                     |

Reglas del reporte (`report()`):

- La misma `idempotencyKey` en la misma reserva devuelve el pago ya creado: un reintento por mala red no paga dos veces.
- El método debe estar activo en los ajustes; la reserva debe estar `held`, `in_review` o `deposit_paid`; el monto no puede superar lo que falta descontando lo ya pendiente (409 con el monto).
- El comprobante debe ser un documento propio `ready`.
- Pago móvil y transferencia son en bolívares: guardan la tasa vigente y el monto en bolívares; sin tasa cargada, 409 "Aún no hay tasa del día…".
- La referencia se normaliza (sin espacios ni guiones, mayúsculas) y es única: repetirla da 409 "Esa referencia ya fue reportada en otro pago."
- Si la reserva estaba `held`, pasa a `in_review` (ya no vence mientras la agencia revisa).

Reglas de la conciliación:

- Confirmar y rechazar actualizan solo si el pago sigue `pending`: dos personas a la vez no aplican el dinero dos veces (409 "Ese pago ya fue revisado.").
- Confirmar suma el monto a `paidUsd` y mueve la reserva con `confirm_payment`. Si lo pagado sigue por debajo del abono, la reserva vuelve a `held` con un apartado nuevo.
- Rechazar devuelve la reserva `in_review` a `held` con apartado nuevo cuando no le quedan otros pagos pendientes.
- Ambos encolan una notificación al viajero (`payment_confirmed`, `payment_rejected`).

**Libro** (`ledger.ts`, tabla `ledger_entries`): funciones puras que deciden los asientos; el servicio solo los guarda con un `transactionId` común. La comisión es la propia de la agencia (`providers.commission_percent`) o `COMMISSION_PERCENT`.

| Modelo     | Pago confirmado de A USD con comisión C                                                                                              |
| ---------- | ------------------------------------------------------------------------------------------------------------------------------------ |
| `direct`   | Debe `agency_cash` A / Haber `agency_customer_deposits` A; Debe `agency_customer_deposits` C / Haber `platform_commission_revenue` C |
| `retained` | Debe `platform_cash` A / Haber `platform_payable_to_agency` A − C / Haber `platform_commission_revenue` C                            |

Un reembolso pagado escribe el espejo exacto de esos asientos (`refundPostings`), comisión incluida, así que el dinero devuelto no deja comisión. Los asientos en cero se omiten y `balances()` comprueba que debe y haber cuadren.

```mermaid
sequenceDiagram
  autonumber
  participant V as Viajero (web/app)
  participant B as BookingsService
  participant P as PaymentsService
  participant A as Agencia (Pro)
  participant DB as PostgreSQL
  participant N as NotificationsService
  V->>B: POST /v1/reservas {departureId, selection}
  B->>DB: UPDATE departures reserved+n (condicionado) + departure_quotas
  B->>DB: INSERT bookings (held, heldUntil) + booking_passengers
  B-->>V: reserva held, código SAL-…
  V->>P: POST /v1/reservas/{id}/pagos {método, referencia, monto, idempotencyKey}
  P->>DB: INSERT payments (pending, tasa si es en bolívares)
  P->>B: move(submit_proof): held → in_review
  P-->>V: pago pending
  A->>P: POST /v1/pro/{providerId}/pagos/{paymentId}/confirmar
  P->>DB: payments pending → confirmed (condicionado)
  P->>B: move(confirm_payment): in_review → deposit_paid / paid
  P->>DB: INSERT ledger_entries (según MONEY_MODEL)
  P->>N: enqueue payment_confirmed
  P-->>A: pago confirmed
  Note over V: GET /v1/reservas/{id}/vouchers ya responde
```

**Venta propia** (`manualBooking()`): aparta en la misma salida con `userId` nulo, `source = agency` y sin temporizador. Si trae pago, lo crea ya `confirmed` y lo aplica; si el monto supera el total o falla el pago, cancela la reserva y devuelve los puestos.

Tablas: `payments`, `ledger_entries`, `refunds`, `bookings`, `exchange_rates`, `files`, `providers`.

Errores propios: 409 método no disponible, 409 reserva que no admite pagos, 409 monto excesivo, 409 sin tasa, 409 referencia duplicada, 409 pago ya revisado, 409 reembolso ya pagado, 404 comprobante, pago, reserva o reembolso inexistentes.

**Todavía no:** Salimos no mueve dinero en el MVP; los pagos se hacen fuera de la plataforma y aquí solo se reportan, concilian y asientan ([ADR-F4-003](../fases/F4-reserva-y-pagos/decisiones/ADR-F4-003-pagos-reportados-y-libro.md)).

### tripday: vouchers, lista de pasajeros, check-in, producción y avisos

Responsabilidad: lo que pasa el día del viaje: vouchers firmados que se validan sin red, la lista que descarga el guía, el check-in sin conexión, lo que la agencia debe preparar y los avisos a los viajeros ([ADR-F5-001](../fases/F5-dia-del-viaje/decisiones/ADR-F5-001-vouchers-firmados.md), [ADR-F5-002](../fases/F5-dia-del-viaje/decisiones/ADR-F5-002-check-in-y-sincronizacion.md), [ADR-F5-003](../fases/F5-dia-del-viaje/decisiones/ADR-F5-003-notificaciones-y-produccion.md)).

Archivos: `apps/api/src/tripday/tripday.controller.ts`, `operations.controller.ts`, `production.ts`, `tripday.module.ts`; firma y verificación de vouchers en `packages/shared/src/voucher.ts`.

| Método | Ruta                                                       | Quién                        | Qué hace                                                                                                             |
| ------ | ---------------------------------------------------------- | ---------------------------- | -------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/vouchers/llaves`                                      | Público                      | Claves públicas vigentes y retiradas, por id.                                                                        |
| GET    | `/v1/reservas/{id}/vouchers`                               | Sesión (dueño de la reserva) | Un voucher firmado por pasajero, solo si la reserva está `deposit_paid` o `paid` (si no, 409).                       |
| GET    | `/v1/pro/{providerId}/salidas/hoy`                         | Pro: `checkin`               | Salidas no canceladas de hoy y mañana, con pasajeros y abordados. Un guía solo ve las que tiene asignadas.           |
| GET    | `/v1/pro/{providerId}/salidas/{departureId}/pasajeros`     | Pro: `checkin`               | Lista de pasajeros de reservas confirmadas, con platos en palabras, saldo pendiente, check-in y las claves públicas. |
| POST   | `/v1/pro/{providerId}/salidas/{departureId}/checkins`      | Pro: `checkin`               | Aplica las marcas guardadas sin conexión y devuelve la lista actualizada.                                            |
| GET    | `/v1/pro/{providerId}/salidas/{departureId}/produccion`    | Pro: `bookings`              | Platos por opción y pendientes, unidades de ítems con proporción, habitaciones por tipo, restricciones y pasajeros.  |
| GET    | `/v1/pro/{providerId}/salidas/{departureId}/pasajeros.csv` | Pro: `bookings`              | La lista de pasajeros como CSV para Excel.                                                                           |
| GET    | `/v1/pro/{providerId}/salidas/{departureId}/avisos`        | Pro: `notices`               | Avisos publicados en la salida, el más nuevo primero.                                                                |
| POST   | `/v1/pro/{providerId}/salidas/{departureId}/avisos`        | Pro: `notices`               | Publica un aviso y lo encola para cada viajero con reserva confirmada (uno por persona).                             |
| GET    | `/v1/reservas/{id}/avisos`                                 | Sesión (dueño de la reserva) | Avisos de la salida de esa reserva.                                                                                  |

Reglas:

- **Vouchers**: el texto del QR es `idClave:código:pasajero:salida:fecha.firma`, con los UUID empaquetados en base64url y firma Ed25519 con `VOUCHER_SIGNING_KEY`; corto a propósito para que el QR sea legible en pantallas de teléfonos baratos. El id de la clave son los 8 primeros caracteres de su clave pública. Rotar la clave: poner la anterior en `VOUCHER_RETIRED_PUBLIC_KEYS` para que sus vouchers sigan validando.
- **Reservas confirmadas** para lista, producción y avisos: `deposit_paid`, `paid`, `completed`, `no_show`.
- **Guías**: en la lista y el check-in, un miembro con rol `guide` solo accede a las salidas cuyo `guideIds` lo incluye (403 si no). El resto del equipo con `checkin` accede a todas.
- **Check-in sin conexión**: cada evento trae pasajero, marca (`boarded`, `no_show` o `null` para deshacer) y la hora del teléfono. Se aplica solo si el pasajero es de esa salida y la marca es más nueva que la guardada, así dos guías sincronizando en cualquier orden terminan igual. Se ignoran marcas con hora más de 10 minutos en el futuro. La auditoría guarda cuántos eventos llegaron y cuántos se aplicaron.
- **CSV** (`production.ts`): con BOM para que Excel lea los acentos; las celdas que empiezan con `=`, `+`, `-`, `@`, tabulador o retorno se prefijan con apóstrofo para que no se ejecuten como fórmulas.

Tablas: `booking_passengers`, `bookings`, `departures`, `departure_notices`; encola en `notifications`.

### notifications: cola, envío, recordatorios y ciclo de entrega

Responsabilidad: encolar mensajes para personas y entregarlos después con reintentos, para que un proveedor lento nunca haga fallar una reserva o un pago. No expone endpoints.

Archivo: `apps/api/src/notifications/notifications.service.ts` (servicio y `NotificationsModule` global).

- **Cola** (`enqueue()`): por cada mensaje (`userId`, `event`, `title`, `body`, `dedupeKey` opcional) crea una fila por canal (`push` y `whatsapp`) en `notifications`, con `skipDuplicates`: un mensaje con la misma clave de deduplicación no se encola dos veces.
- **Quién encola**: fulldays (`fullday_approved`, `fullday_returned`), departures (`departure_cancelled`), payments (`payment_confirmed`, `payment_rejected`, `refund_paid`), tripday (`notice`), posttrip (`claim_resolved`) y los recordatorios.
- **Recordatorios** (`enqueueReminders()`): `trip_tomorrow` para reservas `deposit_paid` o `paid` cuya salida es mañana, y `balance_due` para reservas `deposit_paid` cuyo saldo vence entre hoy y dentro de dos días. Una vez por reserva gracias a `dedupeKey`.
- **Entrega** (`deliverPending()`): toma las 50 pendientes más antiguas y las envía con el `NotificationSender` al teléfono de la persona, o a su correo si no tiene teléfono. Éxito: `sent`. Fallo: suma un intento y guarda el error; a los 5 intentos queda `failed`.
- **Ciclo**: un temporizador cada `EXPIRE_HOLDS_EVERY_SECONDS` corre recordatorios y luego entrega.

Tabla: `notifications`; lee `bookings`, `departures`, `users`.

**Todavía no:** el único emisor es `LogNotificationSender`, que solo escribe en la salida lo que se enviaría; el módulo lo registra sin mirar `NOTIFICATION_SENDER` (`apps/api/src/notifications/notifications.service.ts`). Faltan las cuentas de Expo Push y WhatsApp Business. Tampoco hay endpoint para que la persona lea sus notificaciones.

### posttrip: reseñas, reclamos, reembolsos, liquidaciones, métricas y soporte

Responsabilidad: lo que pasa después del viaje y la vigilancia de Central ([ADR-F6-002](../fases/F6-post-viaje-y-central/decisiones/ADR-F6-002-reputacion.md), [ADR-F6-003](../fases/F6-post-viaje-y-central/decisiones/ADR-F6-003-liquidaciones-y-metricas.md)). Los reembolsos se crean al cancelar (módulo [bookings](#bookings-apartado-de-cupos-y-reservas-del-viajero)) y se pagan en [payments](#payments-pagos-reportados-libro-ventas-propias-y-reembolsos); aquí se leen en las liquidaciones.

Archivos: `apps/api/src/posttrip/reviews.controller.ts`, `claims.controller.ts`, `admin.controller.ts`, `posttrip.module.ts`; reglas de reseña y reclamo en `packages/shared/src/booking.ts`.

#### Reseñas y reputación

| Método | Ruta                                                | Quién                        | Qué hace                                                                                                                                     |
| ------ | --------------------------------------------------- | ---------------------------- | -------------------------------------------------------------------------------------------------------------------------------------------- |
| POST   | `/v1/reservas/{id}/resena`                          | Sesión (dueño de la reserva) | Reseña el viaje: nota 1 a 5, notas por aspecto (puntualidad, transporte, comida, guía, precio-calidad), si se cumplió la ficha y comentario. |
| GET    | `/v1/fulldays/{id}/resenas`                         | Público                      | Reputación del fullday y hasta 100 reseñas visibles.                                                                                         |
| GET    | `/v1/agencias/{id}/reputacion`                      | Público                      | Reputación de la agencia con todas sus reseñas visibles.                                                                                     |
| GET    | `/v1/pro/{providerId}/resenas`                      | Pro: `bookings`              | Reseñas de la agencia, visibles u ocultas, con estado de moderación.                                                                         |
| POST   | `/v1/pro/{providerId}/resenas/{reviewId}/responder` | Pro: `bookings`              | La única respuesta pública de la agencia a una reseña.                                                                                       |
| POST   | `/v1/pro/{providerId}/resenas/{reviewId}/reportar`  | Pro: `bookings`              | Pide a Central que revise una reseña, con motivo.                                                                                            |
| GET    | `/v1/central/resenas`                               | Central: `reviews`           | Cola de moderación: reportadas u ocultas.                                                                                                    |
| POST   | `/v1/central/resenas/{id}/ocultar`                  | Central: `reviews`           | Oculta con motivo y cierra el reporte.                                                                                                       |
| POST   | `/v1/central/resenas/{id}/mostrar`                  | Central: `reviews`           | Vuelve a mostrarla y cierra el reporte.                                                                                                      |

Reglas: solo se reseña una reserva `completed` (alguien abordó), una vez, hasta `REVIEW_WINDOW_DAYS` (30) días después del viaje. Una reseña con teléfono o enlace de WhatsApp queda oculta y reportada automáticamente. La respuesta de la agencia tampoco puede llevar datos de contacto (409). El autor público es solo el primer nombre. La reputación es la media simple de notas (un decimal), el número de reseñas, el porcentaje que dice que se cumplió la ficha y la media por aspecto.

Tablas: `reviews`, `bookings`, `departures`, `users`.

#### Reclamos

| Método | Ruta                                               | Quién                        | Qué hace                                                        |
| ------ | -------------------------------------------------- | ---------------------------- | --------------------------------------------------------------- |
| POST   | `/v1/reservas/{id}/reclamos`                       | Sesión (dueño de la reserva) | Abre un reclamo con asunto y primer mensaje.                    |
| GET    | `/v1/reclamos`                                     | Sesión                       | Reclamos propios con sus mensajes.                              |
| POST   | `/v1/reclamos/{id}/mensajes`                       | Sesión (autor)               | Responde en el reclamo.                                         |
| POST   | `/v1/reclamos/{id}/escalar`                        | Sesión (autor)               | Pide que Salimos intervenga: `open` → `escalated`.              |
| GET    | `/v1/pro/{providerId}/reclamos`                    | Pro: `bookings`              | Reclamos sobre reservas de la agencia.                          |
| POST   | `/v1/pro/{providerId}/reclamos/{claimId}/mensajes` | Pro: `bookings`              | Responde como agencia.                                          |
| GET    | `/v1/central/reclamos`                             | Central: `claims`            | Todos los reclamos por estado, el que más espera primero.       |
| POST   | `/v1/central/reclamos/{id}/mensajes`               | Central: `claims`            | Responde como Central.                                          |
| POST   | `/v1/central/reclamos/{id}/resolver`               | Central: `claims`            | Cierra con la resolución y avisa al viajero (`claim_resolved`). |

Reglas: solo se reclama sobre una reserva con algún pago confirmado. Estados `open`, `escalated`, `resolved`; un reclamo resuelto no admite más mensajes (409). Cada mensaje guarda el rol que lo escribió (`traveler`, `agency`, `central`). Tablas: `claims`, `claim_messages`, `bookings`.

#### Liquidaciones, reportes y métricas

| Método | Ruta                                     | Quién                  | Qué hace                                                                                                                                                                                                     |
| ------ | ---------------------------------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| GET    | `/v1/pro/{providerId}/liquidaciones`     | Pro: `settlements`     | Liquidación de un mes (`mes=YYYY-MM`, por defecto el actual): pagos, reembolsos, comisión, neto y líneas.                                                                                                    |
| GET    | `/v1/pro/{providerId}/liquidaciones.csv` | Pro: `settlements`     | La misma liquidación en CSV.                                                                                                                                                                                 |
| GET    | `/v1/pro/{providerId}/reportes`          | Pro: `reports`         | Ventas del mes, reservas confirmadas, cancelaciones, ocupación y reputación.                                                                                                                                 |
| GET    | `/v1/central/liquidaciones`              | Central: `settlements` | Totales del mes por cada agencia con movimientos en el libro.                                                                                                                                                |
| GET    | `/v1/central/metricas`                   | Central: `metrics`     | Actividad de un periodo (`desde`, `hasta`; por defecto los últimos 7 días): reservas, confirmadas, GMV, comisión, ocupación, agencias con salidas en venta, búsquedas, más buscado y buscado sin resultados. |

Reglas: la liquidación se lee del libro (`ledger_entries`) en el mes de Venezuela (UTC-4) convertido a instantes, así que es lo que dicen los asientos. El GMV es el saldo de `agency_cash` más `platform_cash` (pagos menos reembolsos); la comisión, el saldo de `platform_commission_revenue`. La ocupación es reservado entre cupo de las salidas no canceladas del periodo.

Tablas: `ledger_entries`, `payments`, `refunds`, `bookings`, `departures`, `providers`, `reviews`, `search_log`.

#### Usuarios y soporte

| Método | Ruta                                    | Quién            | Qué hace                                                                                                                                      |
| ------ | --------------------------------------- | ---------------- | --------------------------------------------------------------------------------------------------------------------------------------------- |
| GET    | `/v1/central/usuarios`                  | Central: `users` | Busca personas por parte del nombre, correo, teléfono o un código de reserva (al menos 3 caracteres; máximo 30), con sus últimas 20 reservas. |
| POST   | `/v1/central/usuarios/{id}/bloquear`    | Central: `users` | Bloquea con motivo y cierra todas sus sesiones al instante.                                                                                   |
| POST   | `/v1/central/usuarios/{id}/desbloquear` | Central: `users` | Quita el bloqueo.                                                                                                                             |

Una cuenta bloqueada no puede entrar por ninguna vía (`AuthController.open()` responde 403). `PostTripModule` importa `AuthModule` para usar `SessionService.revokeAll()`. Tablas: `users`, `sessions`, `bookings`.

### health: salud

| Método | Ruta     | Quién   | Qué hace                                                                                                              |
| ------ | -------- | ------- | --------------------------------------------------------------------------------------------------------------------- |
| GET    | `/salud` | Público | Responde `{ "status": "ok", "service": "api" }`. Sin versión ni límite de peticiones, para balanceadores y monitores. |

Archivo: `apps/api/src/health.controller.ts`. No comprueba PostgreSQL ni Redis.

## Tareas en segundo plano

No hay cola de trabajos todavía: las tareas periódicas son temporizadores `setInterval` dentro del proceso de la API, con periodo `EXPIRE_HOLDS_EVERY_SECONDS` (por defecto 60 s; `0` los apaga). Llevan `unref()` para no impedir el apagado y se detienen en `onModuleDestroy`.

| Tarea                                     | Dónde                                                 | Qué hace                                                                                                                                                         |
| ----------------------------------------- | ----------------------------------------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `expireHolds()`                           | `apps/api/src/bookings/bookings.service.ts`           | Hasta 500 reservas `held` con `heldUntil` vencido: las pasa a `expired` (condicionado a que sigan así) y libera puestos y cupos, una transacción por reserva.    |
| `cancelOverdueBalances()`                 | `apps/api/src/bookings/bookings.service.ts`           | Hasta 500 reservas `deposit_paid` con la fecha límite del saldo pasada y sin pagos pendientes: las cancela con el evento `balance_overdue` y libera los puestos. |
| `enqueueReminders()` + `deliverPending()` | `apps/api/src/notifications/notifications.service.ts` | Encola recordatorios y entrega hasta 50 notificaciones pendientes.                                                                                               |

Todas son seguras si corren a la vez en varias instancias en cuanto a estado de reservas (cada cambio está condicionado al estado leído). La entrega de notificaciones no lo es: dos instancias pueden tomar el mismo mensaje y enviarlo dos veces (anotado en el código).

**Todavía no:** `apps/worker/src/main.ts` es un marcador de posición que solo mantiene vivo el proceso. Mover estos temporizadores al worker es lo previsto antes de tener más de una instancia de la API.

## Comandos de línea de comandos

Scripts en `apps/api/src/cli/`, compilados a `apps/api/dist/cli/*.js`. Todos cargan el `.env` de la raíz si existe.

| Comando                                             | Qué hace                                                                                                  | Producción                         |
| --------------------------------------------------- | --------------------------------------------------------------------------------------------------------- | ---------------------------------- |
| `grant-super.js <email>`                            | Da el rol `super` de Central a ese correo, creando la fila de usuario si falta. Así nace el primer Super. | Sí                                 |
| `init-storage.js`                                   | Crea los buckets y su CORS si faltan.                                                                     | No (en la nube los crea Terraform) |
| `seed-catalogs.js`                                  | Carga destinos, tasas, puntos de embarque y platos del piloto; solo añade lo que falta.                   | Sí, como carga inicial             |
| `demo-user.js <email> [--super] [--phone <número>]` | Crea o restablece una cuenta con la contraseña de demostración (`demo-users.ts`), opcionalmente Super.    | Se niega                           |
| `seed-demo.js`                                      | Una agencia aprobada con dos fulldays publicados y sus próximos sábados. Requiere `seed-catalogs`.        | Se niega                           |
| `seed-showcase.js`                                  | Catálogo de demostración más amplio sobre `seed-demo`: más agencias, diez fulldays, fechas y reseñas.     | Se niega                           |
| `prepare-test-services.js`                          | Crea y migra la base de pruebas y los buckets; lo usan las pruebas de navegador.                          | No                                 |

`apps/api/src/write-openapi.js` (en `dist/`) escribe el contrato; ver [Contrato OpenAPI](#contrato-openapi-y-cliente-generado).

## Pruebas

- Vitest (`apps/api/vitest.config.ts`) corre `src/**/*.spec.ts` (26 archivos) contra PostgreSQL y Redis reales, uno tras otro (`fileParallelism: false`) porque comparten base de datos.
- `apps/api/src/testing/prepare.ts`: misma instancia de PostgreSQL con la base `salimos_test`, Redis con la base `1`; vacía Redis, crea la base si falta, aplica las migraciones (`pnpm --filter @salimos/db migrate:deploy`) y crea los buckets. Lo usan `apps/api/test/global-setup.ts` y las pruebas de navegador.
- `apps/api/test/app.ts`: `createTestApp()` levanta la aplicación real con `configureApp()`, temporizadores apagados y dos dobles: `FakeOtpSender` (guarda los códigos por correo) y `FakeGoogle` (tokens registrados por la prueba). `reset()` vacía tablas y claves de Redis.
- Ayudas: `test/sign-in.ts` (`signIn()` crea y confirma la cuenta por el flujo real), `test/providers.ts` (`createProvider()`), `test/files.ts` (`uploadDocument()` sube por el flujo real), `test/fulldays.ts` (`createSheetReferences()`, `morrocoySheet()`), `test/env.ts` (carga `.env`).
- `apps/api/src/auth/otp-sender.spec.ts` envía un correo real a Mailpit local y lo lee por su API.

## Contrato OpenAPI y cliente generado

- `buildOpenApi()` (`apps/api/src/openapi.ts`) genera el documento con `@nestjs/swagger`. Los esquemas de los decoradores salen de los mismos esquemas Zod que validan (`jsonSchema(schema, 'input' | 'output')`), así que contrato y validación no se separan.
- Añade a cada operación los parámetros de ruta que solo lee un guard (por ejemplo `providerId`) y una respuesta `default` con `ApiError`.
- `pnpm api:client` (raíz) compila la API, escribe `packages/api-client/openapi.json` con `write-openapi.js` y regenera los tipos con `openapi-typescript`. El test de `@salimos/api-client` falla si los tipos no coinciden con el contrato. Ver [paquetes](paquetes.md) e [integración](integracion.md).
- Fuera de producción, Swagger UI en `/docs`.

## Lo que todavía no está

Resumen de los puntos marcados en las secciones:

| Tema                                | Estado                                                                           | Dónde                                                                  |
| ----------------------------------- | -------------------------------------------------------------------------------- | ---------------------------------------------------------------------- |
| Arranque en producción              | Imposible mientras `NOTIFICATION_SENDER` solo admita `log`.                      | `apps/api/src/config.ts`                                               |
| Envío de notificaciones             | Solo se registran en la salida; faltan cuentas de Expo Push y WhatsApp Business. | `apps/api/src/notifications/notifications.service.ts`                  |
| Worker y colas                      | El worker es un marcador; los temporizadores corren en la API.                   | `apps/worker/src/main.ts`, `apps/api/src/bookings/bookings.service.ts` |
| Movimiento de dinero                | Pagos fuera de la plataforma; solo reporte, conciliación y libro.                | `apps/api/src/payments/`                                               |
| Recargo de platos escogidos después | No cambia el total.                                                              | `apps/api/src/bookings/bookings.service.ts`                            |
| Estados de salida por fecha         | Sin tarea automática; lo hace la agencia.                                        | `apps/api/src/departures/departures.controller.ts`                     |
| Limpieza de archivos huérfanos      | No existe.                                                                       | `apps/api/src/files/files.controller.ts`                               |
| Orden "más cupos"                   | Ordena por cupo total, no por puestos libres.                                    | `apps/api/src/search/search.controller.ts`                             |
| Límite de peticiones                | Ventana fija; `blockDuration` se ignora.                                         | `apps/api/src/common/throttler-storage.ts`                             |
| Auditoría                           | Se escribe fuera de la transacción de la acción.                                 | `apps/api/src/audit/audit.interceptor.ts`                              |
