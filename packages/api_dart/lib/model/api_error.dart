//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ApiError {
  /// Returns a new [ApiError] instance.
  ApiError({
    required this.statusCode,
    required this.code,
    required this.message,
    this.issues = const [],
  });

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int statusCode;

  ApiErrorCodeEnum code;

  String message;

  List<ApiErrorIssuesInner> issues;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ApiError &&
    other.statusCode == statusCode &&
    other.code == code &&
    other.message == message &&
    _deepEquality.equals(other.issues, issues);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (statusCode.hashCode) +
    (code.hashCode) +
    (message.hashCode) +
    (issues.hashCode);

  @override
  String toString() => 'ApiError[statusCode=$statusCode, code=$code, message=$message, issues=$issues]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'statusCode'] = this.statusCode;
      json[r'code'] = this.code;
      json[r'message'] = this.message;
      json[r'issues'] = this.issues;
    return json;
  }

  /// Returns a new [ApiError] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ApiError? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'statusCode'), 'Required key "ApiError[statusCode]" is missing from JSON.');
        assert(json[r'statusCode'] != null, 'Required key "ApiError[statusCode]" has a null value in JSON.');
        assert(json.containsKey(r'code'), 'Required key "ApiError[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "ApiError[code]" has a null value in JSON.');
        assert(json.containsKey(r'message'), 'Required key "ApiError[message]" is missing from JSON.');
        assert(json[r'message'] != null, 'Required key "ApiError[message]" has a null value in JSON.');
        return true;
      }());

      return ApiError(
        statusCode: mapValueOfType<int>(json, r'statusCode')!,
        code: ApiErrorCodeEnum.fromJson(json[r'code'])!,
        message: mapValueOfType<String>(json, r'message')!,
        issues: ApiErrorIssuesInner.listFromJson(json[r'issues']),
      );
    }
    return null;
  }

  static List<ApiError> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiError>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiError.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ApiError> mapFromJson(dynamic json) {
    final map = <String, ApiError>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ApiError.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ApiError-objects as value to a dart map
  static Map<String, List<ApiError>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ApiError>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ApiError.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'statusCode',
    'code',
    'message',
  };
}


enum ApiErrorCodeEnum {
  badRequest._(r'bad_request'),
  validationFailed._(r'validation_failed'),
  unauthorized._(r'unauthorized'),
  forbidden._(r'forbidden'),
  notFound._(r'not_found'),
  conflict._(r'conflict'),
  tooManyRequests._(r'too_many_requests'),
  internalError._(r'internal_error'),
  ;

  /// Instantiate a new enum with the provided value.
  const ApiErrorCodeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ApiErrorCodeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ApiErrorCodeEnum? fromJson(dynamic value) => ApiErrorCodeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ApiErrorCodeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ApiErrorCodeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ApiErrorCodeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ApiErrorCodeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ApiErrorCodeEnum] to String,
/// and [decode] dynamic data back to [ApiErrorCodeEnum].
class ApiErrorCodeEnumTypeTransformer {
  factory ApiErrorCodeEnumTypeTransformer() => _instance ??= const ApiErrorCodeEnumTypeTransformer._();

  const ApiErrorCodeEnumTypeTransformer._();

  String encode(ApiErrorCodeEnum data) => data._value;

  /// Returns the instance of [ApiErrorCodeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ApiErrorCodeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ApiErrorCodeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'bad_request': return ApiErrorCodeEnum.badRequest;
        case r'validation_failed': return ApiErrorCodeEnum.validationFailed;
        case r'unauthorized': return ApiErrorCodeEnum.unauthorized;
        case r'forbidden': return ApiErrorCodeEnum.forbidden;
        case r'not_found': return ApiErrorCodeEnum.notFound;
        case r'conflict': return ApiErrorCodeEnum.conflict;
        case r'too_many_requests': return ApiErrorCodeEnum.tooManyRequests;
        case r'internal_error': return ApiErrorCodeEnum.internalError;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ApiErrorCodeEnumTypeTransformer? _instance;
}


