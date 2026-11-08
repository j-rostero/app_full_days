//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class NotificacionesApi {
  NotificacionesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Deja de enviar push a este teléfono (al cerrar sesión)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ForgetDeviceInput] forgetDeviceInput (required):
  Future<Response> forgetDeviceWithHttpInfo(ForgetDeviceInput forgetDeviceInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/dispositivos/quitar';

    // ignore: prefer_final_locals
    Object? postBody = forgetDeviceInput;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Deja de enviar push a este teléfono (al cerrar sesión)
  ///
  /// Parameters:
  ///
  /// * [ForgetDeviceInput] forgetDeviceInput (required):
  Future<void> forgetDevice(ForgetDeviceInput forgetDeviceInput, { Future<void>? abortTrigger, }) async {
    final response = await forgetDeviceWithHttpInfo(forgetDeviceInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Las últimas 50 notificaciones y cuántas faltan por leer
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getInboxWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/notificaciones';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'GET',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Las últimas 50 notificaciones y cuántas faltan por leer
  Future<Inbox?> getInbox({ Future<void>? abortTrigger, }) async {
    final response = await getInboxWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Inbox',) as Inbox;
    
    }
    return null;
  }

  /// Marca como leídas las indicadas, o todas si no se indica ninguna
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [MarkReadInput] markReadInput (required):
  Future<Response> markInboxReadWithHttpInfo(MarkReadInput markReadInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/notificaciones/leidas';

    // ignore: prefer_final_locals
    Object? postBody = markReadInput;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'POST',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Marca como leídas las indicadas, o todas si no se indica ninguna
  ///
  /// Parameters:
  ///
  /// * [MarkReadInput] markReadInput (required):
  Future<void> markInboxRead(MarkReadInput markReadInput, { Future<void>? abortTrigger, }) async {
    final response = await markInboxReadWithHttpInfo(markReadInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Registra el token de push de este teléfono (pasa a la cuenta actual si era de otra)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DeviceInput] deviceInput (required):
  Future<Response> registerDeviceWithHttpInfo(DeviceInput deviceInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/dispositivos';

    // ignore: prefer_final_locals
    Object? postBody = deviceInput;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PUT',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Registra el token de push de este teléfono (pasa a la cuenta actual si era de otra)
  ///
  /// Parameters:
  ///
  /// * [DeviceInput] deviceInput (required):
  Future<void> registerDevice(DeviceInput deviceInput, { Future<void>? abortTrigger, }) async {
    final response = await registerDeviceWithHttpInfo(deviceInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
