//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProduct {
  /// Returns a new [PublicProduct] instance.
  PublicProduct({
    required this.id,
    required this.type,
    required this.sheet,
    this.photos = const [],
    required this.featured,
    this.themes = const [],
    required this.destination,
    required this.cashAtDestination,
    required this.inclusions,
    required this.provider,
    this.departures = const [],
  });

  String id;

  ProductType type;

  ProductSheet sheet;

  List<Photo> photos;

  bool featured;

  List<PublicProductThemesInner> themes;

  PublicProductDestination? destination;

  PublicProductCashAtDestination cashAtDestination;

  PublicProductInclusions inclusions;

  PublicAgencyProvider provider;

  List<DepartureDate> departures;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProduct &&
    other.id == id &&
    other.type == type &&
    other.sheet == sheet &&
    _deepEquality.equals(other.photos, photos) &&
    other.featured == featured &&
    _deepEquality.equals(other.themes, themes) &&
    other.destination == destination &&
    other.cashAtDestination == cashAtDestination &&
    other.inclusions == inclusions &&
    other.provider == provider &&
    _deepEquality.equals(other.departures, departures);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (sheet.hashCode) +
    (photos.hashCode) +
    (featured.hashCode) +
    (themes.hashCode) +
    (destination == null ? 0 : destination!.hashCode) +
    (cashAtDestination.hashCode) +
    (inclusions.hashCode) +
    (provider.hashCode) +
    (departures.hashCode);

  @override
  String toString() => 'PublicProduct[id=$id, type=$type, sheet=$sheet, photos=$photos, featured=$featured, themes=$themes, destination=$destination, cashAtDestination=$cashAtDestination, inclusions=$inclusions, provider=$provider, departures=$departures]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'sheet'] = this.sheet;
      json[r'photos'] = this.photos;
      json[r'featured'] = this.featured;
      json[r'themes'] = this.themes;
    if (this.destination != null) {
      json[r'destination'] = this.destination;
    } else {
      json[r'destination'] = null;
    }
      json[r'cashAtDestination'] = this.cashAtDestination;
      json[r'inclusions'] = this.inclusions;
      json[r'provider'] = this.provider;
      json[r'departures'] = this.departures;
    return json;
  }

  /// Returns a new [PublicProduct] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProduct? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "PublicProduct[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "PublicProduct[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "PublicProduct[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "PublicProduct[type]" has a null value in JSON.');
        assert(json.containsKey(r'sheet'), 'Required key "PublicProduct[sheet]" is missing from JSON.');
        assert(json[r'sheet'] != null, 'Required key "PublicProduct[sheet]" has a null value in JSON.');
        assert(json.containsKey(r'photos'), 'Required key "PublicProduct[photos]" is missing from JSON.');
        assert(json[r'photos'] != null, 'Required key "PublicProduct[photos]" has a null value in JSON.');
        assert(json.containsKey(r'featured'), 'Required key "PublicProduct[featured]" is missing from JSON.');
        assert(json[r'featured'] != null, 'Required key "PublicProduct[featured]" has a null value in JSON.');
        assert(json.containsKey(r'themes'), 'Required key "PublicProduct[themes]" is missing from JSON.');
        assert(json[r'themes'] != null, 'Required key "PublicProduct[themes]" has a null value in JSON.');
        assert(json.containsKey(r'destination'), 'Required key "PublicProduct[destination]" is missing from JSON.');
        assert(json.containsKey(r'cashAtDestination'), 'Required key "PublicProduct[cashAtDestination]" is missing from JSON.');
        assert(json[r'cashAtDestination'] != null, 'Required key "PublicProduct[cashAtDestination]" has a null value in JSON.');
        assert(json.containsKey(r'inclusions'), 'Required key "PublicProduct[inclusions]" is missing from JSON.');
        assert(json[r'inclusions'] != null, 'Required key "PublicProduct[inclusions]" has a null value in JSON.');
        assert(json.containsKey(r'provider'), 'Required key "PublicProduct[provider]" is missing from JSON.');
        assert(json[r'provider'] != null, 'Required key "PublicProduct[provider]" has a null value in JSON.');
        assert(json.containsKey(r'departures'), 'Required key "PublicProduct[departures]" is missing from JSON.');
        assert(json[r'departures'] != null, 'Required key "PublicProduct[departures]" has a null value in JSON.');
        return true;
      }());

      return PublicProduct(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductType.fromJson(json[r'type'])!,
        sheet: ProductSheet.fromJson(json[r'sheet'])!,
        photos: Photo.listFromJson(json[r'photos']),
        featured: mapValueOfType<bool>(json, r'featured')!,
        themes: PublicProductThemesInner.listFromJson(json[r'themes']),
        destination: PublicProductDestination.fromJson(json[r'destination']),
        cashAtDestination: PublicProductCashAtDestination.fromJson(json[r'cashAtDestination'])!,
        inclusions: PublicProductInclusions.fromJson(json[r'inclusions'])!,
        provider: PublicAgencyProvider.fromJson(json[r'provider'])!,
        departures: DepartureDate.listFromJson(json[r'departures']),
      );
    }
    return null;
  }

  static List<PublicProduct> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProduct>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProduct.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProduct> mapFromJson(dynamic json) {
    final map = <String, PublicProduct>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProduct.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProduct-objects as value to a dart map
  static Map<String, List<PublicProduct>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProduct>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProduct.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'sheet',
    'photos',
    'featured',
    'themes',
    'destination',
    'cashAtDestination',
    'inclusions',
    'provider',
    'departures',
  };
}

