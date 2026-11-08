import 'package:fulldays_api/api.dart';
import 'package:http/http.dart' as http;

import 'common.dart';

/// Sube un comprobante en tres pasos (declarar, subir directo, confirmar) y devuelve su id.
Future<String> uploadDocument(ApiClient client, List<int> bytes, String contentType, {http.Client? storage}) async {
  final api = ArchivosApi(client);
  final declared = await call(
    () => api.declareFile(
      DeclareFileInput(kind: DeclareFileInputKindEnum.document, contentType: contentType, size: bytes.length),
    ),
  );
  final put = await (storage ?? http.Client()).put(
    Uri.parse(declared.upload.url),
    headers: declared.upload.headers,
    body: bytes,
  );
  if (put.statusCode >= 300) throw Exception('No pudimos subir el comprobante. Inténtalo de nuevo.');
  await call(() => api.confirmFile(declared.file.id));
  return declared.file.id;
}
