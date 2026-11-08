//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TeamMember {
  /// Returns a new [TeamMember] instance.
  TeamMember({
    required this.id,
    required this.role,
    required this.user,
    required this.createdAt,
  });

  String id;

  ProviderRole role;

  AuditEntryActor user;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TeamMember &&
    other.id == id &&
    other.role == role &&
    other.user == user &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (role.hashCode) +
    (user.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'TeamMember[id=$id, role=$role, user=$user, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'role'] = this.role;
      json[r'user'] = this.user;
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [TeamMember] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TeamMember? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "TeamMember[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "TeamMember[id]" has a null value in JSON.');
        assert(json.containsKey(r'role'), 'Required key "TeamMember[role]" is missing from JSON.');
        assert(json[r'role'] != null, 'Required key "TeamMember[role]" has a null value in JSON.');
        assert(json.containsKey(r'user'), 'Required key "TeamMember[user]" is missing from JSON.');
        assert(json[r'user'] != null, 'Required key "TeamMember[user]" has a null value in JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "TeamMember[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "TeamMember[createdAt]" has a null value in JSON.');
        return true;
      }());

      return TeamMember(
        id: mapValueOfType<String>(json, r'id')!,
        role: ProviderRole.fromJson(json[r'role'])!,
        user: AuditEntryActor.fromJson(json[r'user'])!,
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<TeamMember> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TeamMember>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TeamMember.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TeamMember> mapFromJson(dynamic json) {
    final map = <String, TeamMember>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TeamMember.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TeamMember-objects as value to a dart map
  static Map<String, List<TeamMember>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TeamMember>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TeamMember.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'role',
    'user',
    'createdAt',
  };
}

