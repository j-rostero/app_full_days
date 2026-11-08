import 'dart:io' show Platform;

/// Configuración de la compilación. Llega con `--dart-define-from-file=env/<flavor>.json`.
class AppConfig {
  const AppConfig({required this.flavor, required this.apiUrl});

  final String flavor;
  final String apiUrl;

  /// Lee la configuración de la compilación.
  ///
  /// En desarrollo, sin `API_URL`, usa la API local: `localhost` es el propio teléfono o
  /// emulador, así que en Android se usa `10.0.2.2`, la dirección del computador desde el emulador.
  /// En un teléfono físico hay que pasar `API_URL=http://<IP del computador>:4000`.
  factory AppConfig.fromEnvironment() {
    const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
    const apiUrl = String.fromEnvironment('API_URL');
    return AppConfig(
      flavor: flavor,
      apiUrl: apiUrl.isNotEmpty ? apiUrl : _localApi(),
    );
  }

  static String _localApi() =>
      Platform.isAndroid ? 'http://10.0.2.2:4000' : 'http://localhost:4000';
}
