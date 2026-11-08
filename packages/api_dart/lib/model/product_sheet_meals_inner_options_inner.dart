//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetMealsInnerOptionsInner {
  /// Returns a new [ProductSheetMealsInnerOptionsInner] instance.
  ProductSheetMealsInnerOptionsInner({
    required this.id,
    this.name = '',
    this.priceUsd = 0,
    required this.limit,
    this.isDefault = false,
  });

  String id;

  String name;

  /// Minimum value: 0
  /// Maximum value: 100000
  num priceUsd;

  /// Minimum value: 1
  /// Maximum value: 10000
  int? limit;

  bool isDefault;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetMealsInnerOptionsInner &&
    other.id == id &&
    other.name == name &&
    other.priceUsd == priceUsd &&
    other.limit == limit &&
    other.isDefault == isDefault;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (priceUsd.hashCode) +
    (limit == null ? 0 : limit!.hashCode) +
    (isDefault.hashCode);

  @override
  String toString() => 'ProductSheetMealsInnerOptionsInner[id=$id, name=$name, priceUsd=$priceUsd, limit=$limit, isDefault=$isDefault]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'priceUsd'] = this.priceUsd;
    if (this.limit != null) {
      json[r'limit'] = this.limit;
    } else {
      json[r'limit'] = null;
    }
      json[r'isDefault'] = this.isDefault;
    return json;
  }

  /// Returns a new [ProductSheetMealsInnerOptionsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetMealsInnerOptionsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSheetMealsInnerOptionsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSheetMealsInnerOptionsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProductSheetMealsInnerOptionsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductSheetMealsInnerOptionsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "ProductSheetMealsInnerOptionsInner[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "ProductSheetMealsInnerOptionsInner[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'limit'), 'Required key "ProductSheetMealsInnerOptionsInner[limit]" is missing from JSON.');
        assert(json.containsKey(r'isDefault'), 'Required key "ProductSheetMealsInnerOptionsInner[isDefault]" is missing from JSON.');
        assert(json[r'isDefault'] != null, 'Required key "ProductSheetMealsInnerOptionsInner[isDefault]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetMealsInnerOptionsInner(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        priceUsd: num.parse('${json[r'priceUsd']}'),
        limit: mapValueOfType<int>(json, r'limit'),
        isDefault: mapValueOfType<bool>(json, r'isDefault')!,
      );
    }
    return null;
  }

  static List<ProductSheetMealsInnerOptionsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetMealsInnerOptionsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetMealsInnerOptionsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetMealsInnerOptionsInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetMealsInnerOptionsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetMealsInnerOptionsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetMealsInnerOptionsInner-objects as value to a dart map
  static Map<String, List<ProductSheetMealsInnerOptionsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetMealsInnerOptionsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetMealsInnerOptionsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'priceUsd',
    'limit',
    'isDefault',
  };
}

