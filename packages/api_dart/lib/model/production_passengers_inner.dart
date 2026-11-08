//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionPassengersInner {
  /// Returns a new [ProductionPassengersInner] instance.
  ProductionPassengersInner({
    required this.type,
    required this.label,
    required this.count,
  });

  ProductionPassengersInnerTypeEnum type;

  String label;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int count;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionPassengersInner &&
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
  String toString() => 'ProductionPassengersInner[type=$type, label=$label, count=$count]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
      json[r'label'] = this.label;
      json[r'count'] = this.count;
    return json;
  }

  /// Returns a new [ProductionPassengersInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionPassengersInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'type'), 'Required key "ProductionPassengersInner[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductionPassengersInner[type]" has a null value in JSON.');
        assert(json.containsKey(r'label'), 'Required key "ProductionPassengersInner[label]" is missing from JSON.');
        assert(json[r'label'] != null, 'Required key "ProductionPassengersInner[label]" has a null value in JSON.');
        assert(json.containsKey(r'count'), 'Required key "ProductionPassengersInner[count]" is missing from JSON.');
        assert(json[r'count'] != null, 'Required key "ProductionPassengersInner[count]" has a null value in JSON.');
        return true;
      }());

      return ProductionPassengersInner(
        type: ProductionPassengersInnerTypeEnum.fromJson(json[r'type'])!,
        label: mapValueOfType<String>(json, r'label')!,
        count: mapValueOfType<int>(json, r'count')!,
      );
    }
    return null;
  }

  static List<ProductionPassengersInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionPassengersInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionPassengersInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionPassengersInner> mapFromJson(dynamic json) {
    final map = <String, ProductionPassengersInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionPassengersInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionPassengersInner-objects as value to a dart map
  static Map<String, List<ProductionPassengersInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionPassengersInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionPassengersInner.listFromJson(entry.value, growable: growable,);
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


enum ProductionPassengersInnerTypeEnum {
  adult._(r'adult'),
  child._(r'child'),
  senior._(r'senior'),
  infant._(r'infant'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductionPassengersInnerTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductionPassengersInnerTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductionPassengersInnerTypeEnum? fromJson(dynamic value) => ProductionPassengersInnerTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductionPassengersInnerTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductionPassengersInnerTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionPassengersInnerTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionPassengersInnerTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductionPassengersInnerTypeEnum] to String,
/// and [decode] dynamic data back to [ProductionPassengersInnerTypeEnum].
class ProductionPassengersInnerTypeEnumTypeTransformer {
  factory ProductionPassengersInnerTypeEnumTypeTransformer() => _instance ??= const ProductionPassengersInnerTypeEnumTypeTransformer._();

  const ProductionPassengersInnerTypeEnumTypeTransformer._();

  String encode(ProductionPassengersInnerTypeEnum data) => data._value;

  /// Returns the instance of [ProductionPassengersInnerTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductionPassengersInnerTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductionPassengersInnerTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'adult': return ProductionPassengersInnerTypeEnum.adult;
        case r'child': return ProductionPassengersInnerTypeEnum.child;
        case r'senior': return ProductionPassengersInnerTypeEnum.senior;
        case r'infant': return ProductionPassengersInnerTypeEnum.infant;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductionPassengersInnerTypeEnumTypeTransformer? _instance;
}


