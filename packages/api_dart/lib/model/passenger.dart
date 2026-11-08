//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Passenger {
  /// Returns a new [Passenger] instance.
  Passenger({
    required this.id,
    required this.name,
    required this.cedula,
    required this.birthDate,
    required this.restrictions,
  });

  String id;

  String name;

  String? cedula;

  /// AAAA-MM-DD
  String birthDate;

  String? restrictions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Passenger &&
    other.id == id &&
    other.name == name &&
    other.cedula == cedula &&
    other.birthDate == birthDate &&
    other.restrictions == restrictions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (cedula == null ? 0 : cedula!.hashCode) +
    (birthDate.hashCode) +
    (restrictions == null ? 0 : restrictions!.hashCode);

  @override
  String toString() => 'Passenger[id=$id, name=$name, cedula=$cedula, birthDate=$birthDate, restrictions=$restrictions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
    if (this.cedula != null) {
      json[r'cedula'] = this.cedula;
    } else {
      json[r'cedula'] = null;
    }
      json[r'birthDate'] = this.birthDate;
    if (this.restrictions != null) {
      json[r'restrictions'] = this.restrictions;
    } else {
      json[r'restrictions'] = null;
    }
    return json;
  }

  /// Returns a new [Passenger] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Passenger? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Passenger[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Passenger[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "Passenger[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "Passenger[name]" has a null value in JSON.');
        assert(json.containsKey(r'cedula'), 'Required key "Passenger[cedula]" is missing from JSON.');
        assert(json.containsKey(r'birthDate'), 'Required key "Passenger[birthDate]" is missing from JSON.');
        assert(json[r'birthDate'] != null, 'Required key "Passenger[birthDate]" has a null value in JSON.');
        assert(json.containsKey(r'restrictions'), 'Required key "Passenger[restrictions]" is missing from JSON.');
        return true;
      }());

      return Passenger(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        cedula: mapValueOfType<String>(json, r'cedula'),
        birthDate: mapValueOfType<String>(json, r'birthDate')!,
        restrictions: mapValueOfType<String>(json, r'restrictions'),
      );
    }
    return null;
  }

  static List<Passenger> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Passenger>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Passenger.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Passenger> mapFromJson(dynamic json) {
    final map = <String, Passenger>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Passenger.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Passenger-objects as value to a dart map
  static Map<String, List<Passenger>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Passenger>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Passenger.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'cedula',
    'birthDate',
    'restrictions',
  };
}

