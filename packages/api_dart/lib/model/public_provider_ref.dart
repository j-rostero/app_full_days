//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProviderRef {
  /// Returns a new [PublicProviderRef] instance.
  PublicProviderRef({
    required this.id,
    required this.name,
    required this.badge,
    required this.baseCity,
  });

  String id;

  String name;

  PublicProviderRefBadgeEnum? badge;

  String baseCity;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProviderRef &&
    other.id == id &&
    other.name == name &&
    other.badge == badge &&
    other.baseCity == baseCity;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (badge == null ? 0 : badge!.hashCode) +
    (baseCity.hashCode);

  @override
  String toString() => 'PublicProviderRef[id=$id, name=$name, badge=$badge, baseCity=$baseCity]';

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
    return json;
  }

  /// Returns a new [PublicProviderRef] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProviderRef? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "PublicProviderRef[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "PublicProviderRef[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "PublicProviderRef[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "PublicProviderRef[name]" has a null value in JSON.');
        assert(json.containsKey(r'badge'), 'Required key "PublicProviderRef[badge]" is missing from JSON.');
        assert(json.containsKey(r'baseCity'), 'Required key "PublicProviderRef[baseCity]" is missing from JSON.');
        assert(json[r'baseCity'] != null, 'Required key "PublicProviderRef[baseCity]" has a null value in JSON.');
        return true;
      }());

      return PublicProviderRef(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        badge: PublicProviderRefBadgeEnum.fromJson(json[r'badge']),
        baseCity: mapValueOfType<String>(json, r'baseCity')!,
      );
    }
    return null;
  }

  static List<PublicProviderRef> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProviderRef>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProviderRef.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProviderRef> mapFromJson(dynamic json) {
    final map = <String, PublicProviderRef>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProviderRef.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProviderRef-objects as value to a dart map
  static Map<String, List<PublicProviderRef>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProviderRef>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProviderRef.listFromJson(entry.value, growable: growable,);
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
  };
}


enum PublicProviderRefBadgeEnum {
  verified._(r'verified'),
  new_._(r'new'),
  ;

  /// Instantiate a new enum with the provided value.
  const PublicProviderRefBadgeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [PublicProviderRefBadgeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static PublicProviderRefBadgeEnum? fromJson(dynamic value) => PublicProviderRefBadgeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [PublicProviderRefBadgeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<PublicProviderRefBadgeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProviderRefBadgeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProviderRefBadgeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [PublicProviderRefBadgeEnum] to String,
/// and [decode] dynamic data back to [PublicProviderRefBadgeEnum].
class PublicProviderRefBadgeEnumTypeTransformer {
  factory PublicProviderRefBadgeEnumTypeTransformer() => _instance ??= const PublicProviderRefBadgeEnumTypeTransformer._();

  const PublicProviderRefBadgeEnumTypeTransformer._();

  String encode(PublicProviderRefBadgeEnum data) => data._value;

  /// Returns the instance of [PublicProviderRefBadgeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  PublicProviderRefBadgeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is PublicProviderRefBadgeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'verified': return PublicProviderRefBadgeEnum.verified;
        case r'new': return PublicProviderRefBadgeEnum.new_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static PublicProviderRefBadgeEnumTypeTransformer? _instance;
}


