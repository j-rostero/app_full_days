//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Me {
  /// Returns a new [Me] instance.
  Me({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.hasPassword,
    required this.hasGoogle,
    this.memberships = const [],
    required this.staff,
  });

  String id;

  String email;

  String? name;

  String? phone;

  bool hasPassword;

  bool hasGoogle;

  List<Membership> memberships;

  MeStaff staff;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Me &&
    other.id == id &&
    other.email == email &&
    other.name == name &&
    other.phone == phone &&
    other.hasPassword == hasPassword &&
    other.hasGoogle == hasGoogle &&
    _deepEquality.equals(other.memberships, memberships) &&
    other.staff == staff;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (email.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (hasPassword.hashCode) +
    (hasGoogle.hashCode) +
    (memberships.hashCode) +
    (staff.hashCode);

  @override
  String toString() => 'Me[id=$id, email=$email, name=$name, phone=$phone, hasPassword=$hasPassword, hasGoogle=$hasGoogle, memberships=$memberships, staff=$staff]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'email'] = this.email;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
      json[r'hasPassword'] = this.hasPassword;
      json[r'hasGoogle'] = this.hasGoogle;
      json[r'memberships'] = this.memberships;
      json[r'staff'] = this.staff;
    return json;
  }

  /// Returns a new [Me] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Me? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Me[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Me[id]" has a null value in JSON.');
        assert(json.containsKey(r'email'), 'Required key "Me[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "Me[email]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "Me[name]" is missing from JSON.');
        assert(json.containsKey(r'phone'), 'Required key "Me[phone]" is missing from JSON.');
        assert(json.containsKey(r'hasPassword'), 'Required key "Me[hasPassword]" is missing from JSON.');
        assert(json[r'hasPassword'] != null, 'Required key "Me[hasPassword]" has a null value in JSON.');
        assert(json.containsKey(r'hasGoogle'), 'Required key "Me[hasGoogle]" is missing from JSON.');
        assert(json[r'hasGoogle'] != null, 'Required key "Me[hasGoogle]" has a null value in JSON.');
        assert(json.containsKey(r'memberships'), 'Required key "Me[memberships]" is missing from JSON.');
        assert(json[r'memberships'] != null, 'Required key "Me[memberships]" has a null value in JSON.');
        assert(json.containsKey(r'staff'), 'Required key "Me[staff]" is missing from JSON.');
        assert(json[r'staff'] != null, 'Required key "Me[staff]" has a null value in JSON.');
        return true;
      }());

      return Me(
        id: mapValueOfType<String>(json, r'id')!,
        email: mapValueOfType<String>(json, r'email')!,
        name: mapValueOfType<String>(json, r'name'),
        phone: mapValueOfType<String>(json, r'phone'),
        hasPassword: mapValueOfType<bool>(json, r'hasPassword')!,
        hasGoogle: mapValueOfType<bool>(json, r'hasGoogle')!,
        memberships: Membership.listFromJson(json[r'memberships']),
        staff: MeStaff.fromJson(json[r'staff'])!,
      );
    }
    return null;
  }

  static List<Me> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Me>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Me.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Me> mapFromJson(dynamic json) {
    final map = <String, Me>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Me.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Me-objects as value to a dart map
  static Map<String, List<Me>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Me>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Me.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'email',
    'name',
    'phone',
    'hasPassword',
    'hasGoogle',
    'memberships',
    'staff',
  };
}

