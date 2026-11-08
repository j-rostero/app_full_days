//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DestinationInput {
  /// Returns a new [DestinationInput] instance.
  DestinationInput({
    required this.slug,
    required this.name,
    this.state = '',
    this.region = '',
    required this.lat,
    required this.lng,
    required this.parentId,
  });

  String slug;

  String name;

  String state;

  String region;

  /// Minimum value: -90
  /// Maximum value: 90
  num? lat;

  /// Minimum value: -180
  /// Maximum value: 180
  num? lng;

  String? parentId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DestinationInput &&
    other.slug == slug &&
    other.name == name &&
    other.state == state &&
    other.region == region &&
    other.lat == lat &&
    other.lng == lng &&
    other.parentId == parentId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (slug.hashCode) +
    (name.hashCode) +
    (state.hashCode) +
    (region.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lng == null ? 0 : lng!.hashCode) +
    (parentId == null ? 0 : parentId!.hashCode);

  @override
  String toString() => 'DestinationInput[slug=$slug, name=$name, state=$state, region=$region, lat=$lat, lng=$lng, parentId=$parentId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'slug'] = this.slug;
      json[r'name'] = this.name;
      json[r'state'] = this.state;
      json[r'region'] = this.region;
    if (this.lat != null) {
      json[r'lat'] = this.lat;
    } else {
      json[r'lat'] = null;
    }
    if (this.lng != null) {
      json[r'lng'] = this.lng;
    } else {
      json[r'lng'] = null;
    }
    if (this.parentId != null) {
      json[r'parentId'] = this.parentId;
    } else {
      json[r'parentId'] = null;
    }
    return json;
  }

  /// Returns a new [DestinationInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DestinationInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'slug'), 'Required key "DestinationInput[slug]" is missing from JSON.');
        assert(json[r'slug'] != null, 'Required key "DestinationInput[slug]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "DestinationInput[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "DestinationInput[name]" has a null value in JSON.');
        assert(json.containsKey(r'state'), 'Required key "DestinationInput[state]" is missing from JSON.');
        assert(json[r'state'] != null, 'Required key "DestinationInput[state]" has a null value in JSON.');
        assert(json.containsKey(r'region'), 'Required key "DestinationInput[region]" is missing from JSON.');
        assert(json[r'region'] != null, 'Required key "DestinationInput[region]" has a null value in JSON.');
        assert(json.containsKey(r'lat'), 'Required key "DestinationInput[lat]" is missing from JSON.');
        assert(json.containsKey(r'lng'), 'Required key "DestinationInput[lng]" is missing from JSON.');
        assert(json.containsKey(r'parentId'), 'Required key "DestinationInput[parentId]" is missing from JSON.');
        return true;
      }());

      return DestinationInput(
        slug: mapValueOfType<String>(json, r'slug')!,
        name: mapValueOfType<String>(json, r'name')!,
        state: mapValueOfType<String>(json, r'state')!,
        region: mapValueOfType<String>(json, r'region')!,
        lat: json[r'lat'] == null
            ? null
            : num.parse('${json[r'lat']}'),
        lng: json[r'lng'] == null
            ? null
            : num.parse('${json[r'lng']}'),
        parentId: mapValueOfType<String>(json, r'parentId'),
      );
    }
    return null;
  }

  static List<DestinationInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DestinationInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DestinationInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DestinationInput> mapFromJson(dynamic json) {
    final map = <String, DestinationInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DestinationInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DestinationInput-objects as value to a dart map
  static Map<String, List<DestinationInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DestinationInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DestinationInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'slug',
    'name',
    'state',
    'region',
    'lat',
    'lng',
    'parentId',
  };
}

