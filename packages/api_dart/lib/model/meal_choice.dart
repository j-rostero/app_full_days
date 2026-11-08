//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MealChoice {
  /// Returns a new [MealChoice] instance.
  MealChoice({
    required this.mealId,
    required this.name,
    required this.picksPerPassenger,
    this.options = const [],
  });

  String mealId;

  String name;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int picksPerPassenger;

  List<MealChoiceOptionsInner> options;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MealChoice &&
    other.mealId == mealId &&
    other.name == name &&
    other.picksPerPassenger == picksPerPassenger &&
    _deepEquality.equals(other.options, options);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mealId.hashCode) +
    (name.hashCode) +
    (picksPerPassenger.hashCode) +
    (options.hashCode);

  @override
  String toString() => 'MealChoice[mealId=$mealId, name=$name, picksPerPassenger=$picksPerPassenger, options=$options]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mealId'] = this.mealId;
      json[r'name'] = this.name;
      json[r'picksPerPassenger'] = this.picksPerPassenger;
      json[r'options'] = this.options;
    return json;
  }

  /// Returns a new [MealChoice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MealChoice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mealId'), 'Required key "MealChoice[mealId]" is missing from JSON.');
        assert(json[r'mealId'] != null, 'Required key "MealChoice[mealId]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "MealChoice[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "MealChoice[name]" has a null value in JSON.');
        assert(json.containsKey(r'picksPerPassenger'), 'Required key "MealChoice[picksPerPassenger]" is missing from JSON.');
        assert(json[r'picksPerPassenger'] != null, 'Required key "MealChoice[picksPerPassenger]" has a null value in JSON.');
        assert(json.containsKey(r'options'), 'Required key "MealChoice[options]" is missing from JSON.');
        assert(json[r'options'] != null, 'Required key "MealChoice[options]" has a null value in JSON.');
        return true;
      }());

      return MealChoice(
        mealId: mapValueOfType<String>(json, r'mealId')!,
        name: mapValueOfType<String>(json, r'name')!,
        picksPerPassenger: mapValueOfType<int>(json, r'picksPerPassenger')!,
        options: MealChoiceOptionsInner.listFromJson(json[r'options']),
      );
    }
    return null;
  }

  static List<MealChoice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MealChoice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MealChoice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MealChoice> mapFromJson(dynamic json) {
    final map = <String, MealChoice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MealChoice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MealChoice-objects as value to a dart map
  static Map<String, List<MealChoice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MealChoice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MealChoice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mealId',
    'name',
    'picksPerPassenger',
    'options',
  };
}

