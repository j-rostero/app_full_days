//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Photo {
  /// Returns a new [Photo] instance.
  Photo({
    required this.id,
    required this.urls,
  });

  String id;

  ImageUrls urls;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Photo &&
    other.id == id &&
    other.urls == urls;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (urls.hashCode);

  @override
  String toString() => 'Photo[id=$id, urls=$urls]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'urls'] = this.urls;
    return json;
  }

  /// Returns a new [Photo] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Photo? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Photo[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Photo[id]" has a null value in JSON.');
        assert(json.containsKey(r'urls'), 'Required key "Photo[urls]" is missing from JSON.');
        assert(json[r'urls'] != null, 'Required key "Photo[urls]" has a null value in JSON.');
        return true;
      }());

      return Photo(
        id: mapValueOfType<String>(json, r'id')!,
        urls: ImageUrls.fromJson(json[r'urls'])!,
      );
    }
    return null;
  }

  static List<Photo> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Photo>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Photo.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Photo> mapFromJson(dynamic json) {
    final map = <String, Photo>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Photo.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Photo-objects as value to a dart map
  static Map<String, List<Photo>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Photo>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Photo.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'urls',
  };
}

