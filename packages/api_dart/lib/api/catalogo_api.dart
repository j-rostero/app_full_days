//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class CatalogoApi {
  CatalogoApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Guarda un viaje publicado (idempotente)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] productId (required):
  Future<Response> addFavoriteWithHttpInfo(String productId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/favoritos/{productId}'
      .replaceAll('{productId}', productId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    const contentTypes = <String>[];


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

  /// Guarda un viaje publicado (idempotente)
  ///
  /// Parameters:
  ///
  /// * [String] productId (required):
  Future<void> addFavorite(String productId, { Future<void>? abortTrigger, }) async {
    final response = await addFavoriteWithHttpInfo(productId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Disponibilidad de una salida visible: precio, puestos y habitaciones libres, y la ficha que se vende
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getAvailabilityWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/salidas/{id}'
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

  /// Disponibilidad de una salida visible: precio, puestos y habitaciones libres, y la ficha que se vende
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Availability?> getAvailability(String id, { Future<void>? abortTrigger, }) async {
    final response = await getAvailabilityWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Availability',) as Availability;
    
    }
    return null;
  }

  /// Agencia aprobada y sus viajes publicados; sin datos legales ni de contacto
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPublicAgencyWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agencias/{id}'
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

  /// Agencia aprobada y sus viajes publicados; sin datos legales ni de contacto
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<PublicAgency?> getPublicAgency(String id, { Future<void>? abortTrigger, }) async {
    final response = await getPublicAgencyWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PublicAgency',) as PublicAgency;
    
    }
    return null;
  }

  /// Ficha publicada con fotos, agencia, destino y próximas fechas (hasta 60)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getPublicProductWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/productos/{id}'
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

  /// Ficha publicada con fotos, agencia, destino y próximas fechas (hasta 60)
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<PublicProduct?> getPublicProduct(String id, { Future<void>? abortTrigger, }) async {
    final response = await getPublicProductWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PublicProduct',) as PublicProduct;
    
    }
    return null;
  }

  /// Viajes guardados que siguen publicados
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listFavoritesWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/favoritos';

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

  /// Viajes guardados que siguen publicados
  Future<FavoriteList?> listFavorites({ Future<void>? abortTrigger, }) async {
    final response = await listFavoritesWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'FavoriteList',) as FavoriteList;
    
    }
    return null;
  }

  /// Quita un viaje de los guardados
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] productId (required):
  Future<Response> removeFavoriteWithHttpInfo(String productId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/favoritos/{productId}'
      .replaceAll('{productId}', productId);

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

  /// Quita un viaje de los guardados
  ///
  /// Parameters:
  ///
  /// * [String] productId (required):
  Future<void> removeFavorite(String productId, { Future<void>? abortTrigger, }) async {
    final response = await removeFavoriteWithHttpInfo(productId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Busca salidas visibles con filtros y orden; páginas de 20
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] q:
  ///
  /// * [String] destino:
  ///
  /// * [String] desde:
  ///
  /// * [String] fechaDesde:
  ///
  /// * [String] fechaHasta:
  ///
  /// * [String] tipo:
  ///
  /// * [String] categoria:
  ///
  /// * [String] tematica:
  ///
  /// * [num] precioMax:
  ///
  /// * [String] incluye:
  ///
  /// * [Object] verificados:
  ///
  /// * [Object] ninos:
  ///
  /// * [Object] mascotas:
  ///
  /// * [String] orden:
  ///
  /// * [int] pagina:
  Future<Response> searchDeparturesWithHttpInfo({ String? q, String? destino, String? desde, String? fechaDesde, String? fechaHasta, String? tipo, String? categoria, String? tematica, num? precioMax, String? incluye, Object? verificados, Object? ninos, Object? mascotas, String? orden, int? pagina, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/salidas';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (q != null) {
      queryParams.addAll(_queryParams('', 'q', q));
    }
    if (destino != null) {
      queryParams.addAll(_queryParams('', 'destino', destino));
    }
    if (desde != null) {
      queryParams.addAll(_queryParams('', 'desde', desde));
    }
    if (fechaDesde != null) {
      queryParams.addAll(_queryParams('', 'fechaDesde', fechaDesde));
    }
    if (fechaHasta != null) {
      queryParams.addAll(_queryParams('', 'fechaHasta', fechaHasta));
    }
    if (tipo != null) {
      queryParams.addAll(_queryParams('', 'tipo', tipo));
    }
    if (categoria != null) {
      queryParams.addAll(_queryParams('', 'categoria', categoria));
    }
    if (tematica != null) {
      queryParams.addAll(_queryParams('', 'tematica', tematica));
    }
    if (precioMax != null) {
      queryParams.addAll(_queryParams('', 'precioMax', precioMax));
    }
    if (incluye != null) {
      queryParams.addAll(_queryParams('', 'incluye', incluye));
    }
    if (verificados != null) {
      queryParams.addAll(_queryParams('', 'verificados', verificados));
    }
    if (ninos != null) {
      queryParams.addAll(_queryParams('', 'ninos', ninos));
    }
    if (mascotas != null) {
      queryParams.addAll(_queryParams('', 'mascotas', mascotas));
    }
    if (orden != null) {
      queryParams.addAll(_queryParams('', 'orden', orden));
    }
    if (pagina != null) {
      queryParams.addAll(_queryParams('', 'pagina', pagina));
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

  /// Busca salidas visibles con filtros y orden; páginas de 20
  ///
  /// Parameters:
  ///
  /// * [String] q:
  ///
  /// * [String] destino:
  ///
  /// * [String] desde:
  ///
  /// * [String] fechaDesde:
  ///
  /// * [String] fechaHasta:
  ///
  /// * [String] tipo:
  ///
  /// * [String] categoria:
  ///
  /// * [String] tematica:
  ///
  /// * [num] precioMax:
  ///
  /// * [String] incluye:
  ///
  /// * [Object] verificados:
  ///
  /// * [Object] ninos:
  ///
  /// * [Object] mascotas:
  ///
  /// * [String] orden:
  ///
  /// * [int] pagina:
  Future<SearchResult?> searchDepartures({ String? q, String? destino, String? desde, String? fechaDesde, String? fechaHasta, String? tipo, String? categoria, String? tematica, num? precioMax, String? incluye, Object? verificados, Object? ninos, Object? mascotas, String? orden, int? pagina, Future<void>? abortTrigger, }) async {
    final response = await searchDeparturesWithHttpInfo(q: q, destino: destino, desde: desde, fechaDesde: fechaDesde, fechaHasta: fechaHasta, tipo: tipo, categoria: categoria, tematica: tematica, precioMax: precioMax, incluye: incluye, verificados: verificados, ninos: ninos, mascotas: mascotas, orden: orden, pagina: pagina, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SearchResult',) as SearchResult;
    
    }
    return null;
  }
}
