# Despliegue y lanzamiento

Cómo se pone FullDays en producción y qué falta decidir o contratar antes de abrirlo al público. Los documentos de `docs/referencia/` describen el diseño; este, la operación.

## Piezas en producción

| Pieza   | Imagen                                       | Puerto | Escala                                    |
| ------- | -------------------------------------------- | ------ | ----------------------------------------- |
| API     | `infra/docker/api.Dockerfile`                | 4000   | Varias instancias detrás del balanceador  |
| Worker  | La misma imagen, `node dist/worker.js`       | —      | Una o más: no repiten tareas ni mensajes  |
| Migrar  | `api.Dockerfile`, `--target migrate`         | —      | Se corre una vez antes de cada despliegue |
| Web     | `infra/docker/web.Dockerfile`, `APP=web`     | 3000   | Varias instancias                         |
| Pro     | `infra/docker/web.Dockerfile`, `APP=pro-web` | 3000   | Varias instancias                         |
| Central | `infra/docker/web.Dockerfile`, `APP=central` | 3000   | Una basta                                 |
| Datos   | PostgreSQL 17, Redis 8, S3, imgproxy, SMTP   | —      | Servicios administrados                   |

Las webs solo hablan con la API (`API_URL`); la API es la única que toca la base, Redis y el almacenamiento. Pon las cuatro direcciones públicas detrás de HTTPS (Caddy, Nginx o el balanceador de la nube) y ajusta `TRUST_PROXY` al número de saltos.

## Primer despliegue en un servidor

```bash
cp infra/docker/produccion.env.example produccion.env   # llena cada valor
docker compose -f infra/docker/docker-compose.prod.yml up -d --build
docker compose -f infra/docker/docker-compose.prod.yml exec api node dist/cli/grant-super.js tu@correo.com
docker compose -f infra/docker/docker-compose.prod.yml exec api node dist/cli/seed-catalogs.js
```

La API valida su configuración al arrancar y se niega a correr en producción con secretos de desarrollo, códigos fijos, correo por consola o almacenamiento en memoria; el mensaje dice qué variable corregir.

Detrás de un proxy con certificado propio, las imágenes se construyen con `--secret id=ca,src=ruta/al/ca.pem`.

## Cada despliegue

1. `VERIFICAR_PASOS="formato lint tipos build pruebas contrato e2e flutter" ./scripts/verificar.sh` en verde (CI corre lo mismo).
2. Construir las imágenes y correr `migrate`. Las migraciones solo agregan: la versión anterior de la API sigue funcionando con la base nueva mientras se reemplaza.
3. Reemplazar API y worker, luego las webs.
4. Revisar `GET /salud` (base y Redis) y los registros JSON de la API y el worker.

## Operación

- **Registros**: en producción la API y el worker escriben JSON, una línea por evento.
- **Salud**: `GET /salud` responde 200 solo si la base y Redis responden; la imagen de la API lo usa como `HEALTHCHECK`.
- **Respaldos**: PostgreSQL con respaldo diario y recuperación a un punto en el tiempo (el libro contable y las reservas viven ahí). Redis solo guarda límites de peticiones y la cola del worker, y se reconstruye sola. El almacenamiento S3 con versionado activado.
- **Avisos que fallan**: quedan en la tabla `notifications` con `status = 'failed'` y el error tras cinco intentos.
- **Claves de vouchers**: para rotarlas, mueve la llave pública vieja a `VOUCHER_RETIRED_PUBLIC_KEYS` y pon una semilla nueva en `VOUCHER_SIGNING_KEY`; los vouchers ya emitidos siguen validando.

## Lista de lanzamiento

Lo que el código no puede resolver solo. Cada punto dice quién lo provee.

### Cuentas y dominios

- [ ] Dominio y DNS para web, Pro, Central, API e imágenes (hoy `fulldays.com.ve` es un ejemplo en `produccion.env.example`).
- [ ] Hosting: servidor o nube con PostgreSQL y Redis administrados.
- [ ] Almacenamiento S3 con dos depósitos (imágenes públicas por imgproxy, documentos privados) y CORS para las tres webs.
- [ ] Proveedor SMTP con SPF, DKIM y DMARC configurados para el dominio del remitente.
- [ ] Firebase: proyecto, apps Android e iOS, llave APNs, cuenta de servicio para `FCM_SERVICE_ACCOUNT` (pasos en `apps/mobile/README.md`).
- [ ] Google Cloud: ids de cliente OAuth web, Android e iOS para `GOOGLE_CLIENT_IDS` (opcional).
- [ ] Google Play Console y Apple Developer Program.

### Producto y legal

- [ ] Términos y condiciones, política de privacidad y política de reclamos publicadas en la web y enlazadas desde las tiendas.
- [ ] Comisión por defecto y modelo de dinero (`MONEY_MODEL`) confirmados con contabilidad.
- [ ] Métodos de pago aceptados y tasa del día cargada en Central.
- [ ] Catálogos reales (destinos, puntos de embarque, temáticas) en vez de los de ejemplo.
- [ ] Primeras agencias verificadas y con fichas aprobadas.

### App

- [ ] `env/prod.json` con la URL real de la API.
- [ ] Llave de publicación de Android creada y guardada en un lugar seguro (si se pierde, no se puede actualizar la app).
- [ ] Ícono, nombre y capturas para las tiendas; ficha de privacidad de datos (Play) y etiquetas de privacidad (App Store).
- [ ] En Xcode: equipo de firma y capacidades de push.

### Antes de abrir

- [ ] Secretos de producción generados y guardados en un gestor de secretos.
- [ ] Respaldo de la base probado restaurándolo.
- [ ] Un recorrido completo a mano en producción con una agencia y una reserva de prueba, y luego borrarlas.
- [ ] Monitoreo de `/salud` y alertas sobre errores en los registros.
