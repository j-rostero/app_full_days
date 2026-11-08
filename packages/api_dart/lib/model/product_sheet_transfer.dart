//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetTransfer {
  /// Returns a new [ProductSheetTransfer] instance.
  ProductSheetTransfer({
    required this.vehicle,
    this.notes = '',
    this.boardingPoints = const [],
  });

  ProductSheetTransferVehicleEnum? vehicle;

  String notes;

  List<ProductSheetTransferBoardingPointsInner> boardingPoints;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetTransfer &&
    other.vehicle == vehicle &&
    other.notes == notes &&
    _deepEquality.equals(other.boardingPoints, boardingPoints);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (vehicle == null ? 0 : vehicle!.hashCode) +
    (notes.hashCode) +
    (boardingPoints.hashCode);

  @override
  String toString() => 'ProductSheetTransfer[vehicle=$vehicle, notes=$notes, boardingPoints=$boardingPoints]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.vehicle != null) {
      json[r'vehicle'] = this.vehicle;
    } else {
      json[r'vehicle'] = null;
    }
      json[r'notes'] = this.notes;
      json[r'boardingPoints'] = this.boardingPoints;
    return json;
  }

  /// Returns a new [ProductSheetTransfer] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetTransfer? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'vehicle'), 'Required key "ProductSheetTransfer[vehicle]" is missing from JSON.');
        assert(json.containsKey(r'notes'), 'Required key "ProductSheetTransfer[notes]" is missing from JSON.');
        assert(json[r'notes'] != null, 'Required key "ProductSheetTransfer[notes]" has a null value in JSON.');
        assert(json.containsKey(r'boardingPoints'), 'Required key "ProductSheetTransfer[boardingPoints]" is missing from JSON.');
        assert(json[r'boardingPoints'] != null, 'Required key "ProductSheetTransfer[boardingPoints]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetTransfer(
        vehicle: ProductSheetTransferVehicleEnum.fromJson(json[r'vehicle']),
        notes: mapValueOfType<String>(json, r'notes')!,
        boardingPoints: ProductSheetTransferBoardingPointsInner.listFromJson(json[r'boardingPoints']),
      );
    }
    return null;
  }

  static List<ProductSheetTransfer> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetTransfer>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetTransfer.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetTransfer> mapFromJson(dynamic json) {
    final map = <String, ProductSheetTransfer>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetTransfer.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetTransfer-objects as value to a dart map
  static Map<String, List<ProductSheetTransfer>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetTransfer>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetTransfer.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'vehicle',
    'notes',
    'boardingPoints',
  };
}


enum ProductSheetTransferVehicleEnum {
  bus._(r'bus'),
  minibus._(r'minibus'),
  van._(r'van'),
  car4x4._(r'car_4x4'),
  boat._(r'boat'),
  plane._(r'plane'),
  none._(r'none'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetTransferVehicleEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetTransferVehicleEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetTransferVehicleEnum? fromJson(dynamic value) => ProductSheetTransferVehicleEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetTransferVehicleEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetTransferVehicleEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetTransferVehicleEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetTransferVehicleEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetTransferVehicleEnum] to String,
/// and [decode] dynamic data back to [ProductSheetTransferVehicleEnum].
class ProductSheetTransferVehicleEnumTypeTransformer {
  factory ProductSheetTransferVehicleEnumTypeTransformer() => _instance ??= const ProductSheetTransferVehicleEnumTypeTransformer._();

  const ProductSheetTransferVehicleEnumTypeTransformer._();

  String encode(ProductSheetTransferVehicleEnum data) => data._value;

  /// Returns the instance of [ProductSheetTransferVehicleEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetTransferVehicleEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetTransferVehicleEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'bus': return ProductSheetTransferVehicleEnum.bus;
        case r'minibus': return ProductSheetTransferVehicleEnum.minibus;
        case r'van': return ProductSheetTransferVehicleEnum.van;
        case r'car_4x4': return ProductSheetTransferVehicleEnum.car4x4;
        case r'boat': return ProductSheetTransferVehicleEnum.boat;
        case r'plane': return ProductSheetTransferVehicleEnum.plane;
        case r'none': return ProductSheetTransferVehicleEnum.none;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetTransferVehicleEnumTypeTransformer? _instance;
}


