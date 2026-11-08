//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetPricingFares {
  /// Returns a new [ProductSheetPricingFares] instance.
  ProductSheetPricingFares({
    this.adult = 0,
    required this.child,
    required this.senior,
    required this.infant,
  });

  /// Minimum value: 0
  /// Maximum value: 100000
  num adult;

  /// Minimum value: 0
  /// Maximum value: 100000
  num? child;

  /// Minimum value: 0
  /// Maximum value: 100000
  num? senior;

  /// Minimum value: 0
  /// Maximum value: 100000
  num? infant;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetPricingFares &&
    other.adult == adult &&
    other.child == child &&
    other.senior == senior &&
    other.infant == infant;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adult.hashCode) +
    (child == null ? 0 : child!.hashCode) +
    (senior == null ? 0 : senior!.hashCode) +
    (infant == null ? 0 : infant!.hashCode);

  @override
  String toString() => 'ProductSheetPricingFares[adult=$adult, child=$child, senior=$senior, infant=$infant]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'adult'] = this.adult;
    if (this.child != null) {
      json[r'child'] = this.child;
    } else {
      json[r'child'] = null;
    }
    if (this.senior != null) {
      json[r'senior'] = this.senior;
    } else {
      json[r'senior'] = null;
    }
    if (this.infant != null) {
      json[r'infant'] = this.infant;
    } else {
      json[r'infant'] = null;
    }
    return json;
  }

  /// Returns a new [ProductSheetPricingFares] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetPricingFares? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'adult'), 'Required key "ProductSheetPricingFares[adult]" is missing from JSON.');
        assert(json[r'adult'] != null, 'Required key "ProductSheetPricingFares[adult]" has a null value in JSON.');
        assert(json.containsKey(r'child'), 'Required key "ProductSheetPricingFares[child]" is missing from JSON.');
        assert(json.containsKey(r'senior'), 'Required key "ProductSheetPricingFares[senior]" is missing from JSON.');
        assert(json.containsKey(r'infant'), 'Required key "ProductSheetPricingFares[infant]" is missing from JSON.');
        return true;
      }());

      return ProductSheetPricingFares(
        adult: num.parse('${json[r'adult']}'),
        child: json[r'child'] == null
            ? null
            : num.parse('${json[r'child']}'),
        senior: json[r'senior'] == null
            ? null
            : num.parse('${json[r'senior']}'),
        infant: json[r'infant'] == null
            ? null
            : num.parse('${json[r'infant']}'),
      );
    }
    return null;
  }

  static List<ProductSheetPricingFares> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetPricingFares>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetPricingFares.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetPricingFares> mapFromJson(dynamic json) {
    final map = <String, ProductSheetPricingFares>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetPricingFares.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetPricingFares-objects as value to a dart map
  static Map<String, List<ProductSheetPricingFares>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetPricingFares>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetPricingFares.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'adult',
    'child',
    'senior',
    'infant',
  };
}

