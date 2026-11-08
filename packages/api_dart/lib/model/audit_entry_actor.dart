//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuditEntryActor {
  /// Returns a new [AuditEntryActor] instance.
  AuditEntryActor({
    required this.id,
    required this.email,
    required this.name,
  });

  String id;

  String email;

  String? name;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuditEntryActor &&
    other.id == id &&
    other.email == email &&
    other.name == name;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (email.hashCode) +
    (name == null ? 0 : name!.hashCode);

  @override
  String toString() => 'AuditEntryActor[id=$id, email=$email, name=$name]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'email'] = this.email;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    return json;
  }

  /// Returns a new [AuditEntryActor] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuditEntryActor? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AuditEntryActor[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AuditEntryActor[id]" has a null value in JSON.');
        assert(json.containsKey(r'email'), 'Required key "AuditEntryActor[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "AuditEntryActor[email]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "AuditEntryActor[name]" is missing from JSON.');
        return true;
      }());

      return AuditEntryActor(
        id: mapValueOfType<String>(json, r'id')!,
        email: mapValueOfType<String>(json, r'email')!,
        name: mapValueOfType<String>(json, r'name'),
      );
    }
    return null;
  }

  static List<AuditEntryActor> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuditEntryActor>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuditEntryActor.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuditEntryActor> mapFromJson(dynamic json) {
    final map = <String, AuditEntryActor>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuditEntryActor.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuditEntryActor-objects as value to a dart map
  static Map<String, List<AuditEntryActor>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuditEntryActor>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuditEntryActor.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'email',
    'name',
  };
}

