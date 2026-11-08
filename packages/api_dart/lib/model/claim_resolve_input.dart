//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClaimResolveInput {
  /// Returns a new [ClaimResolveInput] instance.
  ClaimResolveInput({
    required this.resolution,
  });

  String resolution;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClaimResolveInput &&
    other.resolution == resolution;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (resolution.hashCode);

  @override
  String toString() => 'ClaimResolveInput[resolution=$resolution]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'resolution'] = this.resolution;
    return json;
  }

  /// Returns a new [ClaimResolveInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClaimResolveInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'resolution'), 'Required key "ClaimResolveInput[resolution]" is missing from JSON.');
        assert(json[r'resolution'] != null, 'Required key "ClaimResolveInput[resolution]" has a null value in JSON.');
        return true;
      }());

      return ClaimResolveInput(
        resolution: mapValueOfType<String>(json, r'resolution')!,
      );
    }
    return null;
  }

  static List<ClaimResolveInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClaimResolveInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClaimResolveInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClaimResolveInput> mapFromJson(dynamic json) {
    final map = <String, ClaimResolveInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClaimResolveInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClaimResolveInput-objects as value to a dart map
  static Map<String, List<ClaimResolveInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClaimResolveInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClaimResolveInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'resolution',
  };
}

