//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PassengerInput {
  /// Returns a new [PassengerInput] instance.
  PassengerInput({
    required this.name,
    this.cedula = null,
    required this.birthDate,
    required this.restrictions,
  });

  String name;

  Object? cedula;

  DateTime birthDate;

  String? restrictions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PassengerInput &&
    other.name == name &&
    other.cedula == cedula &&
    other.birthDate == birthDate &&
    other.restrictions == restrictions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (cedula == null ? 0 : cedula!.hashCode) +
    (birthDate.hashCode) +
    (restrictions == null ? 0 : restrictions!.hashCode);

  @override
  String toString() => 'PassengerInput[name=$name, cedula=$cedula, birthDate=$birthDate, restrictions=$restrictions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.cedula != null) {
      json[r'cedula'] = this.cedula;
    } else {
      json[r'cedula'] = null;
    }
      json[r'birthDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.birthDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.birthDate);
    if (this.restrictions != null) {
      json[r'restrictions'] = this.restrictions;
    } else {
      json[r'restrictions'] = null;
    }
    return json;
  }

  /// Returns a new [PassengerInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PassengerInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "PassengerInput[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "PassengerInput[name]" has a null value in JSON.');
        assert(json.containsKey(r'cedula'), 'Required key "PassengerInput[cedula]" is missing from JSON.');
        assert(json.containsKey(r'birthDate'), 'Required key "PassengerInput[birthDate]" is missing from JSON.');
        assert(json[r'birthDate'] != null, 'Required key "PassengerInput[birthDate]" has a null value in JSON.');
        assert(json.containsKey(r'restrictions'), 'Required key "PassengerInput[restrictions]" is missing from JSON.');
        return true;
      }());

      return PassengerInput(
        name: mapValueOfType<String>(json, r'name')!,
        cedula: mapValueOfType<Object>(json, r'cedula'),
        birthDate: mapDateTime(json, r'birthDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        restrictions: mapValueOfType<String>(json, r'restrictions'),
      );
    }
    return null;
  }

  static List<PassengerInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PassengerInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PassengerInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PassengerInput> mapFromJson(dynamic json) {
    final map = <String, PassengerInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PassengerInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PassengerInput-objects as value to a dart map
  static Map<String, List<PassengerInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PassengerInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PassengerInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'cedula',
    'birthDate',
    'restrictions',
  };
}

