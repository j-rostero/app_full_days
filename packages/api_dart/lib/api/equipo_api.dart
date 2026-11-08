//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class EquipoApi {
  EquipoApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Suma a una persona por su correo. Si aún no tiene cuenta, la tendrá al registrarse con ese correo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [AddTeamMemberInput] addTeamMemberInput (required):
  Future<Response> addTeamMemberWithHttpInfo(String providerId, AddTeamMemberInput addTeamMemberInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/equipo'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = addTeamMemberInput;

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

  /// Suma a una persona por su correo. Si aún no tiene cuenta, la tendrá al registrarse con ese correo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [AddTeamMemberInput] addTeamMemberInput (required):
  Future<TeamMember?> addTeamMember(String providerId, AddTeamMemberInput addTeamMemberInput, { Future<void>? abortTrigger, }) async {
    final response = await addTeamMemberWithHttpInfo(providerId, addTeamMemberInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TeamMember',) as TeamMember;
    
    }
    return null;
  }

  /// Cambia el rol de una persona del equipo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] memberId (required):
  ///
  /// * [ChangeTeamRoleInput] changeTeamRoleInput (required):
  Future<Response> changeTeamRoleWithHttpInfo(String providerId, String memberId, ChangeTeamRoleInput changeTeamRoleInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/equipo/{memberId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{memberId}', memberId);

    // ignore: prefer_final_locals
    Object? postBody = changeTeamRoleInput;

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

  /// Cambia el rol de una persona del equipo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] memberId (required):
  ///
  /// * [ChangeTeamRoleInput] changeTeamRoleInput (required):
  Future<TeamMember?> changeTeamRole(String providerId, String memberId, ChangeTeamRoleInput changeTeamRoleInput, { Future<void>? abortTrigger, }) async {
    final response = await changeTeamRoleWithHttpInfo(providerId, memberId, changeTeamRoleInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TeamMember',) as TeamMember;
    
    }
    return null;
  }

  /// Personas del equipo de la agencia y su rol
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> listTeamWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/equipo'
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

  /// Personas del equipo de la agencia y su rol
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<TeamList?> listTeam(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await listTeamWithHttpInfo(providerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'TeamList',) as TeamList;
    
    }
    return null;
  }

  /// Quita a una persona del equipo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] memberId (required):
  Future<Response> removeTeamMemberWithHttpInfo(String providerId, String memberId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/equipo/{memberId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{memberId}', memberId);

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

  /// Quita a una persona del equipo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] memberId (required):
  Future<void> removeTeamMember(String providerId, String memberId, { Future<void>? abortTrigger, }) async {
    final response = await removeTeamMemberWithHttpInfo(providerId, memberId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
