# App móvil (Flutter)

Una sola app para iOS y Android, con modo viajero y modo operador.

## Ejecutar

Con la API corriendo (`pnpm dev` en la raíz):

```bash
flutter run --flavor dev --dart-define-from-file=env/dev.json   # Android
flutter run --dart-define-from-file=env/dev.json                # iOS: sin --flavor
```

- En iOS no hay esquemas por entorno: se corre sin `--flavor` y el entorno llega igual por `env/<entorno>.json`.

- Sin `API_URL`, en desarrollo la app usa `http://10.0.2.2:4000` en el emulador de Android y `http://localhost:4000` en el simulador de iOS.
- En un teléfono físico: `--dart-define=API_URL=http://<IP del computador>:4000`.

## Entornos

| Flavor | Android `applicationId`     | Archivo          |
| ------ | --------------------------- | ---------------- |
| `dev`  | `com.jrostero.fulldays.dev` | `env/dev.json`   |
| `stg`  | `com.jrostero.fulldays.stg` | `env/stg.json`   |
| `prod` | `com.jrostero.fulldays`     | `env/prod.json`  |

En iOS todos los entornos usan `com.jrostero.fulldays`. Los identificadores no se pueden cambiar después de la primera publicación: si la marca cambia, cámbialos antes.

## Cliente de la API

`packages/api_dart` se genera desde el contrato OpenAPI (`pnpm api:client`); no se edita a mano.

## Push

La app pide permiso y registra el token del teléfono en la cuenta (`PUT /v1/yo/dispositivos`); al cerrar sesión lo quita. Para activarlo hace falta un proyecto de Firebase:

1. Crea el proyecto y registra las apps Android (`com.jrostero.fulldays`, con `.dev` y `.stg` para esos flavors) e iOS.
2. Corre `flutterfire configure` en `apps/mobile` o copia `google-services.json` a `android/app/` y `GoogleService-Info.plist` a `ios/Runner/`. En iOS sube la llave APNs a Firebase y activa «Push Notifications» y «Background Modes → Remote notifications» en Xcode.
3. En la API, pon la cuenta de servicio en `FCM_SERVICE_ACCOUNT`.

Sin esos archivos la app funciona igual: no registra token y los avisos se leen en «Mis viajes → Avisos».

## Publicar

### Android (Google Play)

1. Crea la llave una sola vez y guárdala fuera del repositorio (si se pierde, no se puede actualizar la app):

   ```bash
   keytool -genkey -v -keystore ~/fulldays-play.jks -keyalg RSA -keysize 2048 -validity 10000 -alias fulldays
   ```

2. Crea `android/key.properties` (está en `.gitignore`):

   ```properties
   storeFile=/ruta/a/fulldays-play.jks
   storePassword=…
   keyAlias=fulldays
   keyPassword=…
   ```

3. Sube la versión en `pubspec.yaml` (`version: 1.0.0+N`, N siempre mayor) y compila el paquete para la tienda:

   ```bash
   flutter build appbundle --flavor prod --release --dart-define-from-file=env/prod.json
   ```

   El archivo queda en `build/app/outputs/bundle/prodRelease/app-prod-release.aab`. Sin `key.properties` se firma con la llave de depuración, que Play rechaza.

### iOS (App Store)

Necesita una Mac con Xcode y una cuenta de Apple Developer. En `ios/Runner.xcworkspace`: equipo de firma en «Signing & Capabilities», capacidades de push y cámara (ya declarada en `Info.plist` para escanear vouchers), y luego:

```bash
flutter build ipa --release --dart-define-from-file=env/prod.json
```

Sube `build/ios/ipa/*.ipa` con Transporter o `xcrun altool`.
