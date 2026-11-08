//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MeStaff {
  /// Returns a new [MeStaff] instance.
  MeStaff({
    this.roles = const [],
    this.permissions = const [],
  });

  List<StaffRole> roles;

  List<StaffPermission> permissions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MeStaff &&
    _deepEquality.equals(other.roles, roles) &&
    _deepEquality.equals(other.permissions, permissions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (roles.hashCode) +
    (permissions.hashCode);

  @override
  String toString() => 'MeStaff[roles=$roles, permissions=$permissions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'roles'] = this.roles;
      json[r'permissions'] = this.permissions;
    return json;
  }

  /// Returns a new [MeStaff] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MeStaff? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'roles'), 'Required key "MeStaff[roles]" is missing from JSON.');
        assert(json[r'roles'] != null, 'Required key "MeStaff[roles]" has a null value in JSON.');
        assert(json.containsKey(r'permissions'), 'Required key "MeStaff[permissions]" is missing from JSON.');
        assert(json[r'permissions'] != null, 'Required key "MeStaff[permissions]" has a null value in JSON.');
        return true;
      }());

      return MeStaff(
        roles: StaffRole.listFromJson(json[r'roles']),
        permissions: StaffPermission.listFromJson(json[r'permissions']),
      );
    }
    return null;
  }

  static List<MeStaff> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MeStaff>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MeStaff.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MeStaff> mapFromJson(dynamic json) {
    final map = <String, MeStaff>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MeStaff.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MeStaff-objects as value to a dart map
  static Map<String, List<MeStaff>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MeStaff>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MeStaff.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'roles',
    'permissions',
  };
}

