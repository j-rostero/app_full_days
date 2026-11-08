//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManualBookingInputContact {
  /// Returns a new [ManualBookingInputContact] instance.
  ManualBookingInputContact({
    required this.name,
    required this.phone,
    required this.email,
  });

  String name;

  String? phone;

  String? email;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManualBookingInputContact &&
    other.name == name &&
    other.phone == phone &&
    other.email == email;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (email == null ? 0 : email!.hashCode);

  @override
  String toString() => 'ManualBookingInputContact[name=$name, phone=$phone, email=$email]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.email != null) {
      json[r'email'] = this.email;
    } else {
      json[r'email'] = null;
    }
    return json;
  }

  /// Returns a new [ManualBookingInputContact] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManualBookingInputContact? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "ManualBookingInputContact[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ManualBookingInputContact[name]" has a null value in JSON.');
        assert(json.containsKey(r'phone'), 'Required key "ManualBookingInputContact[phone]" is missing from JSON.');
        assert(json.containsKey(r'email'), 'Required key "ManualBookingInputContact[email]" is missing from JSON.');
        return true;
      }());

      return ManualBookingInputContact(
        name: mapValueOfType<String>(json, r'name')!,
        phone: mapValueOfType<String>(json, r'phone'),
        email: mapValueOfType<String>(json, r'email'),
      );
    }
    return null;
  }

  static List<ManualBookingInputContact> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualBookingInputContact>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualBookingInputContact.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManualBookingInputContact> mapFromJson(dynamic json) {
    final map = <String, ManualBookingInputContact>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManualBookingInputContact.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManualBookingInputContact-objects as value to a dart map
  static Map<String, List<ManualBookingInputContact>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManualBookingInputContact>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManualBookingInputContact.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'phone',
    'email',
  };
}

