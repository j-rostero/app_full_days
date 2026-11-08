//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AddTeamMemberInput {
  /// Returns a new [AddTeamMemberInput] instance.
  AddTeamMemberInput({
    required this.email,
    required this.role,
  });

  String email;

  AddTeamMemberInputRoleEnum role;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AddTeamMemberInput &&
    other.email == email &&
    other.role == role;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (role.hashCode);

  @override
  String toString() => 'AddTeamMemberInput[email=$email, role=$role]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'role'] = this.role;
    return json;
  }

  /// Returns a new [AddTeamMemberInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AddTeamMemberInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'email'), 'Required key "AddTeamMemberInput[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "AddTeamMemberInput[email]" has a null value in JSON.');
        assert(json.containsKey(r'role'), 'Required key "AddTeamMemberInput[role]" is missing from JSON.');
        assert(json[r'role'] != null, 'Required key "AddTeamMemberInput[role]" has a null value in JSON.');
        return true;
      }());

      return AddTeamMemberInput(
        email: mapValueOfType<String>(json, r'email')!,
        role: AddTeamMemberInputRoleEnum.fromJson(json[r'role'])!,
      );
    }
    return null;
  }

  static List<AddTeamMemberInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddTeamMemberInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddTeamMemberInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AddTeamMemberInput> mapFromJson(dynamic json) {
    final map = <String, AddTeamMemberInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AddTeamMemberInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AddTeamMemberInput-objects as value to a dart map
  static Map<String, List<AddTeamMemberInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AddTeamMemberInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AddTeamMemberInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'role',
  };
}


enum AddTeamMemberInputRoleEnum {
  owner._(r'owner'),
  operations._(r'operations'),
  finance._(r'finance'),
  guide._(r'guide'),
  ;

  /// Instantiate a new enum with the provided value.
  const AddTeamMemberInputRoleEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AddTeamMemberInputRoleEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AddTeamMemberInputRoleEnum? fromJson(dynamic value) => AddTeamMemberInputRoleEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AddTeamMemberInputRoleEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AddTeamMemberInputRoleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AddTeamMemberInputRoleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AddTeamMemberInputRoleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AddTeamMemberInputRoleEnum] to String,
/// and [decode] dynamic data back to [AddTeamMemberInputRoleEnum].
class AddTeamMemberInputRoleEnumTypeTransformer {
  factory AddTeamMemberInputRoleEnumTypeTransformer() => _instance ??= const AddTeamMemberInputRoleEnumTypeTransformer._();

  const AddTeamMemberInputRoleEnumTypeTransformer._();

  String encode(AddTeamMemberInputRoleEnum data) => data._value;

  /// Returns the instance of [AddTeamMemberInputRoleEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AddTeamMemberInputRoleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AddTeamMemberInputRoleEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'owner': return AddTeamMemberInputRoleEnum.owner;
        case r'operations': return AddTeamMemberInputRoleEnum.operations;
        case r'finance': return AddTeamMemberInputRoleEnum.finance;
        case r'guide': return AddTeamMemberInputRoleEnum.guide;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AddTeamMemberInputRoleEnumTypeTransformer? _instance;
}


