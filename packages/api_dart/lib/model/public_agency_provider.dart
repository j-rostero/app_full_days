//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicAgencyProvider {
  /// Returns a new [PublicAgencyProvider] instance.
  PublicAgencyProvider({
    required this.id,
    required this.name,
    required this.badge,
    required this.baseCity,
    required this.instagram,
  });

  String id;

  String name;

  PublicAgencyProviderBadgeEnum? badge;

  String baseCity;

  String? instagram;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicAgencyProvider &&
    other.id == id &&
    other.name == name &&
    other.badge == badge &&
    other.baseCity == baseCity &&
    other.instagram == instagram;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (badge == null ? 0 : badge!.hashCode) +
    (baseCity.hashCode) +
    (instagram == null ? 0 : instagram!.hashCode);

  @override
  String toString() => 'PublicAgencyProvider[id=$id, name=$name, badge=$badge, baseCity=$baseCity, instagram=$instagram]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    if (this.badge != null) {
      json[r'badge'] = this.badge;
    } else {
      json[r'badge'] = null;
    }
      json[r'baseCity'] = this.baseCity;
    if (this.instagram != null) {
      json[r'instagram'] = this.instagram;
    } else {
      json[r'instagram'] = null;
    }
    return json;
  }

  /// Returns a new [PublicAgencyProvider] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicAgencyProvider? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "PublicAgencyProvider[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "PublicAgencyProvider[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "PublicAgencyProvider[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "PublicAgencyProvider[name]" has a null value in JSON.');
        assert(json.containsKey(r'badge'), 'Required key "PublicAgencyProvider[badge]" is missing from JSON.');
        assert(json.containsKey(r'baseCity'), 'Required key "PublicAgencyProvider[baseCity]" is missing from JSON.');
        assert(json[r'baseCity'] != null, 'Required key "PublicAgencyProvider[baseCity]" has a null value in JSON.');
        assert(json.containsKey(r'instagram'), 'Required key "PublicAgencyProvider[instagram]" is missing from JSON.');
        return true;
      }());

      return PublicAgencyProvider(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        badge: PublicAgencyProviderBadgeEnum.fromJson(json[r'badge']),
        baseCity: mapValueOfType<String>(json, r'baseCity')!,
        instagram: mapValueOfType<String>(json, r'instagram'),
      );
    }
    return null;
  }

  static List<PublicAgencyProvider> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicAgencyProvider>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicAgencyProvider.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicAgencyProvider> mapFromJson(dynamic json) {
    final map = <String, PublicAgencyProvider>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicAgencyProvider.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicAgencyProvider-objects as value to a dart map
  static Map<String, List<PublicAgencyProvider>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicAgencyProvider>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicAgencyProvider.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'badge',
    'baseCity',
    'instagram',
  };
}


enum PublicAgencyProviderBadgeEnum {
  verified._(r'verified'),
  new_._(r'new'),
  ;

  /// Instantiate a new enum with the provided value.
  const PublicAgencyProviderBadgeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [PublicAgencyProviderBadgeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static PublicAgencyProviderBadgeEnum? fromJson(dynamic value) => PublicAgencyProviderBadgeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [PublicAgencyProviderBadgeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<PublicAgencyProviderBadgeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicAgencyProviderBadgeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicAgencyProviderBadgeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PublicAgencyProviderBadgeEnum] to String,
/// and [decode] dynamic data back to [PublicAgencyProviderBadgeEnum].
class PublicAgencyProviderBadgeEnumTypeTransformer {
  factory PublicAgencyProviderBadgeEnumTypeTransformer() => _instance ??= const PublicAgencyProviderBadgeEnumTypeTransformer._();

  const PublicAgencyProviderBadgeEnumTypeTransformer._();

  String encode(PublicAgencyProviderBadgeEnum data) => data._value;

  /// Returns the instance of [PublicAgencyProviderBadgeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PublicAgencyProviderBadgeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is PublicAgencyProviderBadgeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'verified': return PublicAgencyProviderBadgeEnum.verified;
        case r'new': return PublicAgencyProviderBadgeEnum.new_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static PublicAgencyProviderBadgeEnumTypeTransformer? _instance;
}


