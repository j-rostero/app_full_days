//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicAgency {
  /// Returns a new [PublicAgency] instance.
  PublicAgency({
    required this.provider,
    this.products = const [],
  });

  PublicAgencyProvider provider;

  List<PublicProductCard> products;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicAgency &&
    other.provider == provider &&
    _deepEquality.equals(other.products, products);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (provider.hashCode) +
    (products.hashCode);

  @override
  String toString() => 'PublicAgency[provider=$provider, products=$products]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'provider'] = this.provider;
      json[r'products'] = this.products;
    return json;
  }

  /// Returns a new [PublicAgency] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicAgency? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'provider'), 'Required key "PublicAgency[provider]" is missing from JSON.');
        assert(json[r'provider'] != null, 'Required key "PublicAgency[provider]" has a null value in JSON.');
        assert(json.containsKey(r'products'), 'Required key "PublicAgency[products]" is missing from JSON.');
        assert(json[r'products'] != null, 'Required key "PublicAgency[products]" has a null value in JSON.');
        return true;
      }());

      return PublicAgency(
        provider: PublicAgencyProvider.fromJson(json[r'provider'])!,
        products: PublicProductCard.listFromJson(json[r'products']),
      );
    }
    return null;
  }

  static List<PublicAgency> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicAgency>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicAgency.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicAgency> mapFromJson(dynamic json) {
    final map = <String, PublicAgency>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicAgency.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicAgency-objects as value to a dart map
  static Map<String, List<PublicAgency>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicAgency>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicAgency.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'provider',
    'products',
  };
}

