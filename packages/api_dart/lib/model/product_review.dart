//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductReview {
  /// Returns a new [ProductReview] instance.
  ProductReview({
    required this.product,
    required this.providerName,
    required this.providerHasRtn,
    this.contacts = const [],
    required this.featured,
    this.themeIds = const [],
  });

  ProductDetail product;

  String providerName;

  bool providerHasRtn;

  List<String> contacts;

  bool featured;

  List<String> themeIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductReview &&
    other.product == product &&
    other.providerName == providerName &&
    other.providerHasRtn == providerHasRtn &&
    _deepEquality.equals(other.contacts, contacts) &&
    other.featured == featured &&
    _deepEquality.equals(other.themeIds, themeIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (product.hashCode) +
    (providerName.hashCode) +
    (providerHasRtn.hashCode) +
    (contacts.hashCode) +
    (featured.hashCode) +
    (themeIds.hashCode);

  @override
  String toString() => 'ProductReview[product=$product, providerName=$providerName, providerHasRtn=$providerHasRtn, contacts=$contacts, featured=$featured, themeIds=$themeIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'product'] = this.product;
      json[r'providerName'] = this.providerName;
      json[r'providerHasRtn'] = this.providerHasRtn;
      json[r'contacts'] = this.contacts;
      json[r'featured'] = this.featured;
      json[r'themeIds'] = this.themeIds;
    return json;
  }

  /// Returns a new [ProductReview] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductReview? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'product'), 'Required key "ProductReview[product]" is missing from JSON.');
        assert(json[r'product'] != null, 'Required key "ProductReview[product]" has a null value in JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "ProductReview[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "ProductReview[providerName]" has a null value in JSON.');
        assert(json.containsKey(r'providerHasRtn'), 'Required key "ProductReview[providerHasRtn]" is missing from JSON.');
        assert(json[r'providerHasRtn'] != null, 'Required key "ProductReview[providerHasRtn]" has a null value in JSON.');
        assert(json.containsKey(r'contacts'), 'Required key "ProductReview[contacts]" is missing from JSON.');
        assert(json[r'contacts'] != null, 'Required key "ProductReview[contacts]" has a null value in JSON.');
        assert(json.containsKey(r'featured'), 'Required key "ProductReview[featured]" is missing from JSON.');
        assert(json[r'featured'] != null, 'Required key "ProductReview[featured]" has a null value in JSON.');
        assert(json.containsKey(r'themeIds'), 'Required key "ProductReview[themeIds]" is missing from JSON.');
        assert(json[r'themeIds'] != null, 'Required key "ProductReview[themeIds]" has a null value in JSON.');
        return true;
      }());

      return ProductReview(
        product: ProductDetail.fromJson(json[r'product'])!,
        providerName: mapValueOfType<String>(json, r'providerName')!,
        providerHasRtn: mapValueOfType<bool>(json, r'providerHasRtn')!,
        contacts: json[r'contacts'] is Iterable
            ? (json[r'contacts'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        featured: mapValueOfType<bool>(json, r'featured')!,
        themeIds: json[r'themeIds'] is Iterable
            ? (json[r'themeIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<ProductReview> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductReview>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductReview.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductReview> mapFromJson(dynamic json) {
    final map = <String, ProductReview>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductReview.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductReview-objects as value to a dart map
  static Map<String, List<ProductReview>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductReview>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductReview.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'product',
    'providerName',
    'providerHasRtn',
    'contacts',
    'featured',
    'themeIds',
  };
}

