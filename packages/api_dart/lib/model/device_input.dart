//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeviceInput {
  /// Returns a new [DeviceInput] instance.
  DeviceInput({
    required this.token,
    required this.platform,
  });

  String token;

  DeviceInputPlatformEnum platform;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeviceInput &&
    other.token == token &&
    other.platform == platform;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (token.hashCode) +
    (platform.hashCode);

  @override
  String toString() => 'DeviceInput[token=$token, platform=$platform]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'token'] = this.token;
      json[r'platform'] = this.platform;
    return json;
  }

  /// Returns a new [DeviceInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeviceInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'token'), 'Required key "DeviceInput[token]" is missing from JSON.');
        assert(json[r'token'] != null, 'Required key "DeviceInput[token]" has a null value in JSON.');
        assert(json.containsKey(r'platform'), 'Required key "DeviceInput[platform]" is missing from JSON.');
        assert(json[r'platform'] != null, 'Required key "DeviceInput[platform]" has a null value in JSON.');
        return true;
      }());

      return DeviceInput(
        token: mapValueOfType<String>(json, r'token')!,
        platform: DeviceInputPlatformEnum.fromJson(json[r'platform'])!,
      );
    }
    return null;
  }

  static List<DeviceInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeviceInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeviceInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeviceInput> mapFromJson(dynamic json) {
    final map = <String, DeviceInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeviceInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeviceInput-objects as value to a dart map
  static Map<String, List<DeviceInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeviceInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeviceInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'token',
    'platform',
  };
}


enum DeviceInputPlatformEnum {
  android._(r'android'),
  ios._(r'ios'),
  ;

  /// Instantiate a new enum with the provided value.
  const DeviceInputPlatformEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DeviceInputPlatformEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DeviceInputPlatformEnum? fromJson(dynamic value) => DeviceInputPlatformEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DeviceInputPlatformEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DeviceInputPlatformEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeviceInputPlatformEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeviceInputPlatformEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeviceInputPlatformEnum] to String,
/// and [decode] dynamic data back to [DeviceInputPlatformEnum].
class DeviceInputPlatformEnumTypeTransformer {
  factory DeviceInputPlatformEnumTypeTransformer() => _instance ??= const DeviceInputPlatformEnumTypeTransformer._();

  const DeviceInputPlatformEnumTypeTransformer._();

  String encode(DeviceInputPlatformEnum data) => data._value;

  /// Returns the instance of [DeviceInputPlatformEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeviceInputPlatformEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DeviceInputPlatformEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'android': return DeviceInputPlatformEnum.android;
        case r'ios': return DeviceInputPlatformEnum.ios;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DeviceInputPlatformEnumTypeTransformer? _instance;
}


