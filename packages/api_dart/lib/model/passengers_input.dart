//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PassengersInput {
  /// Returns a new [PassengersInput] instance.
  PassengersInput({
    this.passengers = const [],
  });

  List<PassengersInputPassengersInner> passengers;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PassengersInput &&
    _deepEquality.equals(other.passengers, passengers);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (passengers.hashCode);

  @override
  String toString() => 'PassengersInput[passengers=$passengers]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'passengers'] = this.passengers;
    return json;
  }

  /// Returns a new [PassengersInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PassengersInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'passengers'), 'Required key "PassengersInput[passengers]" is missing from JSON.');
        assert(json[r'passengers'] != null, 'Required key "PassengersInput[passengers]" has a null value in JSON.');
        return true;
      }());

      return PassengersInput(
        passengers: PassengersInputPassengersInner.listFromJson(json[r'passengers']),
      );
    }
    return null;
  }

  static List<PassengersInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PassengersInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PassengersInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PassengersInput> mapFromJson(dynamic json) {
    final map = <String, PassengersInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PassengersInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PassengersInput-objects as value to a dart map
  static Map<String, List<PassengersInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PassengersInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PassengersInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'passengers',
  };
}

