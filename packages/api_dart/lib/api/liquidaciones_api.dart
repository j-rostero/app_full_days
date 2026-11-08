//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class LiquidacionesApi {
  LiquidacionesApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Actividad de un periodo (por defecto los últimos 7 días): reservas, GMV, comisión, ocupación y búsquedas
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DateTime] desde:
  ///
  /// * [DateTime] hasta:
  Future<Response> getMetricsWithHttpInfo({ DateTime? desde, DateTime? hasta, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/metricas';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (desde != null) {
      queryParams.addAll(_queryParams('', 'desde', desde));
    }
    if (hasta != null) {
      queryParams.addAll(_queryParams('', 'hasta', hasta));
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

  /// Actividad de un periodo (por defecto los últimos 7 días): reservas, GMV, comisión, ocupación y búsquedas
  ///
  /// Parameters:
  ///
  /// * [DateTime] desde:
  ///
  /// * [DateTime] hasta:
  Future<Metrics?> getMetrics({ DateTime? desde, DateTime? hasta, Future<void>? abortTrigger, }) async {
    final response = await getMetricsWithHttpInfo(desde: desde, hasta: hasta, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Metrics',) as Metrics;
    
    }
    return null;
  }

  /// Ventas del mes, reservas confirmadas, cancelaciones, ocupación y reputación
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<Response> getProviderReportWithHttpInfo(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reportes'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (mes != null) {
      queryParams.addAll(_queryParams('', 'mes', mes));
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

  /// Ventas del mes, reservas confirmadas, cancelaciones, ocupación y reputación
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<ProviderReport?> getProviderReport(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    final response = await getProviderReportWithHttpInfo(providerId, mes: mes, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProviderReport',) as ProviderReport;
    
    }
    return null;
  }

  /// Liquidación de un mes (por defecto el actual): pagos, reembolsos, comisión, neto y líneas
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<Response> getSettlementWithHttpInfo(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/liquidaciones'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (mes != null) {
      queryParams.addAll(_queryParams('', 'mes', mes));
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

  /// Liquidación de un mes (por defecto el actual): pagos, reembolsos, comisión, neto y líneas
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<Settlement?> getSettlement(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    final response = await getSettlementWithHttpInfo(providerId, mes: mes, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Settlement',) as Settlement;
    
    }
    return null;
  }

  /// La liquidación del mes en CSV
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<Response> getSettlementCsvWithHttpInfo(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/liquidaciones.csv'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (mes != null) {
      queryParams.addAll(_queryParams('', 'mes', mes));
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

  /// La liquidación del mes en CSV
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] mes:
  Future<String?> getSettlementCsv(String providerId, { String? mes, Future<void>? abortTrigger, }) async {
    final response = await getSettlementCsvWithHttpInfo(providerId, mes: mes, abortTrigger: abortTrigger,);
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

  /// Totales del mes por cada agencia con movimientos en el libro
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] mes:
  Future<Response> listSettlementsWithHttpInfo({ String? mes, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/liquidaciones';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (mes != null) {
      queryParams.addAll(_queryParams('', 'mes', mes));
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

  /// Totales del mes por cada agencia con movimientos en el libro
  ///
  /// Parameters:
  ///
  /// * [String] mes:
  Future<CentralSettlements?> listSettlements({ String? mes, Future<void>? abortTrigger, }) async {
    final response = await listSettlementsWithHttpInfo(mes: mes, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'CentralSettlements',) as CentralSettlements;
    
    }
    return null;
  }
}
