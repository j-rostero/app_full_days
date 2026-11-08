//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class DiaDelViajeApi {
  DiaDelViajeApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Lista de pasajeros con reserva confirmada, platos, saldo, check-in y las llaves para validar vouchers
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Response> getManifestWithHttpInfo(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/pasajeros'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

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

  /// Lista de pasajeros con reserva confirmada, platos, saldo, check-in y las llaves para validar vouchers
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Manifest?> getManifest(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    final response = await getManifestWithHttpInfo(providerId, departureId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Manifest',) as Manifest;
    
    }
    return null;
  }

  /// La lista de pasajeros como CSV para Excel
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Response> getManifestCsvWithHttpInfo(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/pasajeros.csv'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

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

  /// La lista de pasajeros como CSV para Excel
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<String?> getManifestCsv(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    final response = await getManifestCsvWithHttpInfo(providerId, departureId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'String',) as String;
    
    }
    return null;
  }

  /// Lo que hay que preparar: platos por opción y pendientes, ítems, habitaciones por tipo y restricciones
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Response> getProductionWithHttpInfo(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/produccion'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

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

  /// Lo que hay que preparar: platos por opción y pendientes, ítems, habitaciones por tipo y restricciones
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Production?> getProduction(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    final response = await getProductionWithHttpInfo(providerId, departureId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Production',) as Production;
    
    }
    return null;
  }

  /// Avisos de la agencia para la salida de esta reserva, el más nuevo primero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> listBookingNoticesWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/avisos'
      .replaceAll('{id}', id);

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

  /// Avisos de la agencia para la salida de esta reserva, el más nuevo primero
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<NoticeList?> listBookingNotices(String id, { Future<void>? abortTrigger, }) async {
    final response = await listBookingNoticesWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NoticeList',) as NoticeList;
    
    }
    return null;
  }

  /// Avisos publicados en la salida, el más nuevo primero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<Response> listDepartureNoticesWithHttpInfo(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/avisos'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

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

  /// Avisos publicados en la salida, el más nuevo primero
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  Future<NoticeList?> listDepartureNotices(String providerId, String departureId, { Future<void>? abortTrigger, }) async {
    final response = await listDepartureNoticesWithHttpInfo(providerId, departureId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'NoticeList',) as NoticeList;
    
    }
    return null;
  }

  /// Salidas no canceladas de hoy y mañana, con pasajeros y abordados; un guía solo ve las suyas
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> listTodayDeparturesWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/hoy'
      .replaceAll('{providerId}', providerId);

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

  /// Salidas no canceladas de hoy y mañana, con pasajeros y abordados; un guía solo ve las suyas
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<TodayList?> listTodayDepartures(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await listTodayDeparturesWithHttpInfo(providerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TodayList',) as TodayList;
    
    }
    return null;
  }

  /// Publica un aviso para los viajeros con reserva confirmada en la salida
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [NoticeInput] noticeInput (required):
  Future<Response> publishDepartureNoticeWithHttpInfo(String providerId, String departureId, NoticeInput noticeInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/avisos'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

    // ignore: prefer_final_locals
    Object? postBody = noticeInput;

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

  /// Publica un aviso para los viajeros con reserva confirmada en la salida
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [NoticeInput] noticeInput (required):
  Future<Notice?> publishDepartureNotice(String providerId, String departureId, NoticeInput noticeInput, { Future<void>? abortTrigger, }) async {
    final response = await publishDepartureNoticeWithHttpInfo(providerId, departureId, noticeInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Notice',) as Notice;
    
    }
    return null;
  }

  /// Aplica las marcas hechas sin conexión (gana la más reciente por hora del teléfono) y devuelve la lista
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [CheckinSyncInput] checkinSyncInput (required):
  Future<Response> syncCheckinsWithHttpInfo(String providerId, String departureId, CheckinSyncInput checkinSyncInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}/checkins'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

    // ignore: prefer_final_locals
    Object? postBody = checkinSyncInput;

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

  /// Aplica las marcas hechas sin conexión (gana la más reciente por hora del teléfono) y devuelve la lista
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [CheckinSyncInput] checkinSyncInput (required):
  Future<Manifest?> syncCheckins(String providerId, String departureId, CheckinSyncInput checkinSyncInput, { Future<void>? abortTrigger, }) async {
    final response = await syncCheckinsWithHttpInfo(providerId, departureId, checkinSyncInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Manifest',) as Manifest;
    
    }
    return null;
  }
}
