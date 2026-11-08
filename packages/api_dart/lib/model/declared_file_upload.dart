//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeclaredFileUpload {
  /// Returns a new [DeclaredFileUpload] instance.
  DeclaredFileUpload({
    required this.url,
    required this.method,
    this.headers = const {},
  });

  String url;

  DeclaredFileUploadMethodEnum method;

  Map<String, String> headers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeclaredFileUpload &&
    other.url == url &&
    other.method == method &&
    _deepEquality.equals(other.headers, headers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (url.hashCode) +
    (method.hashCode) +
    (headers.hashCode);

  @override
  String toString() => 'DeclaredFileUpload[url=$url, method=$method, headers=$headers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'url'] = this.url;
      json[r'method'] = this.method;
      json[r'headers'] = this.headers;
    return json;
  }

  /// Returns a new [DeclaredFileUpload] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeclaredFileUpload? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'url'), 'Required key "DeclaredFileUpload[url]" is missing from JSON.');
        assert(json[r'url'] != null, 'Required key "DeclaredFileUpload[url]" has a null value in JSON.');
        assert(json.containsKey(r'method'), 'Required key "DeclaredFileUpload[method]" is missing from JSON.');
        assert(json[r'method'] != null, 'Required key "DeclaredFileUpload[method]" has a null value in JSON.');
        assert(json.containsKey(r'headers'), 'Required key "DeclaredFileUpload[headers]" is missing from JSON.');
        assert(json[r'headers'] != null, 'Required key "DeclaredFileUpload[headers]" has a null value in JSON.');
        return true;
      }());

      return DeclaredFileUpload(
        url: mapValueOfType<String>(json, r'url')!,
        method: DeclaredFileUploadMethodEnum.fromJson(json[r'method'])!,
        headers: mapCastOfType<String, String>(json, r'headers')!,
      );
    }
    return null;
  }

  static List<DeclaredFileUpload> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeclaredFileUpload>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeclaredFileUpload.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeclaredFileUpload> mapFromJson(dynamic json) {
    final map = <String, DeclaredFileUpload>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeclaredFileUpload.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeclaredFileUpload-objects as value to a dart map
  static Map<String, List<DeclaredFileUpload>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeclaredFileUpload>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeclaredFileUpload.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'url',
    'method',
    'headers',
  };
}


enum DeclaredFileUploadMethodEnum {
  PUT._(r'PUT'),
  ;

  /// Instantiate a new enum with the provided value.
  const DeclaredFileUploadMethodEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DeclaredFileUploadMethodEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DeclaredFileUploadMethodEnum? fromJson(dynamic value) => DeclaredFileUploadMethodEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DeclaredFileUploadMethodEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DeclaredFileUploadMethodEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeclaredFileUploadMethodEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeclaredFileUploadMethodEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeclaredFileUploadMethodEnum] to String,
/// and [decode] dynamic data back to [DeclaredFileUploadMethodEnum].
class DeclaredFileUploadMethodEnumTypeTransformer {
  factory DeclaredFileUploadMethodEnumTypeTransformer() => _instance ??= const DeclaredFileUploadMethodEnumTypeTransformer._();

  const DeclaredFileUploadMethodEnumTypeTransformer._();

  String encode(DeclaredFileUploadMethodEnum data) => data._value;

  /// Returns the instance of [DeclaredFileUploadMethodEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeclaredFileUploadMethodEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DeclaredFileUploadMethodEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'PUT': return DeclaredFileUploadMethodEnum.PUT;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DeclaredFileUploadMethodEnumTypeTransformer? _instance;
}


