# FullDays

Sistema para gestionar fulldays, excursiones, tours y viajes: una API, una web para clientes, una web para agencias, una web interna y una app móvil en Flutter para iOS y Android.

`FullDays` es un nombre de trabajo; la marca definitiva está por decidir.

## Piezas

| Carpeta                | Qué es                                                                | Puerto |
| ---------------------- | --------------------------------------------------------------------- | ------ |
| `apps/api`             | API NestJS. La única que toca base de datos, Redis, archivos y correo | 4000   |
| `apps/web`             | Web de clientes (Next.js)                                             | 3100   |
| `apps/pro-web`         | Web de agencias (Next.js)                                             | 3101   |
| `apps/central`         | Web del equipo interno (Next.js)                                      | 3102   |
| `apps/mobile`          | App Flutter (viajero y operador)                                      | —      |
| `packages/shared`      | Reglas y esquemas Zod comunes                                         |        |
| `packages/db`          | Esquema Prisma y cliente de la base                                   |        |
| `packages/api-client`  | Contrato OpenAPI (`openapi.json`) y cliente TypeScript tipado         |        |
| `packages/api_dart`    | Cliente Dart generado del mismo contrato                              |        |
| `packages/web-session` | Sesión de las webs: cookies seguras, renovación y pantallas de acceso |        |
| `packages/tokens`      | Tokens de diseño: genera el CSS de las webs y el Dart de la app       |        |
| `packages/ui_flutter`  | Tema y componentes de la app                                          |        |
| `infra/docker`         | PostgreSQL, Redis, almacenamiento S3, imgproxy y buzón de correo      |        |

## Empezar

Requisitos: Node 22.18 o más nuevo (CI usa 24), pnpm 10, Docker, Java 17 o más nuevo (genera el cliente Dart) y Flutter 3.47.

```bash
pnpm install
cp .env.example .env
pnpm dev            # levanta la infraestructura, la API y las tres webs
```

La app: ver [`apps/mobile/README.md`](apps/mobile/README.md).

### Cuentas en local

- Los códigos de confirmación se escriben en la consola de la API (`OTP_SENDER=log`). Con `OTP_SENDER=smtp` llegan a Mailpit: http://localhost:8025.
- El primer super de Central se crea desde la terminal; después se gestionan desde `/v1/central/equipo`:

  ```bash
  pnpm --filter @fulldays/api build && pnpm --filter @fulldays/api grant-super tu@correo.com
  ```

- Los catálogos iniciales (destinos, sitios, puntos de embarque y temáticas de ejemplo) se cargan una vez:

  ```bash
  pnpm --filter @fulldays/api build && pnpm --filter @fulldays/api seed-catalogs
  ```

- Una agencia se registra en la web Pro, envía sus documentos y Central la aprueba en `/agencias`; desde ahí publica fichas que Central revisa en `/productos`.
- Con una ficha aprobada, la agencia programa salidas en `/salidas`. El viajero las encuentra en la web (http://localhost:3100) o en la app, aparta sus puestos, reporta el pago con su comprobante y la agencia lo confirma en `/pagos`; confirmado el abono, los vouchers QR aparecen en la reserva y la app los guarda para verlos sin conexión.
- Los pagos en bolívares necesitan la tasa del día, que Central carga en `/tasa`.
- Entrar con Google necesita `GOOGLE_CLIENT_IDS` (sin él, la API responde que aún no está disponible).

## Comandos

| Comando                  | Qué hace                                                                          |
| ------------------------ | --------------------------------------------------------------------------------- |
| `pnpm verify`            | Verificación completa, igual que CI (necesita PostgreSQL y Redis)                 |
| `pnpm api:client`        | Regenera `openapi.json` y los clientes TypeScript y Dart tras cambiar un endpoint |
| `pnpm tokens`            | Regenera el CSS y el Dart desde `packages/tokens/tokens.json`                     |
| `pnpm infra:up` / `down` | Enciende o apaga la infraestructura local                                         |

Un cambio de endpoint sin regenerar el contrato hace fallar las pruebas: el código y los clientes nunca se desincronizan.

## Documentación

- [`docs/referencia/`](docs/referencia/README.md): documentación técnica del sistema de referencia que se usa como especificación. Describe un sistema existente (Salimos); aquí se construye desde cero tomando sus reglas, su contrato y su arquitectura, con la app móvil en Flutter en lugar de Expo.
