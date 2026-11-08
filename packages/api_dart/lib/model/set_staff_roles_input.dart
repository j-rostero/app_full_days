//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SetStaffRolesInput {
  /// Returns a new [SetStaffRolesInput] instance.
  SetStaffRolesInput({
    required this.email,
    this.roles = const [],
  });

  String email;

  List<SetStaffRolesInputRolesEnum> roles;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SetStaffRolesInput &&
    other.email == email &&
    _deepEquality.equals(other.roles, roles);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (roles.hashCode);

  @override
  String toString() => 'SetStaffRolesInput[email=$email, roles=$roles]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'roles'] = this.roles;
    return json;
  }

  /// Returns a new [SetStaffRolesInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SetStaffRolesInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'email'), 'Required key "SetStaffRolesInput[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "SetStaffRolesInput[email]" has a null value in JSON.');
        assert(json.containsKey(r'roles'), 'Required key "SetStaffRolesInput[roles]" is missing from JSON.');
        assert(json[r'roles'] != null, 'Required key "SetStaffRolesInput[roles]" has a null value in JSON.');
        return true;
      }());

      return SetStaffRolesInput(
        email: mapValueOfType<String>(json, r'email')!,
        roles: SetStaffRolesInputRolesEnum.listFromJson(json[r'roles']),
      );
    }
    return null;
  }

  static List<SetStaffRolesInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetStaffRolesInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetStaffRolesInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SetStaffRolesInput> mapFromJson(dynamic json) {
    final map = <String, SetStaffRolesInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SetStaffRolesInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SetStaffRolesInput-objects as value to a dart map
  static Map<String, List<SetStaffRolesInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SetStaffRolesInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SetStaffRolesInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'roles',
  };
}


enum SetStaffRolesInputRolesEnum {
  super_._(r'super'),
  support._(r'support'),
  moderation._(r'moderation'),
  content._(r'content'),
  finance._(r'finance'),
  ;

  /// Instantiate a new enum with the provided value.
  const SetStaffRolesInputRolesEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SetStaffRolesInputRolesEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SetStaffRolesInputRolesEnum? fromJson(dynamic value) => SetStaffRolesInputRolesEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SetStaffRolesInputRolesEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SetStaffRolesInputRolesEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SetStaffRolesInputRolesEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SetStaffRolesInputRolesEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SetStaffRolesInputRolesEnum] to String,
/// and [decode] dynamic data back to [SetStaffRolesInputRolesEnum].
class SetStaffRolesInputRolesEnumTypeTransformer {
  factory SetStaffRolesInputRolesEnumTypeTransformer() => _instance ??= const SetStaffRolesInputRolesEnumTypeTransformer._();

  const SetStaffRolesInputRolesEnumTypeTransformer._();

  String encode(SetStaffRolesInputRolesEnum data) => data._value;

  /// Returns the instance of [SetStaffRolesInputRolesEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SetStaffRolesInputRolesEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SetStaffRolesInputRolesEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'super': return SetStaffRolesInputRolesEnum.super_;
        case r'support': return SetStaffRolesInputRolesEnum.support;
        case r'moderation': return SetStaffRolesInputRolesEnum.moderation;
        case r'content': return SetStaffRolesInputRolesEnum.content;
        case r'finance': return SetStaffRolesInputRolesEnum.finance;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SetStaffRolesInputRolesEnumTypeTransformer? _instance;
}


