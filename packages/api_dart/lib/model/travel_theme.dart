//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TravelTheme {
  /// Returns a new [TravelTheme] instance.
  TravelTheme({
    required this.id,
    required this.slug,
    required this.name,
    required this.description,
  });

  String id;

  String slug;

  String name;

  String description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TravelTheme &&
    other.id == id &&
    other.slug == slug &&
    other.name == name &&
    other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (slug.hashCode) +
    (name.hashCode) +
    (description.hashCode);

  @override
  String toString() => 'TravelTheme[id=$id, slug=$slug, name=$name, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'slug'] = this.slug;
      json[r'name'] = this.name;
      json[r'description'] = this.description;
    return json;
  }

  /// Returns a new [TravelTheme] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TravelTheme? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "TravelTheme[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "TravelTheme[id]" has a null value in JSON.');
        assert(json.containsKey(r'slug'), 'Required key "TravelTheme[slug]" is missing from JSON.');
        assert(json[r'slug'] != null, 'Required key "TravelTheme[slug]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "TravelTheme[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "TravelTheme[name]" has a null value in JSON.');
        assert(json.containsKey(r'description'), 'Required key "TravelTheme[description]" is missing from JSON.');
        assert(json[r'description'] != null, 'Required key "TravelTheme[description]" has a null value in JSON.');
        return true;
      }());

      return TravelTheme(
        id: mapValueOfType<String>(json, r'id')!,
        slug: mapValueOfType<String>(json, r'slug')!,
        name: mapValueOfType<String>(json, r'name')!,
        description: mapValueOfType<String>(json, r'description')!,
      );
    }
    return null;
  }

  static List<TravelTheme> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TravelTheme>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TravelTheme.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TravelTheme> mapFromJson(dynamic json) {
    final map = <String, TravelTheme>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TravelTheme.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TravelTheme-objects as value to a dart map
  static Map<String, List<TravelTheme>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TravelTheme>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TravelTheme.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'slug',
    'name',
    'description',
  };
}

