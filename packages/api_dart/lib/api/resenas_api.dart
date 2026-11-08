//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class ResenasApi {
  ResenasApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Reputación de la agencia y sus últimas 100 reseñas visibles
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> getAgencyReputationWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/agencias/{id}/reputacion'
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

  /// Reputación de la agencia y sus últimas 100 reseñas visibles
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ReviewList?> getAgencyReputation(String id, { Future<void>? abortTrigger, }) async {
    final response = await getAgencyReputationWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReviewList',) as ReviewList;
    
    }
    return null;
  }

  /// Oculta una reseña con motivo y cierra el reporte
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> hideReviewWithHttpInfo(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/resenas/{id}/ocultar'
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

  /// Oculta una reseña con motivo y cierra el reporte
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<void> hideReview(String id, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await hideReviewWithHttpInfo(id, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Cola de moderación: reseñas reportadas u ocultas
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> listModerationQueueWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/resenas';

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

  /// Cola de moderación: reseñas reportadas u ocultas
  Future<ReviewList?> listModerationQueue({ Future<void>? abortTrigger, }) async {
    final response = await listModerationQueueWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReviewList',) as ReviewList;
    
    }
    return null;
  }

  /// Reputación del viaje y sus últimas 100 reseñas visibles
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> listProductReviewsWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/productos/{id}/resenas'
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

  /// Reputación del viaje y sus últimas 100 reseñas visibles
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<ReviewList?> listProductReviews(String id, { Future<void>? abortTrigger, }) async {
    final response = await listProductReviewsWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReviewList',) as ReviewList;
    
    }
    return null;
  }

  /// Reseñas de la agencia, visibles u ocultas, con su moderación
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<Response> listProviderReviewsWithHttpInfo(String providerId, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/resenas'
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

  /// Reseñas de la agencia, visibles u ocultas, con su moderación
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  Future<ReviewList?> listProviderReviews(String providerId, { Future<void>? abortTrigger, }) async {
    final response = await listProviderReviewsWithHttpInfo(providerId, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'ReviewList',) as ReviewList;
    
    }
    return null;
  }

  /// La única respuesta pública de la agencia a una reseña
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] reviewId (required):
  ///
  /// * [ReplyInput] replyInput (required):
  Future<Response> replyReviewWithHttpInfo(String providerId, String reviewId, ReplyInput replyInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/resenas/{reviewId}/responder'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{reviewId}', reviewId);

    // ignore: prefer_final_locals
    Object? postBody = replyInput;

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

  /// La única respuesta pública de la agencia a una reseña
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] reviewId (required):
  ///
  /// * [ReplyInput] replyInput (required):
  Future<Review?> replyReview(String providerId, String reviewId, ReplyInput replyInput, { Future<void>? abortTrigger, }) async {
    final response = await replyReviewWithHttpInfo(providerId, reviewId, replyInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Review',) as Review;
    
    }
    return null;
  }

  /// Pide a Central que revise una reseña, con motivo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] reviewId (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<Response> reportReviewWithHttpInfo(String providerId, String reviewId, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/pro/{providerId}/resenas/{reviewId}/reportar'
      .replaceAll('{providerId}', providerId)
      .replaceAll('{reviewId}', reviewId);

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

  /// Pide a Central que revise una reseña, con motivo
  ///
  /// Parameters:
  ///
  /// * [String] providerId (required):
  ///
  /// * [String] reviewId (required):
  ///
  /// * [ReasonInput] reasonInput (required):
  Future<void> reportReview(String providerId, String reviewId, ReasonInput reasonInput, { Future<void>? abortTrigger, }) async {
    final response = await reportReviewWithHttpInfo(providerId, reviewId, reasonInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Reseña un viaje realizado: una vez y hasta 30 días después
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReviewInput] reviewInput (required):
  Future<Response> reviewBookingWithHttpInfo(String id, ReviewInput reviewInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/reservas/{id}/resena'
      .replaceAll('{id}', id);

    // ignore: prefer_final_locals
    Object? postBody = reviewInput;

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

  /// Reseña un viaje realizado: una vez y hasta 30 días después
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  ///
  /// * [ReviewInput] reviewInput (required):
  Future<Review?> reviewBooking(String id, ReviewInput reviewInput, { Future<void>? abortTrigger, }) async {
    final response = await reviewBookingWithHttpInfo(id, reviewInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Review',) as Review;
    
    }
    return null;
  }

  /// Vuelve a mostrar una reseña y cierra el reporte
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<Response> showReviewWithHttpInfo(String id, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/central/resenas/{id}/mostrar'
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

  /// Vuelve a mostrar una reseña y cierra el reporte
  ///
  /// Parameters:
  ///
  /// * [String] id (required):
  Future<void> showReview(String id, { Future<void>? abortTrigger, }) async {
    final response = await showReviewWithHttpInfo(id, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }
}
