//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiClient {
  ApiClient({this.basePath = 'http://localhost', this.authentication,});

  final String basePath;
  final Authentication? authentication;

  var _client = Client();
  final _defaultHeaderMap = <String, String>{};

  /// Returns the current HTTP [Client] instance to use in this class.
  ///
  /// The return value is guaranteed to never be null.
  Client get client => _client;

  /// Requests to use a new HTTP [Client] in this class.
  set client(Client newClient) {
    _client = newClient;
  }

  Map<String, String> get defaultHeaderMap => _defaultHeaderMap;

  void addDefaultHeader(String key, String value) {
     _defaultHeaderMap[key] = value;
  }

  // We don't use a Map<String, String> for queryParams.
  // If collectionFormat is 'multi', a key might appear multiple times.
  Future<Response> invokeAPI(
    String path,
    String method,
    List<QueryParam> queryParams,
    Object? body,
    Map<String, String> headerParams,
    Map<String, String> formParams,
    String? contentType, {
    Future<void>? abortTrigger,
  }) async {
    await authentication?.applyToParams(queryParams, headerParams);

    headerParams.addAll(_defaultHeaderMap);
    if (contentType != null) {
      headerParams['Content-Type'] = contentType;
    }

    final urlEncodedQueryParams = queryParams.map((param) => '$param');
    final queryString = urlEncodedQueryParams.isNotEmpty ? '?${urlEncodedQueryParams.join('&')}' : '';
    final uri = Uri.parse('$basePath$path$queryString');

    try {
      // Special case for uploading a single file which isn't a 'multipart/form-data'.
      if (
        body is MultipartFile && (contentType == null ||
        !contentType.toLowerCase().startsWith('multipart/form-data'))
      ) {
        final request = AbortableStreamedRequest(method, uri, abortTrigger: abortTrigger);
        request.headers.addAll(headerParams);
        request.contentLength = body.length;
        body.finalize().listen(
          request.sink.add,
          onDone: request.sink.close,
          // ignore: avoid_types_on_closure_parameters
          onError: (Object error, StackTrace trace) => request.sink.close(),
          cancelOnError: true,
        );
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      if (body is MultipartRequest) {
        final request = AbortableMultipartRequest(method, uri, abortTrigger: abortTrigger);
        request.fields.addAll(body.fields);
        request.files.addAll(body.files);
        request.headers.addAll(body.headers);
        request.headers.addAll(headerParams);
        final response = await _client.send(request);
        return Response.fromStream(response);
      }

      final msgBody = contentType == 'application/x-www-form-urlencoded'
        ? formParams
        : await serializeAsync(body);
      final nullableHeaderParams = headerParams.isEmpty ? null : headerParams;

      final request = AbortableRequest(method, uri, abortTrigger: abortTrigger);
      if (nullableHeaderParams != null) {
        request.headers.addAll(nullableHeaderParams);
      }
      if (msgBody is String && msgBody.isNotEmpty) {
        request.body = msgBody;
      } else if (msgBody is List<int> && msgBody.isNotEmpty) {
        request.bodyBytes = msgBody;
      } else if (msgBody is Map<String, String>) {
        request.bodyFields = msgBody;
      }
      final response = await _client.send(request);
      return Response.fromStream(response);
    } on SocketException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Socket operation failed: $method $path',
        error,
        trace,
      );
    } on TlsException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'TLS/SSL communication failed: $method $path',
        error,
        trace,
      );
    } on IOException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'I/O operation failed: $method $path',
        error,
        trace,
      );
    } on ClientException catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'HTTP connection failed: $method $path',
        error,
        trace,
      );
    } on Exception catch (error, trace) {
      throw ApiException.withInner(
        HttpStatus.badRequest,
        'Exception occurred: $method $path',
        error,
        trace,
      );
    }
  }

  Future<dynamic> deserializeAsync(String value, String targetType, {bool growable = false,}) async =>
    // ignore: deprecated_member_use_from_same_package
    deserialize(value, targetType, growable: growable);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use deserializeAsync() instead.')
  dynamic deserialize(String value, String targetType, {bool growable = false,}) {
    // Remove all spaces. Necessary for regular expressions as well.
    targetType = targetType.replaceAll(' ', ''); // ignore: parameter_assignments

    // If the expected target type is String, nothing to do...
    return targetType == 'String'
      ? value
      : fromJson(json.decode(value), targetType, growable: growable);
  }

  // ignore: deprecated_member_use_from_same_package
  Future<String> serializeAsync(Object? value) async => serialize(value);

  @Deprecated('Scheduled for removal in OpenAPI Generator 6.x. Use serializeAsync() instead.')
  String serialize(Object? value) => value == null ? '' : json.encode(value);

  /// Returns a native instance of an OpenAPI class matching the [specified type][targetType].
  static dynamic fromJson(dynamic value, String targetType, {bool growable = false,}) {
    try {
      switch (targetType) {
        case 'String':
          return value is String ? value : value.toString();
        case 'int':
          return value is int ? value : int.parse('$value');
        case 'double':
          return value is double ? value : double.parse('$value');
        case 'bool':
          if (value is bool) {
            return value;
          }
          final valueString = '$value'.toLowerCase();
          return valueString == 'true' || valueString == '1';
        case 'DateTime':
          return value is DateTime ? value : DateTime.tryParse(value);
        case 'Account':
          return Account.fromJson(value);
        case 'AddTeamMemberInput':
          return AddTeamMemberInput.fromJson(value);
        case 'ApiError':
          return ApiError.fromJson(value);
        case 'ApiErrorIssuesInner':
          return ApiErrorIssuesInner.fromJson(value);
        case 'AttachDocumentInput':
          return AttachDocumentInput.fromJson(value);
        case 'AuditEntry':
          return AuditEntry.fromJson(value);
        case 'AuditEntryActor':
          return AuditEntryActor.fromJson(value);
        case 'AuditPage':
          return AuditPage.fromJson(value);
        case 'Availability':
          return Availability.fromJson(value);
        case 'AvailabilityDeparture':
          return AvailabilityDeparture.fromJson(value);
        case 'BoardingPoint':
          return BoardingPoint.fromJson(value);
        case 'BoardingPointInput':
          return BoardingPointInput.fromJson(value);
        case 'BoardingPointList':
          return BoardingPointList.fromJson(value);
        case 'BoardingPointUpdateInput':
          return BoardingPointUpdateInput.fromJson(value);
        case 'Booking':
          return Booking.fromJson(value);
        case 'BookingContact':
          return BookingContact.fromJson(value);
        case 'BookingDeparture':
          return BookingDeparture.fromJson(value);
        case 'BookingLinesInner':
          return BookingLinesInner.fromJson(value);
        case 'BookingList':
          return BookingList.fromJson(value);
        case 'BookingPassenger':
          return BookingPassenger.fromJson(value);
        case 'BookingProduct':
          return BookingProduct.fromJson(value);
        case 'BookingProvider':
          return BookingProvider.fromJson(value);
        case 'BookingSelection':
          return BookingSelection.fromJson(value);
        case 'BookingSelectionRoomsInner':
          return BookingSelectionRoomsInner.fromJson(value);
        case 'BookingSelectionTravelers':
          return BookingSelectionTravelers.fromJson(value);
        case 'BookingStatus':
          return BookingStatusTypeTransformer().decode(value);
        case 'ChangeTeamRoleInput':
          return ChangeTeamRoleInput.fromJson(value);
        case 'CheckinSyncInput':
          return CheckinSyncInput.fromJson(value);
        case 'CheckinSyncInputEventsInner':
          return CheckinSyncInputEventsInner.fromJson(value);
        case 'CommissionInput':
          return CommissionInput.fromJson(value);
        case 'Company':
          return Company.fromJson(value);
        case 'Completeness':
          return Completeness.fromJson(value);
        case 'CompletenessBlocksInner':
          return CompletenessBlocksInner.fromJson(value);
        case 'CreateProductInput':
          return CreateProductInput.fromJson(value);
        case 'CurationInput':
          return CurationInput.fromJson(value);
        case 'DeclareFileInput':
          return DeclareFileInput.fromJson(value);
        case 'DeclaredFile':
          return DeclaredFile.fromJson(value);
        case 'DeclaredFileUpload':
          return DeclaredFileUpload.fromJson(value);
        case 'Departure':
          return Departure.fromJson(value);
        case 'DepartureCard':
          return DepartureCard.fromJson(value);
        case 'DepartureDate':
          return DepartureDate.fromJson(value);
        case 'DepartureList':
          return DepartureList.fromJson(value);
        case 'DepartureStatus':
          return DepartureStatusTypeTransformer().decode(value);
        case 'DepartureUpdateInput':
          return DepartureUpdateInput.fromJson(value);
        case 'Destination':
          return Destination.fromJson(value);
        case 'DestinationFee':
          return DestinationFee.fromJson(value);
        case 'DestinationFeeInput':
          return DestinationFeeInput.fromJson(value);
        case 'DestinationInput':
          return DestinationInput.fromJson(value);
        case 'DestinationList':
          return DestinationList.fromJson(value);
        case 'DestinationUpdateInput':
          return DestinationUpdateInput.fromJson(value);
        case 'FavoriteList':
          return FavoriteList.fromJson(value);
        case 'File':
          return File.fromJson(value);
        case 'GoogleInput':
          return GoogleInput.fromJson(value);
        case 'Health':
          return Health.fromJson(value);
        case 'HealthChecks':
          return HealthChecks.fromJson(value);
        case 'HoldInput':
          return HoldInput.fromJson(value);
        case 'ImageUrls':
          return ImageUrls.fromJson(value);
        case 'Manifest':
          return Manifest.fromJson(value);
        case 'ManifestDeparture':
          return ManifestDeparture.fromJson(value);
        case 'ManifestDiscardedInner':
          return ManifestDiscardedInner.fromJson(value);
        case 'ManifestPassenger':
          return ManifestPassenger.fromJson(value);
        case 'ManualBookingInput':
          return ManualBookingInput.fromJson(value);
        case 'ManualBookingInputContact':
          return ManualBookingInputContact.fromJson(value);
        case 'ManualBookingInputPayment':
          return ManualBookingInputPayment.fromJson(value);
        case 'Me':
          return Me.fromJson(value);
        case 'MeStaff':
          return MeStaff.fromJson(value);
        case 'MealChoice':
          return MealChoice.fromJson(value);
        case 'MealChoiceOptionsInner':
          return MealChoiceOptionsInner.fromJson(value);
        case 'Membership':
          return Membership.fromJson(value);
        case 'Notice':
          return Notice.fromJson(value);
        case 'NoticeInput':
          return NoticeInput.fromJson(value);
        case 'NoticeList':
          return NoticeList.fromJson(value);
        case 'Passenger':
          return Passenger.fromJson(value);
        case 'PassengerInput':
          return PassengerInput.fromJson(value);
        case 'PassengerList':
          return PassengerList.fromJson(value);
        case 'PassengersInput':
          return PassengersInput.fromJson(value);
        case 'PassengersInputPassengersInner':
          return PassengersInputPassengersInner.fromJson(value);
        case 'Payment':
          return Payment.fromJson(value);
        case 'PaymentList':
          return PaymentList.fromJson(value);
        case 'PaymentMethod':
          return PaymentMethodTypeTransformer().decode(value);
        case 'PaymentStatus':
          return PaymentStatusTypeTransformer().decode(value);
        case 'Photo':
          return Photo.fromJson(value);
        case 'ProductDetail':
          return ProductDetail.fromJson(value);
        case 'ProductList':
          return ProductList.fromJson(value);
        case 'ProductQueue':
          return ProductQueue.fromJson(value);
        case 'ProductQueueItem':
          return ProductQueueItem.fromJson(value);
        case 'ProductReview':
          return ProductReview.fromJson(value);
        case 'ProductSheet':
          return ProductSheet.fromJson(value);
        case 'ProductSheetDuration':
          return ProductSheetDuration.fromJson(value);
        case 'ProductSheetGeneral':
          return ProductSheetGeneral.fromJson(value);
        case 'ProductSheetItemsInner':
          return ProductSheetItemsInner.fromJson(value);
        case 'ProductSheetItineraryInner':
          return ProductSheetItineraryInner.fromJson(value);
        case 'ProductSheetLodging':
          return ProductSheetLodging.fromJson(value);
        case 'ProductSheetLodgingRoomsInner':
          return ProductSheetLodgingRoomsInner.fromJson(value);
        case 'ProductSheetMealsInner':
          return ProductSheetMealsInner.fromJson(value);
        case 'ProductSheetMealsInnerOptionsInner':
          return ProductSheetMealsInnerOptionsInner.fromJson(value);
        case 'ProductSheetPricing':
          return ProductSheetPricing.fromJson(value);
        case 'ProductSheetPricingCancellation':
          return ProductSheetPricingCancellation.fromJson(value);
        case 'ProductSheetPricingDeposit':
          return ProductSheetPricingDeposit.fromJson(value);
        case 'ProductSheetPricingFares':
          return ProductSheetPricingFares.fromJson(value);
        case 'ProductSheetTransfer':
          return ProductSheetTransfer.fromJson(value);
        case 'ProductSheetTransferBoardingPointsInner':
          return ProductSheetTransferBoardingPointsInner.fromJson(value);
        case 'ProductStatus':
          return ProductStatusTypeTransformer().decode(value);
        case 'ProductSummary':
          return ProductSummary.fromJson(value);
        case 'ProductType':
          return ProductTypeTypeTransformer().decode(value);
        case 'Production':
          return Production.fromJson(value);
        case 'ProductionDeparture':
          return ProductionDeparture.fromJson(value);
        case 'ProductionItemsInner':
          return ProductionItemsInner.fromJson(value);
        case 'ProductionMealsInner':
          return ProductionMealsInner.fromJson(value);
        case 'ProductionMealsInnerOptionsInner':
          return ProductionMealsInnerOptionsInner.fromJson(value);
        case 'ProductionPassengersInner':
          return ProductionPassengersInner.fromJson(value);
        case 'ProductionRestrictionsInner':
          return ProductionRestrictionsInner.fromJson(value);
        case 'ProductionRoomsInner':
          return ProductionRoomsInner.fromJson(value);
        case 'ProfileUpdateInput':
          return ProfileUpdateInput.fromJson(value);
        case 'ProviderDocument':
          return ProviderDocument.fromJson(value);
        case 'ProviderDocumentList':
          return ProviderDocumentList.fromJson(value);
        case 'ProviderDocumentType':
          return ProviderDocumentTypeTypeTransformer().decode(value);
        case 'ProviderInput':
          return ProviderInput.fromJson(value);
        case 'ProviderPermission':
          return ProviderPermissionTypeTransformer().decode(value);
        case 'ProviderQueue':
          return ProviderQueue.fromJson(value);
        case 'ProviderQueueItem':
          return ProviderQueueItem.fromJson(value);
        case 'ProviderReview':
          return ProviderReview.fromJson(value);
        case 'ProviderRole':
          return ProviderRoleTypeTransformer().decode(value);
        case 'ProviderStatus':
          return ProviderStatusTypeTransformer().decode(value);
        case 'ProviderUpdateInput':
          return ProviderUpdateInput.fromJson(value);
        case 'PublicAgency':
          return PublicAgency.fromJson(value);
        case 'PublicAgencyProvider':
          return PublicAgencyProvider.fromJson(value);
        case 'PublicProduct':
          return PublicProduct.fromJson(value);
        case 'PublicProductCard':
          return PublicProductCard.fromJson(value);
        case 'PublicProductCashAtDestination':
          return PublicProductCashAtDestination.fromJson(value);
        case 'PublicProductDestination':
          return PublicProductDestination.fromJson(value);
        case 'PublicProductInclusions':
          return PublicProductInclusions.fromJson(value);
        case 'PublicProductThemesInner':
          return PublicProductThemesInner.fromJson(value);
        case 'PublicProviderRef':
          return PublicProviderRef.fromJson(value);
        case 'Quote':
          return Quote.fromJson(value);
        case 'QuoteInput':
          return QuoteInput.fromJson(value);
        case 'Rate':
          return Rate.fromJson(value);
        case 'RateInput':
          return RateInput.fromJson(value);
        case 'RateList':
          return RateList.fromJson(value);
        case 'ReasonInput':
          return ReasonInput.fromJson(value);
        case 'RecoverInput':
          return RecoverInput.fromJson(value);
        case 'RegisterInput':
          return RegisterInput.fromJson(value);
        case 'RejectPaymentInput':
          return RejectPaymentInput.fromJson(value);
        case 'RenewInput':
          return RenewInput.fromJson(value);
        case 'ReportPaymentInput':
          return ReportPaymentInput.fromJson(value);
        case 'ResetInput':
          return ResetInput.fromJson(value);
        case 'SaveProductInput':
          return SaveProductInput.fromJson(value);
        case 'ScheduleDeparturesInput':
          return ScheduleDeparturesInput.fromJson(value);
        case 'SearchResult':
          return SearchResult.fromJson(value);
        case 'SetStaffRolesInput':
          return SetStaffRolesInput.fromJson(value);
        case 'Settings':
          return Settings.fromJson(value);
        case 'SettingsInput':
          return SettingsInput.fromJson(value);
        case 'SignInInput':
          return SignInInput.fromJson(value);
        case 'SignedIn':
          return SignedIn.fromJson(value);
        case 'Site':
          return Site.fromJson(value);
        case 'StaffList':
          return StaffList.fromJson(value);
        case 'StaffPermission':
          return StaffPermissionTypeTransformer().decode(value);
        case 'StaffPerson':
          return StaffPerson.fromJson(value);
        case 'StaffRole':
          return StaffRoleTypeTransformer().decode(value);
        case 'TeamList':
          return TeamList.fromJson(value);
        case 'TeamMember':
          return TeamMember.fromJson(value);
        case 'ThemeInput':
          return ThemeInput.fromJson(value);
        case 'ThemeList':
          return ThemeList.fromJson(value);
        case 'ThemeUpdateInput':
          return ThemeUpdateInput.fromJson(value);
        case 'TodayDeparture':
          return TodayDeparture.fromJson(value);
        case 'TodayList':
          return TodayList.fromJson(value);
        case 'Tokens':
          return Tokens.fromJson(value);
        case 'TravelTheme':
          return TravelTheme.fromJson(value);
        case 'VerifyInput':
          return VerifyInput.fromJson(value);
        case 'Voucher':
          return Voucher.fromJson(value);
        case 'VoucherKey':
          return VoucherKey.fromJson(value);
        case 'VoucherKeys':
          return VoucherKeys.fromJson(value);
        case 'VoucherList':
          return VoucherList.fromJson(value);
        default:
          dynamic match;
          if (value is List && (match = _regList.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toList(growable: growable);
          }
          if (value is Set && (match = _regSet.firstMatch(targetType)?.group(1)) != null) {
            return value
              .map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,))
              .toSet();
          }
          if (value is Map && (match = _regMap.firstMatch(targetType)?.group(1)) != null) {
            return Map<String, dynamic>.fromIterables(
              value.keys.cast<String>(),
              value.values.map<dynamic>((dynamic v) => fromJson(v, match, growable: growable,)),
            );
          }
      }
    } on Exception catch (error, trace) {
      throw ApiException.withInner(HttpStatus.internalServerError, 'Exception during deserialization.', error, trace,);
    }
    throw ApiException(HttpStatus.internalServerError, 'Could not find a suitable class for deserialization',);
  }
}

/// Primarily intended for use in an isolate.
class DeserializationMessage {
  const DeserializationMessage({
    required this.json,
    required this.targetType,
    this.growable = false,
  });

  /// The JSON value to deserialize.
  final String json;

  /// Target type to deserialize to.
  final String targetType;

  /// Whether to make deserialized lists or maps growable.
  final bool growable;
}

/// Primarily intended for use in an isolate.
Future<dynamic> decodeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : json.decode(message.json);
}

/// Primarily intended for use in an isolate.
Future<dynamic> deserializeAsync(DeserializationMessage message) async {
  // Remove all spaces. Necessary for regular expressions as well.
  final targetType = message.targetType.replaceAll(' ', '');

  // If the expected target type is String, nothing to do...
  return targetType == 'String'
    ? message.json
    : ApiClient.fromJson(
        json.decode(message.json),
        targetType,
        growable: message.growable,
      );
}

/// Primarily intended for use in an isolate.
Future<String> serializeAsync(Object? value) async => value == null ? '' : json.encode(value);
