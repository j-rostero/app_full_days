//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class SalidasApi {
  SalidasApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Salidas de la agencia por fecha, desde hoy salvo que se pida otra fecha (máximo 500)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId:
  ///
  /// * [DateTime] desde:
  Future<Response> listDeparturesWithHttpInfo(String providerId, { String? productId, DateTime? desde, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (productId != null) {
      queryParams.addAll(_queryParams('', 'productId', productId));
    }
    if (desde != null) {
      queryParams.addAll(_queryParams('', 'desde', desde));
    }

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

  /// Salidas de la agencia por fecha, desde hoy salvo que se pida otra fecha (máximo 500)
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId:
  ///
  /// * [DateTime] desde:
  Future<DepartureList?> listDepartures(String providerId, { String? productId, DateTime? desde, Future<void>? abortTrigger, }) async {
    final response = await listDeparturesWithHttpInfo(providerId, productId: productId, desde: desde, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DepartureList',) as DepartureList;
    
    }
    return null;
  }

  /// Programa una o varias fechas de un producto publicado con el mismo cupo, mínimo y precio
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ScheduleDeparturesInput] scheduleDeparturesInput (required):
  Future<Response> scheduleDeparturesWithHttpInfo(String providerId, ScheduleDeparturesInput scheduleDeparturesInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = scheduleDeparturesInput;

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

  /// Programa una o varias fechas de un producto publicado con el mismo cupo, mínimo y precio
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ScheduleDeparturesInput] scheduleDeparturesInput (required):
  Future<DepartureList?> scheduleDepartures(String providerId, ScheduleDeparturesInput scheduleDeparturesInput, { Future<void>? abortTrigger, }) async {
    final response = await scheduleDeparturesWithHttpInfo(providerId, scheduleDeparturesInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'DepartureList',) as DepartureList;
    
    }
    return null;
  }

  /// Cambia cupo, mínimo, precio propio, estado o guías de una salida
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [DepartureUpdateInput] departureUpdateInput (required):
  Future<Response> updateDepartureWithHttpInfo(String providerId, String departureId, DepartureUpdateInput departureUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/salidas/{departureId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{departureId}', departureId);

    // ignore: prefer_final_locals
    Object? postBody = departureUpdateInput;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>['application/json'];


    return apiClient.invokeAPI(
      path,
      'PATCH',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Cambia cupo, mínimo, precio propio, estado o guías de una salida
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId (required):
  ///
  /// * [DepartureUpdateInput] departureUpdateInput (required):
  Future<Departure?> updateDeparture(String providerId, String departureId, DepartureUpdateInput departureUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateDepartureWithHttpInfo(providerId, departureId, departureUpdateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Departure',) as Departure;
    
    }
    return null;
  }
}
