//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetItemsInner {
  /// Returns a new [ProductSheetItemsInner] instance.
  ProductSheetItemsInner({
    required this.id,
    required this.type,
    this.name = '',
    required this.modality,
    this.priceUsd = 0,
    required this.payment,
  });

  String id;

  ProductSheetItemsInnerTypeEnum type;

  String name;

  ProductSheetItemsInnerModalityEnum modality;

  /// Minimum value: 0
  /// Maximum value: 100000
  num priceUsd;

  ProductSheetItemsInnerPaymentEnum? payment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetItemsInner &&
    other.id == id &&
    other.type == type &&
    other.name == name &&
    other.modality == modality &&
    other.priceUsd == priceUsd &&
    other.payment == payment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (name.hashCode) +
    (modality.hashCode) +
    (priceUsd.hashCode) +
    (payment == null ? 0 : payment!.hashCode);

  @override
  String toString() => 'ProductSheetItemsInner[id=$id, type=$type, name=$name, modality=$modality, priceUsd=$priceUsd, payment=$payment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'name'] = this.name;
      json[r'modality'] = this.modality;
      json[r'priceUsd'] = this.priceUsd;
    if (this.payment != null) {
      json[r'payment'] = this.payment;
    } else {
      json[r'payment'] = null;
    }
    return json;
  }

  /// Returns a new [ProductSheetItemsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetItemsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSheetItemsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSheetItemsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProductSheetItemsInner[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductSheetItemsInner[type]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProductSheetItemsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductSheetItemsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'modality'), 'Required key "ProductSheetItemsInner[modality]" is missing from JSON.');
        assert(json[r'modality'] != null, 'Required key "ProductSheetItemsInner[modality]" has a null value in JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "ProductSheetItemsInner[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "ProductSheetItemsInner[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'payment'), 'Required key "ProductSheetItemsInner[payment]" is missing from JSON.');
        return true;
      }());

      return ProductSheetItemsInner(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductSheetItemsInnerTypeEnum.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name')!,
        modality: ProductSheetItemsInnerModalityEnum.fromJson(json[r'modality'])!,
        priceUsd: num.parse('${json[r'priceUsd']}'),
        payment: ProductSheetItemsInnerPaymentEnum.fromJson(json[r'payment']),
      );
    }
    return null;
  }

  static List<ProductSheetItemsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetItemsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetItemsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetItemsInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetItemsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetItemsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetItemsInner-objects as value to a dart map
  static Map<String, List<ProductSheetItemsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetItemsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetItemsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'name',
    'modality',
    'priceUsd',
    'payment',
  };
}


enum ProductSheetItemsInnerTypeEnum {
  hydration._(r'hydration'),
  shade._(r'shade'),
  access._(r'access'),
  service._(r'service'),
  activity._(r'activity'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetItemsInnerTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetItemsInnerTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetItemsInnerTypeEnum? fromJson(dynamic value) => ProductSheetItemsInnerTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetItemsInnerTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetItemsInnerTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetItemsInnerTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetItemsInnerTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetItemsInnerTypeEnum] to String,
/// and [decode] dynamic data back to [ProductSheetItemsInnerTypeEnum].
class ProductSheetItemsInnerTypeEnumTypeTransformer {
  factory ProductSheetItemsInnerTypeEnumTypeTransformer() => _instance ??= const ProductSheetItemsInnerTypeEnumTypeTransformer._();

  const ProductSheetItemsInnerTypeEnumTypeTransformer._();

  String encode(ProductSheetItemsInnerTypeEnum data) => data._value;

  /// Returns the instance of [ProductSheetItemsInnerTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetItemsInnerTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetItemsInnerTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'hydration': return ProductSheetItemsInnerTypeEnum.hydration;
        case r'shade': return ProductSheetItemsInnerTypeEnum.shade;
        case r'access': return ProductSheetItemsInnerTypeEnum.access;
        case r'service': return ProductSheetItemsInnerTypeEnum.service;
        case r'activity': return ProductSheetItemsInnerTypeEnum.activity;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetItemsInnerTypeEnumTypeTransformer? _instance;
}



enum ProductSheetItemsInnerModalityEnum {
  included._(r'included'),
  optional._(r'optional'),
  payAtDestination._(r'pay_at_destination'),
  notIncluded._(r'not_included'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetItemsInnerModalityEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetItemsInnerModalityEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetItemsInnerModalityEnum? fromJson(dynamic value) => ProductSheetItemsInnerModalityEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetItemsInnerModalityEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetItemsInnerModalityEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetItemsInnerModalityEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetItemsInnerModalityEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetItemsInnerModalityEnum] to String,
/// and [decode] dynamic data back to [ProductSheetItemsInnerModalityEnum].
class ProductSheetItemsInnerModalityEnumTypeTransformer {
  factory ProductSheetItemsInnerModalityEnumTypeTransformer() => _instance ??= const ProductSheetItemsInnerModalityEnumTypeTransformer._();

  const ProductSheetItemsInnerModalityEnumTypeTransformer._();

  String encode(ProductSheetItemsInnerModalityEnum data) => data._value;

  /// Returns the instance of [ProductSheetItemsInnerModalityEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetItemsInnerModalityEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetItemsInnerModalityEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'included': return ProductSheetItemsInnerModalityEnum.included;
        case r'optional': return ProductSheetItemsInnerModalityEnum.optional;
        case r'pay_at_destination': return ProductSheetItemsInnerModalityEnum.payAtDestination;
        case r'not_included': return ProductSheetItemsInnerModalityEnum.notIncluded;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetItemsInnerModalityEnumTypeTransformer? _instance;
}



enum ProductSheetItemsInnerPaymentEnum {
  cashUsd._(r'cash_usd'),
  cashBs._(r'cash_bs'),
  mobilePayment._(r'mobile_payment'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetItemsInnerPaymentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetItemsInnerPaymentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetItemsInnerPaymentEnum? fromJson(dynamic value) => ProductSheetItemsInnerPaymentEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetItemsInnerPaymentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetItemsInnerPaymentEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetItemsInnerPaymentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetItemsInnerPaymentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetItemsInnerPaymentEnum] to String,
/// and [decode] dynamic data back to [ProductSheetItemsInnerPaymentEnum].
class ProductSheetItemsInnerPaymentEnumTypeTransformer {
  factory ProductSheetItemsInnerPaymentEnumTypeTransformer() => _instance ??= const ProductSheetItemsInnerPaymentEnumTypeTransformer._();

  const ProductSheetItemsInnerPaymentEnumTypeTransformer._();

  String encode(ProductSheetItemsInnerPaymentEnum data) => data._value;

  /// Returns the instance of [ProductSheetItemsInnerPaymentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetItemsInnerPaymentEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetItemsInnerPaymentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'cash_usd': return ProductSheetItemsInnerPaymentEnum.cashUsd;
        case r'cash_bs': return ProductSheetItemsInnerPaymentEnum.cashBs;
        case r'mobile_payment': return ProductSheetItemsInnerPaymentEnum.mobilePayment;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetItemsInnerPaymentEnumTypeTransformer? _instance;
}


