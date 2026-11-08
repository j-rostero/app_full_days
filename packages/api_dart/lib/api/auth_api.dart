//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


class AuthApi {
  AuthApi([ApiClient? apiClient]) : apiClient = apiClient ?? defaultApiClient;

  final ApiClient apiClient;

  /// Envía un código para elegir una contraseña nueva (responde igual exista o no la cuenta)
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RecoverInput] recoverInput (required):
  Future<Response> recoverPasswordWithHttpInfo(RecoverInput recoverInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/recuperar';

    // ignore: prefer_final_locals
    Object? postBody = recoverInput;

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

  /// Envía un código para elegir una contraseña nueva (responde igual exista o no la cuenta)
  ///
  /// Parameters:
  ///
  /// * [RecoverInput] recoverInput (required):
  Future<void> recoverPassword(RecoverInput recoverInput, { Future<void>? abortTrigger, }) async {
    final response = await recoverPasswordWithHttpInfo(recoverInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Crea la cuenta (sin confirmar) y envía un código al correo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RegisterInput] registerInput (required):
  Future<Response> registerWithHttpInfo(RegisterInput registerInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/registrar';

    // ignore: prefer_final_locals
    Object? postBody = registerInput;

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

  /// Crea la cuenta (sin confirmar) y envía un código al correo
  ///
  /// Parameters:
  ///
  /// * [RegisterInput] registerInput (required):
  Future<void> register(RegisterInput registerInput, { Future<void>? abortTrigger, }) async {
    final response = await registerWithHttpInfo(registerInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Cambia un token de renovación por un par nuevo
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [RenewInput] renewInput (required):
  Future<Response> renewSessionWithHttpInfo(RenewInput renewInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/renovar';

    // ignore: prefer_final_locals
    Object? postBody = renewInput;

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

  /// Cambia un token de renovación por un par nuevo
  ///
  /// Parameters:
  ///
  /// * [RenewInput] renewInput (required):
  Future<Tokens?> renewSession(RenewInput renewInput, { Future<void>? abortTrigger, }) async {
    final response = await renewSessionWithHttpInfo(renewInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'Tokens',) as Tokens;
    
    }
    return null;
  }

  /// Fija la contraseña nueva con el código, cierra las demás sesiones y abre una
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [ResetInput] resetInput (required):
  Future<Response> resetPasswordWithHttpInfo(ResetInput resetInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/restablecer';

    // ignore: prefer_final_locals
    Object? postBody = resetInput;

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

  /// Fija la contraseña nueva con el código, cierra las demás sesiones y abre una
  ///
  /// Parameters:
  ///
  /// * [ResetInput] resetInput (required):
  Future<SignedIn?> resetPassword(ResetInput resetInput, { Future<void>? abortTrigger, }) async {
    final response = await resetPasswordWithHttpInfo(resetInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SignedIn',) as SignedIn;
    
    }
    return null;
  }

  /// Entra con correo y contraseña
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [SignInInput] signInInput (required):
  Future<Response> signInWithHttpInfo(SignInInput signInInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/entrar';

    // ignore: prefer_final_locals
    Object? postBody = signInInput;

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

  /// Entra con correo y contraseña
  ///
  /// Parameters:
  ///
  /// * [SignInInput] signInInput (required):
  Future<SignedIn?> signIn(SignInInput signInInput, { Future<void>? abortTrigger, }) async {
    final response = await signInWithHttpInfo(signInInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SignedIn',) as SignedIn;
    
    }
    return null;
  }

  /// Entra con un token de Google; crea la cuenta la primera vez
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [GoogleInput] googleInput (required):
  Future<Response> signInWithGoogleWithHttpInfo(GoogleInput googleInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/google';

    // ignore: prefer_final_locals
    Object? postBody = googleInput;

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

  /// Entra con un token de Google; crea la cuenta la primera vez
  ///
  /// Parameters:
  ///
  /// * [GoogleInput] googleInput (required):
  Future<SignedIn?> signInWithGoogle(GoogleInput googleInput, { Future<void>? abortTrigger, }) async {
    final response = await signInWithGoogleWithHttpInfo(googleInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SignedIn',) as SignedIn;
    
    }
    return null;
  }

  /// Cierra la sesión de este dispositivo
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> signOutWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/salir';

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

  /// Cierra la sesión de este dispositivo
  Future<void> signOut({ Future<void>? abortTrigger, }) async {
    final response = await signOutWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Cierra las sesiones de todos los dispositivos de la persona
  ///
  /// Note: This method returns the HTTP [Response].
  Future<Response> signOutEverywhereWithHttpInfo({ Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/salir-de-todos';

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

  /// Cierra las sesiones de todos los dispositivos de la persona
  Future<void> signOutEverywhere({ Future<void>? abortTrigger, }) async {
    final response = await signOutEverywhereWithHttpInfo(abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
  }

  /// Confirma el correo con el código y abre sesión
  ///
  /// Note: This method returns the HTTP [Response].
  ///
  /// Parameters:
  ///
  /// * [VerifyInput] verifyInput (required):
  Future<Response> verifyEmailWithHttpInfo(VerifyInput verifyInput, { Future<void>? abortTrigger, }) async {
    // ignore: prefer_const_declarations
    final path = r'/v1/auth/verificar';

    // ignore: prefer_final_locals
    Object? postBody = verifyInput;

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

  /// Confirma el correo con el código y abre sesión
  ///
  /// Parameters:
  ///
  /// * [VerifyInput] verifyInput (required):
  Future<SignedIn?> verifyEmail(VerifyInput verifyInput, { Future<void>? abortTrigger, }) async {
    final response = await verifyEmailWithHttpInfo(verifyInput, abortTrigger: abortTrigger,);
    if (response.statusCode >= HttpStatus.badRequest) {
      throw ApiException(response.statusCode, await _decodeBodyBytes(response));
    }
    // When a remote server returns no body with a status of 204, we shall not decode it.
    // At the time of writing this, `dart:convert` will throw an "Unexpected end of input"
    // FormatException when trying to decode an empty string.
    if (response.body.isNotEmpty && response.statusCode != HttpStatus.noContent) {
      return await apiClient.deserializeAsync(await _decodeBodyBytes(response), 'SignedIn',) as SignedIn;
    
    }
    return null;
  }
}
