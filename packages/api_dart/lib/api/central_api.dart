//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CentralApi {
  CentralApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Añade una tasa conocida a un destino
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [DestinationFeeInput] destinationFeeInput (required):
  Future<Response> addDestinationFeeWithHttpInfo(String id, DestinationFeeInput destinationFeeInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/destinos/{id}/tasas'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = destinationFeeInput;

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

  /// Añade una tasa conocida a un destino
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [DestinationFeeInput] destinationFeeInput (required):
  Future<Destination?> addDestinationFee(String id, DestinationFeeInput destinationFeeInput, { Future<void>? abortTrigger, }) async {
    final response = await addDestinationFeeWithHttpInfo(id, destinationFeeInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Destination',) as Destination;
    
    }
    return null;
  }

  /// Publica un producto en revisión
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> approveProductWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos/{id}/aprobar'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Publica un producto en revisión
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ProductDetail?> approveProduct(String id, { Future<void>? abortTrigger, }) async {
    final response = await approveProductWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductDetail',) as ProductDetail;
    
    }
    return null;
  }

  /// Aprueba una agencia en revisión o suspendida
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> approveProviderWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores/{id}/aprobar'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Aprueba una agencia en revisión o suspendida
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Company?> approveProvider(String id, { Future<void>? abortTrigger, }) async {
    final response = await approveProviderWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Company',) as Company;
    
    }
    return null;
  }

  /// Crea un punto de embarque
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [BoardingPointInput] boardingPointInput (required):
  Future<Response> createBoardingPointWithHttpInfo(BoardingPointInput boardingPointInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/puntos-de-embarque';

    // ignore: prefer_final_locals
    Object? postBody = boardingPointInput;

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

  /// Crea un punto de embarque
  ///
  /// Parameters:
  ///
  /// * [BoardingPointInput] boardingPointInput (required):
  Future<BoardingPoint?> createBoardingPoint(BoardingPointInput boardingPointInput, { Future<void>? abortTrigger, }) async {
    final response = await createBoardingPointWithHttpInfo(boardingPointInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BoardingPoint',) as BoardingPoint;
    
    }
    return null;
  }

  /// Crea un destino o un sitio dentro de uno
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [DestinationInput] destinationInput (required):
  Future<Response> createDestinationWithHttpInfo(DestinationInput destinationInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/destinos';

    // ignore: prefer_final_locals
    Object? postBody = destinationInput;

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

  /// Crea un destino o un sitio dentro de uno
  ///
  /// Parameters:
  ///
  /// * [DestinationInput] destinationInput (required):
  Future<Destination?> createDestination(DestinationInput destinationInput, { Future<void>? abortTrigger, }) async {
    final response = await createDestinationWithHttpInfo(destinationInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Destination',) as Destination;
    
    }
    return null;
  }

  /// Crea una temática
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ThemeInput] themeInput (required):
  Future<Response> createThemeWithHttpInfo(ThemeInput themeInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/tematicas';

    // ignore: prefer_final_locals
    Object? postBody = themeInput;

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

  /// Crea una temática
  ///
  /// Parameters:
  ///
  /// * [ThemeInput] themeInput (required):
  Future<TravelTheme?> createTheme(ThemeInput themeInput, { Future<void>? abortTrigger, }) async {
    final response = await createThemeWithHttpInfo(themeInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TravelTheme',) as TravelTheme;
    
    }
    return null;
  }

  /// Fija si es destacado y la lista completa de sus temáticas
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [CurationInput] curationInput (required):
  Future<Response> curateProductWithHttpInfo(String id, CurationInput curationInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos/{id}/portada'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = curationInput;

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

  /// Fija si es destacado y la lista completa de sus temáticas
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [CurationInput] curationInput (required):
  Future<ProductReview?> curateProduct(String id, CurationInput curationInput, { Future<void>? abortTrigger, }) async {
    final response = await curateProductWithHttpInfo(id, curationInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductReview',) as ProductReview;
    
    }
    return null;
  }

  /// Borra un punto de embarque
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteBoardingPointWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/puntos-de-embarque/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Borra un punto de embarque
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteBoardingPoint(String id, { Future<void>? abortTrigger, }) async {
    final response = await deleteBoardingPointWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Borra un destino sin sitios
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteDestinationWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/destinos/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Borra un destino sin sitios
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteDestination(String id, { Future<void>? abortTrigger, }) async {
    final response = await deleteDestinationWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Borra una tasa de destino
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteDestinationFeeWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/tasas/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Borra una tasa de destino
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteDestinationFee(String id, { Future<void>? abortTrigger, }) async {
    final response = await deleteDestinationFeeWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Borra una temática; sus productos quedan sin ella
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> deleteThemeWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/tematicas/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


    return apiClient.invokeAPI(
      path,
      'DELETE',
      queryParams,
      postBody,
      headerParams,
      formParams,
      contentTypes.isEmpty ? null : contentTypes.first,
      abortTrigger: abortTrigger,
    );
  }

  /// Borra una temática; sus productos quedan sin ella
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> deleteTheme(String id, { Future<void>? abortTrigger, }) async {
    final response = await deleteThemeWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Ficha con agencia, contactos detectados, destacado y temáticas
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getProductReviewWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos/{id}'
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

  /// Ficha con agencia, contactos detectados, destacado y temáticas
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ProductReview?> getProductReview(String id, { Future<void>? abortTrigger, }) async {
    final response = await getProductReviewWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductReview',) as ProductReview;
    
    }
    return null;
  }

  /// Agencia con sus documentos descargables y sus dueños
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getProviderReviewWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores/{id}'
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

  /// Agencia con sus documentos descargables y sus dueños
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ProviderReview?> getProviderReview(String id, { Future<void>? abortTrigger, }) async {
    final response = await getProviderReviewWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProviderReview',) as ProviderReview;
    
    }
    return null;
  }

  /// Productos por estado, el cambio más antiguo primero (máximo 200)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] status:
  Future<Response> listProductQueueWithHttpInfo({ String? status, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
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

  /// Productos por estado, el cambio más antiguo primero (máximo 200)
  ///
  /// Parameters:
  ///
  /// * [String] status:
  Future<ProductQueue?> listProductQueue({ String? status, Future<void>? abortTrigger, }) async {
    final response = await listProductQueueWithHttpInfo(status: status, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductQueue',) as ProductQueue;
    
    }
    return null;
  }

  /// Agencias por estado, la enviada hace más tiempo primero (máximo 200)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] status:
  Future<Response> listProviderQueueWithHttpInfo({ String? status, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (status != null) {
      queryParams.addAll(_queryParams('', 'status', status));
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

  /// Agencias por estado, la enviada hace más tiempo primero (máximo 200)
  ///
  /// Parameters:
  ///
  /// * [String] status:
  Future<ProviderQueue?> listProviderQueue({ String? status, Future<void>? abortTrigger, }) async {
    final response = await listProviderQueueWithHttpInfo(status: status, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProviderQueue',) as ProviderQueue;
    
    }
    return null;
  }

  /// Historial de tasas (hasta 365)
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listRatesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/tasas';

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

  /// Historial de tasas (hasta 365)
  Future<RateList?> listRates({ Future<void>? abortTrigger, }) async {
    final response = await listRatesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'RateList',) as RateList;
    
    }
    return null;
  }

  /// Personas de Central y sus roles
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listStaffWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/equipo';

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

  /// Personas de Central y sus roles
  Future<StaffList?> listStaff({ Future<void>? abortTrigger, }) async {
    final response = await listStaffWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StaffList',) as StaffList;
    
    }
    return null;
  }

  /// Rechaza una agencia en revisión, con motivo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> rejectProviderWithHttpInfo(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores/{id}/rechazar'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reasonInput;

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

  /// Rechaza una agencia en revisión, con motivo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Company?> rejectProvider(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await rejectProviderWithHttpInfo(id, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Company',) as Company;
    
    }
    return null;
  }

  /// Devuelve a borrador un producto en revisión, con motivo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> returnProductWithHttpInfo(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos/{id}/devolver'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reasonInput;

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

  /// Devuelve a borrador un producto en revisión, con motivo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<ProductDetail?> returnProduct(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await returnProductWithHttpInfo(id, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductDetail',) as ProductDetail;
    
    }
    return null;
  }

  /// Fija la comisión propia de la agencia (0 a 50) o la quita (null)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [CommissionInput] commissionInput (required):
  Future<Response> setProviderCommissionWithHttpInfo(String id, CommissionInput commissionInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores/{id}/comision'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = commissionInput;

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

  /// Fija la comisión propia de la agencia (0 a 50) o la quita (null)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [CommissionInput] commissionInput (required):
  Future<Company?> setProviderCommission(String id, CommissionInput commissionInput, { Future<void>? abortTrigger, }) async {
    final response = await setProviderCommissionWithHttpInfo(id, commissionInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Company',) as Company;
    
    }
    return null;
  }

  /// Fija la tasa de un día; repetir el día la corrige
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RateInput] rateInput (required):
  Future<Response> setRateWithHttpInfo(RateInput rateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/tasas';

    // ignore: prefer_final_locals
    Object? postBody = rateInput;

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

  /// Fija la tasa de un día; repetir el día la corrige
  ///
  /// Parameters:
  ///
  /// * [RateInput] rateInput (required):
  Future<Rate?> setRate(RateInput rateInput, { Future<void>? abortTrigger, }) async {
    final response = await setRateWithHttpInfo(rateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Rate',) as Rate;
    
    }
    return null;
  }

  /// Reemplaza las reglas de reserva
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SettingsInput] settingsInput (required):
  Future<Response> setSettingsWithHttpInfo(SettingsInput settingsInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/ajustes';

    // ignore: prefer_final_locals
    Object? postBody = settingsInput;

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

  /// Reemplaza las reglas de reserva
  ///
  /// Parameters:
  ///
  /// * [SettingsInput] settingsInput (required):
  Future<Settings?> setSettings(SettingsInput settingsInput, { Future<void>? abortTrigger, }) async {
    final response = await setSettingsWithHttpInfo(settingsInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Settings',) as Settings;
    
    }
    return null;
  }

  /// Fija los roles de Central de una persona por su correo (una lista vacía la saca de Central)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SetStaffRolesInput] setStaffRolesInput (required):
  Future<Response> setStaffRolesWithHttpInfo(SetStaffRolesInput setStaffRolesInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/equipo';

    // ignore: prefer_final_locals
    Object? postBody = setStaffRolesInput;

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

  /// Fija los roles de Central de una persona por su correo (una lista vacía la saca de Central)
  ///
  /// Parameters:
  ///
  /// * [SetStaffRolesInput] setStaffRolesInput (required):
  Future<StaffPerson?> setStaffRoles(SetStaffRolesInput setStaffRolesInput, { Future<void>? abortTrigger, }) async {
    final response = await setStaffRolesWithHttpInfo(setStaffRolesInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'StaffPerson',) as StaffPerson;
    
    }
    return null;
  }

  /// Suspende una agencia aprobada, con motivo: sale del catálogo público
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> suspendProviderWithHttpInfo(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/proveedores/{id}/suspender'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reasonInput;

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

  /// Suspende una agencia aprobada, con motivo: sale del catálogo público
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Company?> suspendProvider(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await suspendProviderWithHttpInfo(id, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Company',) as Company;
    
    }
    return null;
  }

  /// Pausa un producto publicado por contenido engañoso, con motivo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> unpublishProductWithHttpInfo(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/productos/{id}/despublicar'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reasonInput;

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

  /// Pausa un producto publicado por contenido engañoso, con motivo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<ProductDetail?> unpublishProduct(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await unpublishProductWithHttpInfo(id, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductDetail',) as ProductDetail;
    
    }
    return null;
  }

  /// Edita un punto de embarque
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BoardingPointUpdateInput] boardingPointUpdateInput (required):
  Future<Response> updateBoardingPointWithHttpInfo(String id, BoardingPointUpdateInput boardingPointUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/puntos-de-embarque/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = boardingPointUpdateInput;

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

  /// Edita un punto de embarque
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [BoardingPointUpdateInput] boardingPointUpdateInput (required):
  Future<BoardingPoint?> updateBoardingPoint(String id, BoardingPointUpdateInput boardingPointUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateBoardingPointWithHttpInfo(id, boardingPointUpdateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BoardingPoint',) as BoardingPoint;
    
    }
    return null;
  }

  /// Edita un destino
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [DestinationUpdateInput] destinationUpdateInput (required):
  Future<Response> updateDestinationWithHttpInfo(String id, DestinationUpdateInput destinationUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/catalogos/destinos/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = destinationUpdateInput;

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

  /// Edita un destino
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [DestinationUpdateInput] destinationUpdateInput (required):
  Future<Destination?> updateDestination(String id, DestinationUpdateInput destinationUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateDestinationWithHttpInfo(id, destinationUpdateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Destination',) as Destination;
    
    }
    return null;
  }

  /// Edita una temática
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ThemeUpdateInput] themeUpdateInput (required):
  Future<Response> updateThemeWithHttpInfo(String id, ThemeUpdateInput themeUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/tematicas/{id}'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = themeUpdateInput;

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

  /// Edita una temática
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ThemeUpdateInput] themeUpdateInput (required):
  Future<TravelTheme?> updateTheme(String id, ThemeUpdateInput themeUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateThemeWithHttpInfo(id, themeUpdateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TravelTheme',) as TravelTheme;
    
    }
    return null;
  }
}
