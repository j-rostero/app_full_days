//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class HealthChecks {
  /// Returns a new [HealthChecks] instance.
  HealthChecks({
    required this.database,
    required this.redis,
  });

  HealthChecksDatabaseEnum database;

  HealthChecksRedisEnum redis;

  @override
  bool operator ==(Object other) => identical(this, other) || other is HealthChecks &&
    other.database == database &&
    other.redis == redis;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (database.hashCode) +
    (redis.hashCode);

  @override
  String toString() => 'HealthChecks[database=$database, redis=$redis]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'database'] = this.database;
      json[r'redis'] = this.redis;
    return json;
  }

  /// Returns a new [HealthChecks] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static HealthChecks? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'database'), 'Required key "HealthChecks[database]" is missing from JSON.');
        assert(json[r'database'] != null, 'Required key "HealthChecks[database]" has a null value in JSON.');
        assert(json.containsKey(r'redis'), 'Required key "HealthChecks[redis]" is missing from JSON.');
        assert(json[r'redis'] != null, 'Required key "HealthChecks[redis]" has a null value in JSON.');
        return true;
      }());

      return HealthChecks(
        database: HealthChecksDatabaseEnum.fromJson(json[r'database'])!,
        redis: HealthChecksRedisEnum.fromJson(json[r'redis'])!,
      );
    }
    return null;
  }

  static List<HealthChecks> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HealthChecks>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthChecks.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, HealthChecks> mapFromJson(dynamic json) {
    final map = <String, HealthChecks>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = HealthChecks.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of HealthChecks-objects as value to a dart map
  static Map<String, List<HealthChecks>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<HealthChecks>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = HealthChecks.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'database',
    'redis',
  };
}


enum HealthChecksDatabaseEnum {
  ok._(r'ok'),
  down._(r'down'),
  ;

  /// Instantiate a new enum with the provided value.
  const HealthChecksDatabaseEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [HealthChecksDatabaseEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static HealthChecksDatabaseEnum? fromJson(dynamic value) => HealthChecksDatabaseEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [HealthChecksDatabaseEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<HealthChecksDatabaseEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HealthChecksDatabaseEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthChecksDatabaseEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [HealthChecksDatabaseEnum] to String,
/// and [decode] dynamic data back to [HealthChecksDatabaseEnum].
class HealthChecksDatabaseEnumTypeTransformer {
  factory HealthChecksDatabaseEnumTypeTransformer() => _instance ??= const HealthChecksDatabaseEnumTypeTransformer._();

  const HealthChecksDatabaseEnumTypeTransformer._();

  String encode(HealthChecksDatabaseEnum data) => data._value;

  /// Returns the instance of [HealthChecksDatabaseEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  HealthChecksDatabaseEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is HealthChecksDatabaseEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ok': return HealthChecksDatabaseEnum.ok;
        case r'down': return HealthChecksDatabaseEnum.down;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static HealthChecksDatabaseEnumTypeTransformer? _instance;
}



enum HealthChecksRedisEnum {
  ok._(r'ok'),
  down._(r'down'),
  ;

  /// Instantiate a new enum with the provided value.
  const HealthChecksRedisEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [HealthChecksRedisEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static HealthChecksRedisEnum? fromJson(dynamic value) => HealthChecksRedisEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [HealthChecksRedisEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<HealthChecksRedisEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <HealthChecksRedisEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = HealthChecksRedisEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [HealthChecksRedisEnum] to String,
/// and [decode] dynamic data back to [HealthChecksRedisEnum].
class HealthChecksRedisEnumTypeTransformer {
  factory HealthChecksRedisEnumTypeTransformer() => _instance ??= const HealthChecksRedisEnumTypeTransformer._();

  const HealthChecksRedisEnumTypeTransformer._();

  String encode(HealthChecksRedisEnum data) => data._value;

  /// Returns the instance of [HealthChecksRedisEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  HealthChecksRedisEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is HealthChecksRedisEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'ok': return HealthChecksRedisEnum.ok;
        case r'down': return HealthChecksRedisEnum.down;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static HealthChecksRedisEnumTypeTransformer? _instance;
}


