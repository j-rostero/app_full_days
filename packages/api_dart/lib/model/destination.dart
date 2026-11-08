//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Destination {
  /// Returns a new [Destination] instance.
  Destination({
    required this.id,
    required this.slug,
    required this.name,
    required this.state,
    required this.region,
    required this.lat,
    required this.lng,
    this.fees = const [],
    this.sites = const [],
  });

  String id;

  String slug;

  String name;

  String state;

  String region;

  num? lat;

  num? lng;

  List<DestinationFee> fees;

  List<Site> sites;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Destination &&
    other.id == id &&
    other.slug == slug &&
    other.name == name &&
    other.state == state &&
    other.region == region &&
    other.lat == lat &&
    other.lng == lng &&
    _deepEquality.equals(other.fees, fees) &&
    _deepEquality.equals(other.sites, sites);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (slug.hashCode) +
    (name.hashCode) +
    (state.hashCode) +
    (region.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lng == null ? 0 : lng!.hashCode) +
    (fees.hashCode) +
    (sites.hashCode);

  @override
  String toString() => 'Destination[id=$id, slug=$slug, name=$name, state=$state, region=$region, lat=$lat, lng=$lng, fees=$fees, sites=$sites]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
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
      json[r'fees'] = this.fees;
      json[r'sites'] = this.sites;
    return json;
  }

  /// Returns a new [Destination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Destination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Destination[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Destination[id]" has a null value in JSON.');
        assert(json.containsKey(r'slug'), 'Required key "Destination[slug]" is missing from JSON.');
        assert(json[r'slug'] != null, 'Required key "Destination[slug]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "Destination[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "Destination[name]" has a null value in JSON.');
        assert(json.containsKey(r'state'), 'Required key "Destination[state]" is missing from JSON.');
        assert(json[r'state'] != null, 'Required key "Destination[state]" has a null value in JSON.');
        assert(json.containsKey(r'region'), 'Required key "Destination[region]" is missing from JSON.');
        assert(json[r'region'] != null, 'Required key "Destination[region]" has a null value in JSON.');
        assert(json.containsKey(r'lat'), 'Required key "Destination[lat]" is missing from JSON.');
        assert(json.containsKey(r'lng'), 'Required key "Destination[lng]" is missing from JSON.');
        assert(json.containsKey(r'fees'), 'Required key "Destination[fees]" is missing from JSON.');
        assert(json[r'fees'] != null, 'Required key "Destination[fees]" has a null value in JSON.');
        assert(json.containsKey(r'sites'), 'Required key "Destination[sites]" is missing from JSON.');
        assert(json[r'sites'] != null, 'Required key "Destination[sites]" has a null value in JSON.');
        return true;
      }());

      return Destination(
        id: mapValueOfType<String>(json, r'id')!,
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
        fees: DestinationFee.listFromJson(json[r'fees']),
        sites: Site.listFromJson(json[r'sites']),
      );
    }
    return null;
  }

  static List<Destination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Destination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Destination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Destination> mapFromJson(dynamic json) {
    final map = <String, Destination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Destination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Destination-objects as value to a dart map
  static Map<String, List<Destination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Destination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Destination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'slug',
    'name',
    'state',
    'region',
    'lat',
    'lng',
    'fees',
    'sites',
  };
}

