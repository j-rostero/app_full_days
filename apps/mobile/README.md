# App móvil (Flutter)

Una sola app para iOS y Android, con modo viajero y modo operador (llega en las Fases 3 y 4).

## Ejecutar

Con la API corriendo (`pnpm dev` en la raíz):

```bash
flutter run --flavor dev --dart-define-from-file=env/dev.json
```

- Sin `API_URL`, en desarrollo la app usa `http://10.0.2.2:4000` en el emulador de Android y `http://localhost:4000` en el simulador de iOS.
- En un teléfono físico: `--dart-define=API_URL=http://<IP del computador>:4000`.

## Entornos

| Flavor | Android `applicationId`     | Archivo          |
| ------ | --------------------------- | ---------------- |
| `dev`  | `com.jrostero.fulldays.dev` | `env/dev.json`   |
| `stg`  | `com.jrostero.fulldays.stg` | `env/stg.json`   |
| `prod` | `com.jrostero.fulldays`     | `env/prod.json`  |

En iOS todos los entornos usan hoy `com.jrostero.fulldays`; los esquemas por entorno se configuran en Xcode en la Fase 6, junto con la firma. Los identificadores son provisionales hasta definir la marca.

## Cliente de la API

`packages/api_dart` se genera desde el contrato OpenAPI (`pnpm api:client`); no se edita a mano.

## Push

La app pide permiso y registra el token del teléfono en la cuenta (`PUT /v1/yo/dispositivos`); al cerrar sesión lo quita. Para activarlo hace falta un proyecto de Firebase:

1. Crea el proyecto y registra las apps Android (`com.jrostero.fulldays`, con `.dev` y `.stg` para esos flavors) e iOS.
2. Corre `flutterfire configure` en `apps/mobile` o copia `google-services.json` a `android/app/` y `GoogleService-Info.plist` a `ios/Runner/`. En iOS sube la llave APNs a Firebase y activa «Push Notifications» y «Background Modes → Remote notifications» en Xcode.
3. En la API, pon la cuenta de servicio en `FCM_SERVICE_ACCOUNT`.

Sin esos archivos la app funciona igual: no registra token y los avisos se leen en «Mis viajes → Avisos».
