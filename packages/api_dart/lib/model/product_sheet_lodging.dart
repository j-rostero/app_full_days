//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetLodging {
  /// Returns a new [ProductSheetLodging] instance.
  ProductSheetLodging({
    this.name = '',
    required this.regime,
    this.rooms = const [],
  });

  String name;

  ProductSheetLodgingRegimeEnum? regime;

  List<ProductSheetLodgingRoomsInner> rooms;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetLodging &&
    other.name == name &&
    other.regime == regime &&
    _deepEquality.equals(other.rooms, rooms);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (regime == null ? 0 : regime!.hashCode) +
    (rooms.hashCode);

  @override
  String toString() => 'ProductSheetLodging[name=$name, regime=$regime, rooms=$rooms]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
    if (this.regime != null) {
      json[r'regime'] = this.regime;
    } else {
      json[r'regime'] = null;
    }
      json[r'rooms'] = this.rooms;
    return json;
  }

  /// Returns a new [ProductSheetLodging] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetLodging? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "ProductSheetLodging[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductSheetLodging[name]" has a null value in JSON.');
        assert(json.containsKey(r'regime'), 'Required key "ProductSheetLodging[regime]" is missing from JSON.');
        assert(json.containsKey(r'rooms'), 'Required key "ProductSheetLodging[rooms]" is missing from JSON.');
        assert(json[r'rooms'] != null, 'Required key "ProductSheetLodging[rooms]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetLodging(
        name: mapValueOfType<String>(json, r'name')!,
        regime: ProductSheetLodgingRegimeEnum.fromJson(json[r'regime']),
        rooms: ProductSheetLodgingRoomsInner.listFromJson(json[r'rooms']),
      );
    }
    return null;
  }

  static List<ProductSheetLodging> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetLodging>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetLodging.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetLodging> mapFromJson(dynamic json) {
    final map = <String, ProductSheetLodging>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetLodging.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetLodging-objects as value to a dart map
  static Map<String, List<ProductSheetLodging>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetLodging>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetLodging.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'regime',
    'rooms',
  };
}


enum ProductSheetLodgingRegimeEnum {
  roomOnly._(r'room_only'),
  breakfast._(r'breakfast'),
  halfBoard._(r'half_board'),
  fullBoard._(r'full_board'),
  allInclusive._(r'all_inclusive'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetLodgingRegimeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetLodgingRegimeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetLodgingRegimeEnum? fromJson(dynamic value) => ProductSheetLodgingRegimeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetLodgingRegimeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetLodgingRegimeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetLodgingRegimeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetLodgingRegimeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetLodgingRegimeEnum] to String,
/// and [decode] dynamic data back to [ProductSheetLodgingRegimeEnum].
class ProductSheetLodgingRegimeEnumTypeTransformer {
  factory ProductSheetLodgingRegimeEnumTypeTransformer() => _instance ??= const ProductSheetLodgingRegimeEnumTypeTransformer._();

  const ProductSheetLodgingRegimeEnumTypeTransformer._();

  String encode(ProductSheetLodgingRegimeEnum data) => data._value;

  /// Returns the instance of [ProductSheetLodgingRegimeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetLodgingRegimeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetLodgingRegimeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'room_only': return ProductSheetLodgingRegimeEnum.roomOnly;
        case r'breakfast': return ProductSheetLodgingRegimeEnum.breakfast;
        case r'half_board': return ProductSheetLodgingRegimeEnum.halfBoard;
        case r'full_board': return ProductSheetLodgingRegimeEnum.fullBoard;
        case r'all_inclusive': return ProductSheetLodgingRegimeEnum.allInclusive;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetLodgingRegimeEnumTypeTransformer? _instance;
}


