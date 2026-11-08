//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Membership {
  /// Returns a new [Membership] instance.
  Membership({
    required this.providerId,
    required this.providerName,
    required this.role,
    this.permissions = const [],
  });

  String providerId;

  String providerName;

  ProviderRole role;

  List<ProviderPermission> permissions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Membership &&
    other.providerId == providerId &&
    other.providerName == providerName &&
    other.role == role &&
    _deepEquality.equals(other.permissions, permissions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (providerId.hashCode) +
    (providerName.hashCode) +
    (role.hashCode) +
    (permissions.hashCode);

  @override
  String toString() => 'Membership[providerId=$providerId, providerName=$providerName, role=$role, permissions=$permissions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'providerId'] = this.providerId;
      json[r'providerName'] = this.providerName;
      json[r'role'] = this.role;
      json[r'permissions'] = this.permissions;
    return json;
  }

  /// Returns a new [Membership] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Membership? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'providerId'), 'Required key "Membership[providerId]" is missing from JSON.');
        assert(json[r'providerId'] != null, 'Required key "Membership[providerId]" has a null value in JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "Membership[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "Membership[providerName]" has a null value in JSON.');
        assert(json.containsKey(r'role'), 'Required key "Membership[role]" is missing from JSON.');
        assert(json[r'role'] != null, 'Required key "Membership[role]" has a null value in JSON.');
        assert(json.containsKey(r'permissions'), 'Required key "Membership[permissions]" is missing from JSON.');
        assert(json[r'permissions'] != null, 'Required key "Membership[permissions]" has a null value in JSON.');
        return true;
      }());

      return Membership(
        providerId: mapValueOfType<String>(json, r'providerId')!,
        providerName: mapValueOfType<String>(json, r'providerName')!,
        role: ProviderRole.fromJson(json[r'role'])!,
        permissions: ProviderPermission.listFromJson(json[r'permissions']),
      );
    }
    return null;
  }

  static List<Membership> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Membership>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Membership.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Membership> mapFromJson(dynamic json) {
    final map = <String, Membership>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Membership.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Membership-objects as value to a dart map
  static Map<String, List<Membership>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Membership>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Membership.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'providerId',
    'providerName',
    'role',
    'permissions',
  };
}

