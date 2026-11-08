//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ReservasApi {
  ReservasApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Cancela la reserva; si corresponde, deja el reembolso pendiente para la agencia
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> cancelBookingWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/cancelar'
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

  /// Cancela la reserva; si corresponde, deja el reembolso pendiente para la agencia
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Booking?> cancelBooking(String id, { Future<void>? abortTrigger, }) async {
    final response = await cancelBookingWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }

  /// La agencia cancela una reserva y devuelve todo lo pagado
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] bookingId (required):
  Future<Response> cancelProviderBookingWithHttpInfo(String providerId, String bookingId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reservas/{bookingId}/cancelar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{bookingId}', bookingId);

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

  /// La agencia cancela una reserva y devuelve todo lo pagado
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] bookingId (required):
  Future<Booking?> cancelProviderBooking(String providerId, String bookingId, { Future<void>? abortTrigger, }) async {
    final response = await cancelProviderBookingWithHttpInfo(providerId, bookingId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }

  /// Una reserva propia con precio, abono, pagado, saldo, pasajeros e instrucciones de pago
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getMyBookingWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}'
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

  /// Una reserva propia con precio, abono, pagado, saldo, pasajeros e instrucciones de pago
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Booking?> getMyBooking(String id, { Future<void>? abortTrigger, }) async {
    final response = await getMyBookingWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }

  /// Una reserva de la agencia, con el contacto si es venta propia
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] bookingId (required):
  Future<Response> getProviderBookingWithHttpInfo(String providerId, String bookingId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reservas/{bookingId}'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{bookingId}', bookingId);

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

  /// Una reserva de la agencia, con el contacto si es venta propia
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] bookingId (required):
  Future<Booking?> getProviderBooking(String providerId, String bookingId, { Future<void>? abortTrigger, }) async {
    final response = await getProviderBookingWithHttpInfo(providerId, bookingId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }

  /// Aparta puestos y habitaciones y crea la reserva por los minutos de apartado
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [HoldInput] holdInput (required):
  Future<Response> holdBookingWithHttpInfo(HoldInput holdInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas';

    // ignore: prefer_final_locals
    Object? postBody = holdInput;

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

  /// Aparta puestos y habitaciones y crea la reserva por los minutos de apartado
  ///
  /// Parameters:
  ///
  /// * [HoldInput] holdInput (required):
  Future<Booking?> holdBooking(HoldInput holdInput, { Future<void>? abortTrigger, }) async {
    final response = await holdBookingWithHttpInfo(holdInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }

  /// Reservas propias, la más nueva primero (máximo 100)
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listMyBookingsWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas';

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

  /// Reservas propias, la más nueva primero (máximo 100)
  Future<BookingList?> listMyBookings({ Future<void>? abortTrigger, }) async {
    final response = await listMyBookingsWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BookingList',) as BookingList;
    
    }
    return null;
  }

  /// Reservas de la agencia; filtros por salida y estado (máximo 300)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId:
  ///
  /// * [String] status:
  Future<Response> listProviderBookingsWithHttpInfo(String providerId, { String? departureId, String? status, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reservas'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody;

    final queryParams = <QueryParam>[];
    final headerParams = <String, String>{};
    final formParams = <String, String>{};

    if (departureId != null) {
      queryParams.addAll(_queryParams('', 'departureId', departureId));
    }
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

  /// Reservas de la agencia; filtros por salida y estado (máximo 300)
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] departureId:
  ///
  /// * [String] status:
  Future<BookingList?> listProviderBookings(String providerId, { String? departureId, String? status, Future<void>? abortTrigger, }) async {
    final response = await listProviderBookingsWithHttpInfo(providerId, departureId: departureId, status: status, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'BookingList',) as BookingList;
    
    }
    return null;
  }

  /// Cuánto se devolvería si se cancela ahora y qué regla lo dice
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> previewCancellationWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/cancelacion'
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

  /// Cuánto se devolvería si se cancela ahora y qué regla lo dice
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Cancellation?> previewCancellation(String id, { Future<void>? abortTrigger, }) async {
    final response = await previewCancellationWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Cancellation',) as Cancellation;
    
    }
    return null;
  }

  /// Precio exacto de una selección en una salida en venta, sin apartar
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [QuoteInput] quoteInput (required):
  Future<Response> quoteBookingWithHttpInfo(QuoteInput quoteInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/cotizar';

    // ignore: prefer_final_locals
    Object? postBody = quoteInput;

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

  /// Precio exacto de una selección en una salida en venta, sin apartar
  ///
  /// Parameters:
  ///
  /// * [QuoteInput] quoteInput (required):
  Future<Quote?> quoteBooking(QuoteInput quoteInput, { Future<void>? abortTrigger, }) async {
    final response = await quoteBookingWithHttpInfo(quoteInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Quote',) as Quote;
    
    }
    return null;
  }

  /// Nombre, cédula, fecha de nacimiento y restricciones de cada pasajero, en orden
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PassengersInput] passengersInput (required):
  Future<Response> setBookingPassengersWithHttpInfo(String id, PassengersInput passengersInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/pasajeros'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = passengersInput;

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

  /// Nombre, cédula, fecha de nacimiento y restricciones de cada pasajero, en orden
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [PassengersInput] passengersInput (required):
  Future<Booking?> setBookingPassengers(String id, PassengersInput passengersInput, { Future<void>? abortTrigger, }) async {
    final response = await setBookingPassengersWithHttpInfo(id, passengersInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Booking',) as Booking;
    
    }
    return null;
  }
}
