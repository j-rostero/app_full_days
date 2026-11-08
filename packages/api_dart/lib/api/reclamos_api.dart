//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReclamosApi {
  ReclamosApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// La agencia responde en un reclamo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] claimId (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Response> answerClaimWithHttpInfo(String providerId, String claimId, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reclamos/{claimId}/mensajes'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{claimId}', claimId);

    // ignore: prefer_final_locals
    Object? postBody = claimMessageInput;

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

  /// La agencia responde en un reclamo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] claimId (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Claim?> answerClaim(String providerId, String claimId, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    final response = await answerClaimWithHttpInfo(providerId, claimId, claimMessageInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }

  /// Central responde en un reclamo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Response> centralAnswerClaimWithHttpInfo(String id, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/reclamos/{id}/mensajes'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = claimMessageInput;

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

  /// Central responde en un reclamo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Claim?> centralAnswerClaim(String id, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    final response = await centralAnswerClaimWithHttpInfo(id, claimMessageInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }

  /// Pide que FullDays intervenga en el reclamo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> escalateClaimWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reclamos/{id}/escalar'
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

  /// Pide que FullDays intervenga en el reclamo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Claim?> escalateClaim(String id, { Future<void>? abortTrigger, }) async {
    final response = await escalateClaimWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }

  /// Todos los reclamos por estado, el que más espera primero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<Response> listAllClaimsWithHttpInfo({ String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/reclamos';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (estado != null) {
      queryParams.addAll(_queryParams('', 'estado', estado));
    }
    if (reserva != null) {
      queryParams.addAll(_queryParams('', 'reserva', reserva));
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

  /// Todos los reclamos por estado, el que más espera primero
  ///
  /// Parameters:
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<ClaimList?> listAllClaims({ String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    final response = await listAllClaimsWithHttpInfo(estado: estado, reserva: reserva, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClaimList',) as ClaimList;
    
    }
    return null;
  }

  /// Reclamos propios con sus mensajes
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<Response> listMyClaimsWithHttpInfo({ String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reclamos';

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (estado != null) {
      queryParams.addAll(_queryParams('', 'estado', estado));
    }
    if (reserva != null) {
      queryParams.addAll(_queryParams('', 'reserva', reserva));
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

  /// Reclamos propios con sus mensajes
  ///
  /// Parameters:
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<ClaimList?> listMyClaims({ String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    final response = await listMyClaimsWithHttpInfo(estado: estado, reserva: reserva, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClaimList',) as ClaimList;
    
    }
    return null;
  }

  /// Reclamos sobre reservas de la agencia
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<Response> listProviderClaimsWithHttpInfo(String providerId, { String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reclamos'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (estado != null) {
      queryParams.addAll(_queryParams('', 'estado', estado));
    }
    if (reserva != null) {
      queryParams.addAll(_queryParams('', 'reserva', reserva));
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

  /// Reclamos sobre reservas de la agencia
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] estado:
  ///
  /// * [String] reserva:
  Future<ClaimList?> listProviderClaims(String providerId, { String? estado, String? reserva, Future<void>? abortTrigger, }) async {
    final response = await listProviderClaimsWithHttpInfo(providerId, estado: estado, reserva: reserva, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ClaimList',) as ClaimList;
    
    }
    return null;
  }

  /// Abre un reclamo sobre una reserva con algún pago confirmado
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimInput] claimInput (required):
  Future<Response> openClaimWithHttpInfo(String id, ClaimInput claimInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/reclamos'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = claimInput;

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

  /// Abre un reclamo sobre una reserva con algún pago confirmado
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimInput] claimInput (required):
  Future<Claim?> openClaim(String id, ClaimInput claimInput, { Future<void>? abortTrigger, }) async {
    final response = await openClaimWithHttpInfo(id, claimInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }

  /// Cierra el reclamo con la resolución y avisa al viajero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimResolveInput] claimResolveInput (required):
  Future<Response> resolveClaimWithHttpInfo(String id, ClaimResolveInput claimResolveInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/reclamos/{id}/resolver'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = claimResolveInput;

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

  /// Cierra el reclamo con la resolución y avisa al viajero
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimResolveInput] claimResolveInput (required):
  Future<Claim?> resolveClaim(String id, ClaimResolveInput claimResolveInput, { Future<void>? abortTrigger, }) async {
    final response = await resolveClaimWithHttpInfo(id, claimResolveInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }

  /// El viajero responde en su reclamo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Response> writeClaimWithHttpInfo(String id, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reclamos/{id}/mensajes'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = claimMessageInput;

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

  /// El viajero responde en su reclamo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ClaimMessageInput] claimMessageInput (required):
  Future<Claim?> writeClaim(String id, ClaimMessageInput claimMessageInput, { Future<void>? abortTrigger, }) async {
    final response = await writeClaimWithHttpInfo(id, claimMessageInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Claim',) as Claim;
    
    }
    return null;
  }
}
