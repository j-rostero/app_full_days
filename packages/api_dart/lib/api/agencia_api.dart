//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AgenciaApi {
  AgenciaApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Adjunta un documento ya subido (archivo propio y listo)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [AttachDocumentInput] attachDocumentInput (required):
  Future<Response> attachCompanyDocumentWithHttpInfo(String providerId, AttachDocumentInput attachDocumentInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/documentos'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = attachDocumentInput;

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

  /// Adjunta un documento ya subido (archivo propio y listo)
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [AttachDocumentInput] attachDocumentInput (required):
  Future<ProviderDocument?> attachCompanyDocument(String providerId, AttachDocumentInput attachDocumentInput, { Future<void>? abortTrigger, }) async {
    final response = await attachCompanyDocumentWithHttpInfo(providerId, attachDocumentInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProviderDocument',) as ProviderDocument;
    
    }
    return null;
  }

  /// Datos de la agencia, estado y distintivo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> getCompanyWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/empresa'
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

  /// Datos de la agencia, estado y distintivo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Company?> getCompany(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await getCompanyWithHttpInfo(providerId, abortTrigger: abortTrigger,);
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

  /// Documentos de verificación, con enlace de descarga de cinco minutos
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> listCompanyDocumentsWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/documentos'
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

  /// Documentos de verificación, con enlace de descarga de cinco minutos
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<ProviderDocumentList?> listCompanyDocuments(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await listCompanyDocumentsWithHttpInfo(providerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ProviderDocumentList',) as ProviderDocumentList;
    
    }
    return null;
  }

  /// Registra una agencia u organizador; quien la registra queda como dueño
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProviderInput] providerInput (required):
  Future<Response> registerProviderWithHttpInfo(ProviderInput providerInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/proveedores';

    // ignore: prefer_final_locals
    Object? postBody = providerInput;

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

  /// Registra una agencia u organizador; quien la registra queda como dueño
  ///
  /// Parameters:
  ///
  /// * [ProviderInput] providerInput (required):
  Future<Company?> registerProvider(ProviderInput providerInput, { Future<void>? abortTrigger, }) async {
    final response = await registerProviderWithHttpInfo(providerInput, abortTrigger: abortTrigger,);
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

  /// Quita un documento
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] documentId (required):
  Future<Response> removeCompanyDocumentWithHttpInfo(String providerId, String documentId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/documentos/{documentId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{documentId}', documentId);

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

  /// Quita un documento
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] documentId (required):
  Future<void> removeCompanyDocument(String providerId, String documentId, { Future<void>? abortTrigger, }) async {
    final response = await removeCompanyDocumentWithHttpInfo(providerId, documentId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Envía la agencia a verificación de Central
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> submitCompanyWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/empresa/enviar'
      .replaceAll('{providerId}', providerId);

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

  /// Envía la agencia a verificación de Central
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Company?> submitCompany(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await submitCompanyWithHttpInfo(providerId, abortTrigger: abortTrigger,);
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

  /// Cambia los datos de la agencia (el RIF no cambia)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ProviderUpdateInput] providerUpdateInput (required):
  Future<Response> updateCompanyWithHttpInfo(String providerId, ProviderUpdateInput providerUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/empresa'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = providerUpdateInput;

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

  /// Cambia los datos de la agencia (el RIF no cambia)
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ProviderUpdateInput] providerUpdateInput (required):
  Future<Company?> updateCompany(String providerId, ProviderUpdateInput providerUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateCompanyWithHttpInfo(providerId, providerUpdateInput, abortTrigger: abortTrigger,);
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
}
