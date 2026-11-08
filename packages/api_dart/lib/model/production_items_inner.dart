//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionItemsInner {
  /// Returns a new [ProductionItemsInner] instance.
  ProductionItemsInner({
    required this.itemId,
    required this.name,
    required this.modality,
    required this.units,
  });

  String itemId;

  String name;

  String modality;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int units;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionItemsInner &&
    other.itemId == itemId &&
    other.name == name &&
    other.modality == modality &&
    other.units == units;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (itemId.hashCode) +
    (name.hashCode) +
    (modality.hashCode) +
    (units.hashCode);

  @override
  String toString() => 'ProductionItemsInner[itemId=$itemId, name=$name, modality=$modality, units=$units]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'itemId'] = this.itemId;
      json[r'name'] = this.name;
      json[r'modality'] = this.modality;
      json[r'units'] = this.units;
    return json;
  }

  /// Returns a new [ProductionItemsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionItemsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'itemId'), 'Required key "ProductionItemsInner[itemId]" is missing from JSON.');
        assert(json[r'itemId'] != null, 'Required key "ProductionItemsInner[itemId]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProductionItemsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductionItemsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'modality'), 'Required key "ProductionItemsInner[modality]" is missing from JSON.');
        assert(json[r'modality'] != null, 'Required key "ProductionItemsInner[modality]" has a null value in JSON.');
        assert(json.containsKey(r'units'), 'Required key "ProductionItemsInner[units]" is missing from JSON.');
        assert(json[r'units'] != null, 'Required key "ProductionItemsInner[units]" has a null value in JSON.');
        return true;
      }());

      return ProductionItemsInner(
        itemId: mapValueOfType<String>(json, r'itemId')!,
        name: mapValueOfType<String>(json, r'name')!,
        modality: mapValueOfType<String>(json, r'modality')!,
        units: mapValueOfType<int>(json, r'units')!,
      );
    }
    return null;
  }

  static List<ProductionItemsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionItemsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionItemsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionItemsInner> mapFromJson(dynamic json) {
    final map = <String, ProductionItemsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionItemsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionItemsInner-objects as value to a dart map
  static Map<String, List<ProductionItemsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionItemsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionItemsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'itemId',
    'name',
    'modality',
    'units',
  };
}

