//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ImageUrls {
  /// Returns a new [ImageUrls] instance.
  ImageUrls({
    required this.sm,
    required this.md,
    required this.lg,
    required this.xl,
  });

  String sm;

  String md;

  String lg;

  String xl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ImageUrls &&
    other.sm == sm &&
    other.md == md &&
    other.lg == lg &&
    other.xl == xl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (sm.hashCode) +
    (md.hashCode) +
    (lg.hashCode) +
    (xl.hashCode);

  @override
  String toString() => 'ImageUrls[sm=$sm, md=$md, lg=$lg, xl=$xl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'sm'] = this.sm;
      json[r'md'] = this.md;
      json[r'lg'] = this.lg;
      json[r'xl'] = this.xl;
    return json;
  }

  /// Returns a new [ImageUrls] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ImageUrls? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'sm'), 'Required key "ImageUrls[sm]" is missing from JSON.');
        assert(json[r'sm'] != null, 'Required key "ImageUrls[sm]" has a null value in JSON.');
        assert(json.containsKey(r'md'), 'Required key "ImageUrls[md]" is missing from JSON.');
        assert(json[r'md'] != null, 'Required key "ImageUrls[md]" has a null value in JSON.');
        assert(json.containsKey(r'lg'), 'Required key "ImageUrls[lg]" is missing from JSON.');
        assert(json[r'lg'] != null, 'Required key "ImageUrls[lg]" has a null value in JSON.');
        assert(json.containsKey(r'xl'), 'Required key "ImageUrls[xl]" is missing from JSON.');
        assert(json[r'xl'] != null, 'Required key "ImageUrls[xl]" has a null value in JSON.');
        return true;
      }());

      return ImageUrls(
        sm: mapValueOfType<String>(json, r'sm')!,
        md: mapValueOfType<String>(json, r'md')!,
        lg: mapValueOfType<String>(json, r'lg')!,
        xl: mapValueOfType<String>(json, r'xl')!,
      );
    }
    return null;
  }

  static List<ImageUrls> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ImageUrls>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ImageUrls.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ImageUrls> mapFromJson(dynamic json) {
    final map = <String, ImageUrls>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ImageUrls.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ImageUrls-objects as value to a dart map
  static Map<String, List<ImageUrls>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ImageUrls>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ImageUrls.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'sm',
    'md',
    'lg',
    'xl',
  };
}

