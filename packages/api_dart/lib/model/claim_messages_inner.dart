//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClaimMessagesInner {
  /// Returns a new [ClaimMessagesInner] instance.
  ClaimMessagesInner({
    required this.id,
    required this.role,
    required this.author,
    required this.body,
    required this.createdAt,
  });

  String id;

  ClaimMessagesInnerRoleEnum role;

  String? author;

  String body;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClaimMessagesInner &&
    other.id == id &&
    other.role == role &&
    other.author == author &&
    other.body == body &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (role.hashCode) +
    (author == null ? 0 : author!.hashCode) +
    (body.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'ClaimMessagesInner[id=$id, role=$role, author=$author, body=$body, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'role'] = this.role;
    if (this.author != null) {
      json[r'author'] = this.author;
    } else {
      json[r'author'] = null;
    }
      json[r'body'] = this.body;
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ClaimMessagesInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClaimMessagesInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ClaimMessagesInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ClaimMessagesInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'role'), 'Required key "ClaimMessagesInner[role]" is missing from JSON.');
        assert(json[r'role'] != null, 'Required key "ClaimMessagesInner[role]" has a null value in JSON.');
        assert(json.containsKey(r'author'), 'Required key "ClaimMessagesInner[author]" is missing from JSON.');
        assert(json.containsKey(r'body'), 'Required key "ClaimMessagesInner[body]" is missing from JSON.');
        assert(json[r'body'] != null, 'Required key "ClaimMessagesInner[body]" has a null value in JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "ClaimMessagesInner[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "ClaimMessagesInner[createdAt]" has a null value in JSON.');
        return true;
      }());

      return ClaimMessagesInner(
        id: mapValueOfType<String>(json, r'id')!,
        role: ClaimMessagesInnerRoleEnum.fromJson(json[r'role'])!,
        author: mapValueOfType<String>(json, r'author'),
        body: mapValueOfType<String>(json, r'body')!,
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<ClaimMessagesInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClaimMessagesInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClaimMessagesInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClaimMessagesInner> mapFromJson(dynamic json) {
    final map = <String, ClaimMessagesInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClaimMessagesInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClaimMessagesInner-objects as value to a dart map
  static Map<String, List<ClaimMessagesInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClaimMessagesInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClaimMessagesInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'role',
    'author',
    'body',
    'createdAt',
  };
}


enum ClaimMessagesInnerRoleEnum {
  traveler._(r'traveler'),
  agency._(r'agency'),
  central._(r'central'),
  ;

  /// Instantiate a new enum with the provided value.
  const ClaimMessagesInnerRoleEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ClaimMessagesInnerRoleEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ClaimMessagesInnerRoleEnum? fromJson(dynamic value) => ClaimMessagesInnerRoleEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ClaimMessagesInnerRoleEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ClaimMessagesInnerRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClaimMessagesInnerRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClaimMessagesInnerRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ClaimMessagesInnerRoleEnum] to String,
/// and [decode] dynamic data back to [ClaimMessagesInnerRoleEnum].
class ClaimMessagesInnerRoleEnumTypeTransformer {
  factory ClaimMessagesInnerRoleEnumTypeTransformer() => _instance ??= const ClaimMessagesInnerRoleEnumTypeTransformer._();

  const ClaimMessagesInnerRoleEnumTypeTransformer._();

  String encode(ClaimMessagesInnerRoleEnum data) => data._value;

  /// Returns the instance of [ClaimMessagesInnerRoleEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClaimMessagesInnerRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ClaimMessagesInnerRoleEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'traveler': return ClaimMessagesInnerRoleEnum.traveler;
        case r'agency': return ClaimMessagesInnerRoleEnum.agency;
        case r'central': return ClaimMessagesInnerRoleEnum.central;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ClaimMessagesInnerRoleEnumTypeTransformer? _instance;
}


