//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class YoApi {
  YoApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Guarda un pasajero frecuente
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [PassengerInput] passengerInput (required):
  Future<Response> createPassengerWithHttpInfo(PassengerInput passengerInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/pasajeros';

    // ignore: prefer_final_locals
    Object? postBody = passengerInput;

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

  /// Guarda un pasajero frecuente
  ///
  /// Parameters:
  ///
  /// * [PassengerInput] passengerInput (required):
  Future<Passenger?> createPassenger(PassengerInput passengerInput, { Future<void>? abortTrigger, }) async {
    final response = await createPassengerWithHttpInfo(passengerInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Passenger',) as Passenger;
    
    }
    return null;
  }

  /// Borra un pasajero frecuente
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] passengerId (required):
  Future<Response> deletePassengerWithHttpInfo(String passengerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/pasajeros/{passengerId}'
      .replaceAll('{passengerId}', passengerId);

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

  /// Borra un pasajero frecuente
  ///
  /// Parameters:
  ///
  /// * [String] passengerId (required):
  Future<void> deletePassenger(String passengerId, { Future<void>? abortTrigger, }) async {
    final response = await deletePassengerWithHttpInfo(passengerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Mi cuenta, mis agencias con su rol y mis roles de Central
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getMeWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo';

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

  /// Mi cuenta, mis agencias con su rol y mis roles de Central
  Future<Me?> getMe({ Future<void>? abortTrigger, }) async {
    final response = await getMeWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Me',) as Me;
    
    }
    return null;
  }

  /// Mis pasajeros frecuentes
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listPassengersWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/pasajeros';

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

  /// Mis pasajeros frecuentes
  Future<PassengerList?> listPassengers({ Future<void>? abortTrigger, }) async {
    final response = await listPassengersWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PassengerList',) as PassengerList;
    
    }
    return null;
  }

  /// Cambia mi nombre o mi teléfono
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdateInput] profileUpdateInput (required):
  Future<Response> updateMeWithHttpInfo(ProfileUpdateInput profileUpdateInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo';

    // ignore: prefer_final_locals
    Object? postBody = profileUpdateInput;

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

  /// Cambia mi nombre o mi teléfono
  ///
  /// Parameters:
  ///
  /// * [ProfileUpdateInput] profileUpdateInput (required):
  Future<Me?> updateMe(ProfileUpdateInput profileUpdateInput, { Future<void>? abortTrigger, }) async {
    final response = await updateMeWithHttpInfo(profileUpdateInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Me',) as Me;
    
    }
    return null;
  }

  /// Cambia un pasajero frecuente
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] passengerId (required):
  ///
  /// * [PassengerInput] passengerInput (required):
  Future<Response> updatePassengerWithHttpInfo(String passengerId, PassengerInput passengerInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/yo/pasajeros/{passengerId}'
      .replaceAll('{passengerId}', passengerId);

    // ignore: prefer_final_locals
    Object? postBody = passengerInput;

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

  /// Cambia un pasajero frecuente
  ///
  /// Parameters:
  ///
  /// * [String] passengerId (required):
  ///
  /// * [PassengerInput] passengerInput (required):
  Future<Passenger?> updatePassenger(String passengerId, PassengerInput passengerInput, { Future<void>? abortTrigger, }) async {
    final response = await updatePassengerWithHttpInfo(passengerId, passengerInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Passenger',) as Passenger;
    
    }
    return null;
  }
}
