//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionMealsInnerOptionsInner {
  /// Returns a new [ProductionMealsInnerOptionsInner] instance.
  ProductionMealsInnerOptionsInner({
    required this.name,
    required this.count,
    required this.optionId,
  });

  String name;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int count;

  String optionId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionMealsInnerOptionsInner &&
    other.name == name &&
    other.count == count &&
    other.optionId == optionId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (count.hashCode) +
    (optionId.hashCode);

  @override
  String toString() => 'ProductionMealsInnerOptionsInner[name=$name, count=$count, optionId=$optionId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'count'] = this.count;
      json[r'optionId'] = this.optionId;
    return json;
  }

  /// Returns a new [ProductionMealsInnerOptionsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionMealsInnerOptionsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "ProductionMealsInnerOptionsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductionMealsInnerOptionsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'count'), 'Required key "ProductionMealsInnerOptionsInner[count]" is missing from JSON.');
        assert(json[r'count'] != null, 'Required key "ProductionMealsInnerOptionsInner[count]" has a null value in JSON.');
        assert(json.containsKey(r'optionId'), 'Required key "ProductionMealsInnerOptionsInner[optionId]" is missing from JSON.');
        assert(json[r'optionId'] != null, 'Required key "ProductionMealsInnerOptionsInner[optionId]" has a null value in JSON.');
        return true;
      }());

      return ProductionMealsInnerOptionsInner(
        name: mapValueOfType<String>(json, r'name')!,
        count: mapValueOfType<int>(json, r'count')!,
        optionId: mapValueOfType<String>(json, r'optionId')!,
      );
    }
    return null;
  }

  static List<ProductionMealsInnerOptionsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionMealsInnerOptionsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionMealsInnerOptionsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionMealsInnerOptionsInner> mapFromJson(dynamic json) {
    final map = <String, ProductionMealsInnerOptionsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionMealsInnerOptionsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionMealsInnerOptionsInner-objects as value to a dart map
  static Map<String, List<ProductionMealsInnerOptionsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionMealsInnerOptionsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionMealsInnerOptionsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'count',
    'optionId',
  };
}

