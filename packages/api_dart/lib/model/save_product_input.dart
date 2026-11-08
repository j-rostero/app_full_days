//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SaveProductInput {
  /// Returns a new [SaveProductInput] instance.
  SaveProductInput({
    required this.version,
    required this.sheet,
  });

  /// Minimum value: 1
  /// Maximum value: 9007199254740991
  int version;

  ProductSheet sheet;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SaveProductInput &&
    other.version == version &&
    other.sheet == sheet;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (version.hashCode) +
    (sheet.hashCode);

  @override
  String toString() => 'SaveProductInput[version=$version, sheet=$sheet]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'version'] = this.version;
      json[r'sheet'] = this.sheet;
    return json;
  }

  /// Returns a new [SaveProductInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SaveProductInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'version'), 'Required key "SaveProductInput[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "SaveProductInput[version]" has a null value in JSON.');
        assert(json.containsKey(r'sheet'), 'Required key "SaveProductInput[sheet]" is missing from JSON.');
        assert(json[r'sheet'] != null, 'Required key "SaveProductInput[sheet]" has a null value in JSON.');
        return true;
      }());

      return SaveProductInput(
        version: mapValueOfType<int>(json, r'version')!,
        sheet: ProductSheet.fromJson(json[r'sheet'])!,
      );
    }
    return null;
  }

  static List<SaveProductInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SaveProductInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SaveProductInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SaveProductInput> mapFromJson(dynamic json) {
    final map = <String, SaveProductInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SaveProductInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SaveProductInput-objects as value to a dart map
  static Map<String, List<SaveProductInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SaveProductInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SaveProductInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'version',
    'sheet',
  };
}

