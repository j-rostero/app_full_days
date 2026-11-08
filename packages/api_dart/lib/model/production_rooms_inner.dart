//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionRoomsInner {
  /// Returns a new [ProductionRoomsInner] instance.
  ProductionRoomsInner({
    required this.type,
    required this.label,
    required this.count,
  });

  String type;

  String label;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int count;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionRoomsInner &&
    other.type == type &&
    other.label == label &&
    other.count == count;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (label.hashCode) +
    (count.hashCode);

  @override
  String toString() => 'ProductionRoomsInner[type=$type, label=$label, count=$count]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
      json[r'label'] = this.label;
      json[r'count'] = this.count;
    return json;
  }

  /// Returns a new [ProductionRoomsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionRoomsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'type'), 'Required key "ProductionRoomsInner[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductionRoomsInner[type]" has a null value in JSON.');
        assert(json.containsKey(r'label'), 'Required key "ProductionRoomsInner[label]" is missing from JSON.');
        assert(json[r'label'] != null, 'Required key "ProductionRoomsInner[label]" has a null value in JSON.');
        assert(json.containsKey(r'count'), 'Required key "ProductionRoomsInner[count]" is missing from JSON.');
        assert(json[r'count'] != null, 'Required key "ProductionRoomsInner[count]" has a null value in JSON.');
        return true;
      }());

      return ProductionRoomsInner(
        type: mapValueOfType<String>(json, r'type')!,
        label: mapValueOfType<String>(json, r'label')!,
        count: mapValueOfType<int>(json, r'count')!,
      );
    }
    return null;
  }

  static List<ProductionRoomsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionRoomsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionRoomsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionRoomsInner> mapFromJson(dynamic json) {
    final map = <String, ProductionRoomsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionRoomsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionRoomsInner-objects as value to a dart map
  static Map<String, List<ProductionRoomsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionRoomsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionRoomsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'label',
    'count',
  };
}

