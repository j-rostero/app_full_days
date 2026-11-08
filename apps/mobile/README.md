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
