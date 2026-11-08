//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ProductosApi {
  ProductosApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Crea un borrador de fullday, tour o excursión
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [CreateProductInput] createProductInput (required):
  Future<Response> createProductWithHttpInfo(String providerId, CreateProductInput createProductInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = createProductInput;

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

  /// Crea un borrador de fullday, tour o excursión
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [CreateProductInput] createProductInput (required):
  Future<ProductDetail?> createProduct(String providerId, CreateProductInput createProductInput, { Future<void>? abortTrigger, }) async {
    final response = await createProductWithHttpInfo(providerId, createProductInput, abortTrigger: abortTrigger,);
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

  /// Ficha con completitud por bloque y fotos
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<Response> getProductWithHttpInfo(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos/{productId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{productId}', productId);

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

  /// Ficha con completitud por bloque y fotos
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<ProductDetail?> getProduct(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    final response = await getProductWithHttpInfo(providerId, productId, abortTrigger: abortTrigger,);
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

  /// Productos de la agencia, el último cambiado primero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> listProductsWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos'
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

  /// Productos de la agencia, el último cambiado primero
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<ProductList?> listProducts(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await listProductsWithHttpInfo(providerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProductList',) as ProductList;
    
    }
    return null;
  }

  /// Pausa la venta de un producto publicado
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<Response> pauseProductWithHttpInfo(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos/{productId}/pausar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{productId}', productId);

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

  /// Pausa la venta de un producto publicado
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<ProductDetail?> pauseProduct(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    final response = await pauseProductWithHttpInfo(providerId, productId, abortTrigger: abortTrigger,);
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

  /// Publica, o envía a revisión de Central cuando corresponde
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<Response> publishProductWithHttpInfo(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos/{productId}/publicar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{productId}', productId);

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

  /// Publica, o envía a revisión de Central cuando corresponde
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  Future<ProductDetail?> publishProduct(String providerId, String productId, { Future<void>? abortTrigger, }) async {
    final response = await publishProductWithHttpInfo(providerId, productId, abortTrigger: abortTrigger,);
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

  /// Guarda la ficha entera; falla si otra pestaña la cambió desde la versión leída
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  ///
  /// * [SaveProductInput] saveProductInput (required):
  Future<Response> saveProductWithHttpInfo(String providerId, String productId, SaveProductInput saveProductInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/productos/{productId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{productId}', productId);

    // ignore: prefer_final_locals
    Object? postBody = saveProductInput;

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

  /// Guarda la ficha entera; falla si otra pestaña la cambió desde la versión leída
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] productId (required):
  ///
  /// * [SaveProductInput] saveProductInput (required):
  Future<ProductDetail?> saveProduct(String providerId, String productId, SaveProductInput saveProductInput, { Future<void>? abortTrigger, }) async {
    final response = await saveProductWithHttpInfo(providerId, productId, saveProductInput, abortTrigger: abortTrigger,);
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
}
