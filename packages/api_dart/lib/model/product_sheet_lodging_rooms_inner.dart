//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetLodgingRoomsInner {
  /// Returns a new [ProductSheetLodgingRoomsInner] instance.
  ProductSheetLodgingRoomsInner({
    required this.id,
    required this.type,
    this.occupancy = 2,
    required this.quantity,
    this.priceDeltaUsd = 0,
  });

  String id;

  ProductSheetLodgingRoomsInnerTypeEnum type;

  /// Minimum value: 1
  /// Maximum value: 12
  int occupancy;

  /// Minimum value: 1
  /// Maximum value: 1000
  int? quantity;

  /// Minimum value: -1000
  /// Maximum value: 5000
  num priceDeltaUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetLodgingRoomsInner &&
    other.id == id &&
    other.type == type &&
    other.occupancy == occupancy &&
    other.quantity == quantity &&
    other.priceDeltaUsd == priceDeltaUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (occupancy.hashCode) +
    (quantity == null ? 0 : quantity!.hashCode) +
    (priceDeltaUsd.hashCode);

  @override
  String toString() => 'ProductSheetLodgingRoomsInner[id=$id, type=$type, occupancy=$occupancy, quantity=$quantity, priceDeltaUsd=$priceDeltaUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'occupancy'] = this.occupancy;
    if (this.quantity != null) {
      json[r'quantity'] = this.quantity;
    } else {
      json[r'quantity'] = null;
    }
      json[r'priceDeltaUsd'] = this.priceDeltaUsd;
    return json;
  }

  /// Returns a new [ProductSheetLodgingRoomsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetLodgingRoomsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSheetLodgingRoomsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSheetLodgingRoomsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProductSheetLodgingRoomsInner[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductSheetLodgingRoomsInner[type]" has a null value in JSON.');
        assert(json.containsKey(r'occupancy'), 'Required key "ProductSheetLodgingRoomsInner[occupancy]" is missing from JSON.');
        assert(json[r'occupancy'] != null, 'Required key "ProductSheetLodgingRoomsInner[occupancy]" has a null value in JSON.');
        assert(json.containsKey(r'quantity'), 'Required key "ProductSheetLodgingRoomsInner[quantity]" is missing from JSON.');
        assert(json.containsKey(r'priceDeltaUsd'), 'Required key "ProductSheetLodgingRoomsInner[priceDeltaUsd]" is missing from JSON.');
        assert(json[r'priceDeltaUsd'] != null, 'Required key "ProductSheetLodgingRoomsInner[priceDeltaUsd]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetLodgingRoomsInner(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductSheetLodgingRoomsInnerTypeEnum.fromJson(json[r'type'])!,
        occupancy: mapValueOfType<int>(json, r'occupancy')!,
        quantity: mapValueOfType<int>(json, r'quantity'),
        priceDeltaUsd: num.parse('${json[r'priceDeltaUsd']}'),
      );
    }
    return null;
  }

  static List<ProductSheetLodgingRoomsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetLodgingRoomsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetLodgingRoomsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetLodgingRoomsInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetLodgingRoomsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetLodgingRoomsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetLodgingRoomsInner-objects as value to a dart map
  static Map<String, List<ProductSheetLodgingRoomsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetLodgingRoomsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetLodgingRoomsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'occupancy',
    'quantity',
    'priceDeltaUsd',
  };
}


enum ProductSheetLodgingRoomsInnerTypeEnum {
  single._(r'single'),
  double_._(r'double'),
  triple._(r'triple'),
  quadruple._(r'quadruple'),
  shared._(r'shared'),
  camping._(r'camping'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetLodgingRoomsInnerTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetLodgingRoomsInnerTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetLodgingRoomsInnerTypeEnum? fromJson(dynamic value) => ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetLodgingRoomsInnerTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetLodgingRoomsInnerTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetLodgingRoomsInnerTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetLodgingRoomsInnerTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetLodgingRoomsInnerTypeEnum] to String,
/// and [decode] dynamic data back to [ProductSheetLodgingRoomsInnerTypeEnum].
class ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer {
  factory ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer() => _instance ??= const ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer._();

  const ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer._();

  String encode(ProductSheetLodgingRoomsInnerTypeEnum data) => data._value;

  /// Returns the instance of [ProductSheetLodgingRoomsInnerTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetLodgingRoomsInnerTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetLodgingRoomsInnerTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'single': return ProductSheetLodgingRoomsInnerTypeEnum.single;
        case r'double': return ProductSheetLodgingRoomsInnerTypeEnum.double_;
        case r'triple': return ProductSheetLodgingRoomsInnerTypeEnum.triple;
        case r'quadruple': return ProductSheetLodgingRoomsInnerTypeEnum.quadruple;
        case r'shared': return ProductSheetLodgingRoomsInnerTypeEnum.shared;
        case r'camping': return ProductSheetLodgingRoomsInnerTypeEnum.camping;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetLodgingRoomsInnerTypeEnumTypeTransformer? _instance;
}


