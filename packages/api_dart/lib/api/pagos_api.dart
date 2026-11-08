//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class PagosApi {
  PagosApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Confirma un pago pendiente: lo aplica a la reserva y lo asienta
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] paymentId (required):
  Future<Response> confirmPaymentWithHttpInfo(String providerId, String paymentId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/pagos/{paymentId}/confirmar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{paymentId}', paymentId);

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

  /// Confirma un pago pendiente: lo aplica a la reserva y lo asienta
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] paymentId (required):
  Future<Payment?> confirmPayment(String providerId, String paymentId, { Future<void>? abortTrigger, }) async {
    final response = await confirmPaymentWithHttpInfo(providerId, paymentId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Payment',) as Payment;
    
    }
    return null;
  }

  /// Venta propia (WhatsApp, oficina) con contacto y, si ya pagó, el dinero recibido
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ManualBookingInput] manualBookingInput (required):
  Future<Response> createManualBookingWithHttpInfo(String providerId, ManualBookingInput manualBookingInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/reservas'
      .replaceAll('{providerId}', providerId);

    // ignore: prefer_final_locals
    Object? postBody = manualBookingInput;

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

  /// Venta propia (WhatsApp, oficina) con contacto y, si ya pagó, el dinero recibido
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [ManualBookingInput] manualBookingInput (required):
  Future<Booking?> createManualBooking(String providerId, ManualBookingInput manualBookingInput, { Future<void>? abortTrigger, }) async {
    final response = await createManualBookingWithHttpInfo(providerId, manualBookingInput, abortTrigger: abortTrigger,);
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

  /// Claves públicas Ed25519 vigentes y retiradas, por id
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> getVoucherKeysWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/vouchers/llaves';

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

  /// Claves públicas Ed25519 vigentes y retiradas, por id
  Future<VoucherKeys?> getVoucherKeys({ Future<void>? abortTrigger, }) async {
    final response = await getVoucherKeysWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VoucherKeys',) as VoucherKeys;
    
    }
    return null;
  }

  /// Un voucher firmado por pasajero, cuando la reserva tiene el abono o el total confirmado
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getVouchersWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/vouchers'
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

  /// Un voucher firmado por pasajero, cuando la reserva tiene el abono o el total confirmado
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<VoucherList?> getVouchers(String id, { Future<void>? abortTrigger, }) async {
    final response = await getVouchersWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'VoucherList',) as VoucherList;
    
    }
    return null;
  }

  /// Pagos de una reserva propia con su estado y motivo de rechazo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> listBookingPaymentsWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/pagos'
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

  /// Pagos de una reserva propia con su estado y motivo de rechazo
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<PaymentList?> listBookingPayments(String id, { Future<void>? abortTrigger, }) async {
    final response = await listBookingPaymentsWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PaymentList',) as PaymentList;
    
    }
    return null;
  }

  /// Pagos por estado, el más antiguo primero (máximo 200)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] status:
  Future<Response> listProviderPaymentsWithHttpInfo(String providerId, { String? status, Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/pagos'
      .replaceAll('{providerId}', providerId);

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

  /// Pagos por estado, el más antiguo primero (máximo 200)
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] status:
  Future<PaymentList?> listProviderPayments(String providerId, { String? status, Future<void>? abortTrigger, }) async {
    final response = await listProviderPaymentsWithHttpInfo(providerId, status: status, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'PaymentList',) as PaymentList;
    
    }
    return null;
  }

  /// Rechaza un pago pendiente con un motivo para el viajero
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] paymentId (required):
  ///
  /// * [RejectPaymentInput] rejectPaymentInput (required):
  Future<Response> rejectPaymentWithHttpInfo(String providerId, String paymentId, RejectPaymentInput rejectPaymentInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/pagos/{paymentId}/rechazar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{paymentId}', paymentId);

    // ignore: prefer_final_locals
    Object? postBody = rejectPaymentInput;

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

  /// Rechaza un pago pendiente con un motivo para el viajero
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] paymentId (required):
  ///
  /// * [RejectPaymentInput] rejectPaymentInput (required):
  Future<Payment?> rejectPayment(String providerId, String paymentId, RejectPaymentInput rejectPaymentInput, { Future<void>? abortTrigger, }) async {
    final response = await rejectPaymentWithHttpInfo(providerId, paymentId, rejectPaymentInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Payment',) as Payment;
    
    }
    return null;
  }

  /// Reporta un pago hecho a la agencia; la misma clave de idempotencia devuelve el mismo pago
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReportPaymentInput] reportPaymentInput (required):
  Future<Response> reportPaymentWithHttpInfo(String id, ReportPaymentInput reportPaymentInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/pagos'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reportPaymentInput;

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

  /// Reporta un pago hecho a la agencia; la misma clave de idempotencia devuelve el mismo pago
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReportPaymentInput] reportPaymentInput (required):
  Future<Payment?> reportPayment(String id, ReportPaymentInput reportPaymentInput, { Future<void>? abortTrigger, }) async {
    final response = await reportPaymentWithHttpInfo(id, reportPaymentInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Payment',) as Payment;
    
    }
    return null;
  }
}
