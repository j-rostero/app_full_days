//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CurationInput {
  /// Returns a new [CurationInput] instance.
  CurationInput({
    required this.featured,
    this.themeIds = const [],
  });

  bool featured;

  List<String> themeIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CurationInput &&
    other.featured == featured &&
    _deepEquality.equals(other.themeIds, themeIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (featured.hashCode) +
    (themeIds.hashCode);

  @override
  String toString() => 'CurationInput[featured=$featured, themeIds=$themeIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'featured'] = this.featured;
      json[r'themeIds'] = this.themeIds;
    return json;
  }

  /// Returns a new [CurationInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CurationInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'featured'), 'Required key "CurationInput[featured]" is missing from JSON.');
        assert(json[r'featured'] != null, 'Required key "CurationInput[featured]" has a null value in JSON.');
        assert(json.containsKey(r'themeIds'), 'Required key "CurationInput[themeIds]" is missing from JSON.');
        assert(json[r'themeIds'] != null, 'Required key "CurationInput[themeIds]" has a null value in JSON.');
        return true;
      }());

      return CurationInput(
        featured: mapValueOfType<bool>(json, r'featured')!,
        themeIds: json[r'themeIds'] is Iterable
            ? (json[r'themeIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<CurationInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CurationInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CurationInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CurationInput> mapFromJson(dynamic json) {
    final map = <String, CurationInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CurationInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CurationInput-objects as value to a dart map
  static Map<String, List<CurationInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CurationInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CurationInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'featured',
    'themeIds',
  };
}

