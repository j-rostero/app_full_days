//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class MealChoiceOptionsInner {
  /// Returns a new [MealChoiceOptionsInner] instance.
  MealChoiceOptionsInner({
    required this.id,
    required this.name,
    required this.isDefault,
  });

  String id;

  String name;

  bool isDefault;

  @override
  bool operator ==(Object other) => identical(this, other) || other is MealChoiceOptionsInner &&
    other.id == id &&
    other.name == name &&
    other.isDefault == isDefault;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (isDefault.hashCode);

  @override
  String toString() => 'MealChoiceOptionsInner[id=$id, name=$name, isDefault=$isDefault]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'isDefault'] = this.isDefault;
    return json;
  }

  /// Returns a new [MealChoiceOptionsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static MealChoiceOptionsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "MealChoiceOptionsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "MealChoiceOptionsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "MealChoiceOptionsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "MealChoiceOptionsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'isDefault'), 'Required key "MealChoiceOptionsInner[isDefault]" is missing from JSON.');
        assert(json[r'isDefault'] != null, 'Required key "MealChoiceOptionsInner[isDefault]" has a null value in JSON.');
        return true;
      }());

      return MealChoiceOptionsInner(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        isDefault: mapValueOfType<bool>(json, r'isDefault')!,
      );
    }
    return null;
  }

  static List<MealChoiceOptionsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <MealChoiceOptionsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = MealChoiceOptionsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, MealChoiceOptionsInner> mapFromJson(dynamic json) {
    final map = <String, MealChoiceOptionsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = MealChoiceOptionsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of MealChoiceOptionsInner-objects as value to a dart map
  static Map<String, List<MealChoiceOptionsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<MealChoiceOptionsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = MealChoiceOptionsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'isDefault',
  };
}

