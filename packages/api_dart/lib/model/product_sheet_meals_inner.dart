//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetMealsInner {
  /// Returns a new [ProductSheetMealsInner] instance.
  ProductSheetMealsInner({
    required this.id,
    this.day = 1,
    required this.moment,
    required this.mode,
    this.description = '',
    this.options = const [],
    this.picksPerPassenger = 1,
    this.priceUsd = 0,
  });

  String id;

  /// Minimum value: 1
  /// Maximum value: 30
  int day;

  ProductSheetMealsInnerMomentEnum moment;

  ProductSheetMealsInnerModeEnum mode;

  String description;

  List<ProductSheetMealsInnerOptionsInner> options;

  /// Minimum value: 1
  /// Maximum value: 5
  int picksPerPassenger;

  /// Minimum value: 0
  /// Maximum value: 100000
  num priceUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetMealsInner &&
    other.id == id &&
    other.day == day &&
    other.moment == moment &&
    other.mode == mode &&
    other.description == description &&
    _deepEquality.equals(other.options, options) &&
    other.picksPerPassenger == picksPerPassenger &&
    other.priceUsd == priceUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (day.hashCode) +
    (moment.hashCode) +
    (mode.hashCode) +
    (description.hashCode) +
    (options.hashCode) +
    (picksPerPassenger.hashCode) +
    (priceUsd.hashCode);

  @override
  String toString() => 'ProductSheetMealsInner[id=$id, day=$day, moment=$moment, mode=$mode, description=$description, options=$options, picksPerPassenger=$picksPerPassenger, priceUsd=$priceUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'day'] = this.day;
      json[r'moment'] = this.moment;
      json[r'mode'] = this.mode;
      json[r'description'] = this.description;
      json[r'options'] = this.options;
      json[r'picksPerPassenger'] = this.picksPerPassenger;
      json[r'priceUsd'] = this.priceUsd;
    return json;
  }

  /// Returns a new [ProductSheetMealsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetMealsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSheetMealsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSheetMealsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'day'), 'Required key "ProductSheetMealsInner[day]" is missing from JSON.');
        assert(json[r'day'] != null, 'Required key "ProductSheetMealsInner[day]" has a null value in JSON.');
        assert(json.containsKey(r'moment'), 'Required key "ProductSheetMealsInner[moment]" is missing from JSON.');
        assert(json[r'moment'] != null, 'Required key "ProductSheetMealsInner[moment]" has a null value in JSON.');
        assert(json.containsKey(r'mode'), 'Required key "ProductSheetMealsInner[mode]" is missing from JSON.');
        assert(json[r'mode'] != null, 'Required key "ProductSheetMealsInner[mode]" has a null value in JSON.');
        assert(json.containsKey(r'description'), 'Required key "ProductSheetMealsInner[description]" is missing from JSON.');
        assert(json[r'description'] != null, 'Required key "ProductSheetMealsInner[description]" has a null value in JSON.');
        assert(json.containsKey(r'options'), 'Required key "ProductSheetMealsInner[options]" is missing from JSON.');
        assert(json[r'options'] != null, 'Required key "ProductSheetMealsInner[options]" has a null value in JSON.');
        assert(json.containsKey(r'picksPerPassenger'), 'Required key "ProductSheetMealsInner[picksPerPassenger]" is missing from JSON.');
        assert(json[r'picksPerPassenger'] != null, 'Required key "ProductSheetMealsInner[picksPerPassenger]" has a null value in JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "ProductSheetMealsInner[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "ProductSheetMealsInner[priceUsd]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetMealsInner(
        id: mapValueOfType<String>(json, r'id')!,
        day: mapValueOfType<int>(json, r'day')!,
        moment: ProductSheetMealsInnerMomentEnum.fromJson(json[r'moment'])!,
        mode: ProductSheetMealsInnerModeEnum.fromJson(json[r'mode'])!,
        description: mapValueOfType<String>(json, r'description')!,
        options: ProductSheetMealsInnerOptionsInner.listFromJson(json[r'options']),
        picksPerPassenger: mapValueOfType<int>(json, r'picksPerPassenger')!,
        priceUsd: num.parse('${json[r'priceUsd']}'),
      );
    }
    return null;
  }

  static List<ProductSheetMealsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetMealsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetMealsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetMealsInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetMealsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetMealsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetMealsInner-objects as value to a dart map
  static Map<String, List<ProductSheetMealsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetMealsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetMealsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'day',
    'moment',
    'mode',
    'description',
    'options',
    'picksPerPassenger',
    'priceUsd',
  };
}


enum ProductSheetMealsInnerMomentEnum {
  breakfast._(r'breakfast'),
  lunch._(r'lunch'),
  dinner._(r'dinner'),
  snack._(r'snack'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetMealsInnerMomentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetMealsInnerMomentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetMealsInnerMomentEnum? fromJson(dynamic value) => ProductSheetMealsInnerMomentEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetMealsInnerMomentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetMealsInnerMomentEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetMealsInnerMomentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetMealsInnerMomentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetMealsInnerMomentEnum] to String,
/// and [decode] dynamic data back to [ProductSheetMealsInnerMomentEnum].
class ProductSheetMealsInnerMomentEnumTypeTransformer {
  factory ProductSheetMealsInnerMomentEnumTypeTransformer() => _instance ??= const ProductSheetMealsInnerMomentEnumTypeTransformer._();

  const ProductSheetMealsInnerMomentEnumTypeTransformer._();

  String encode(ProductSheetMealsInnerMomentEnum data) => data._value;

  /// Returns the instance of [ProductSheetMealsInnerMomentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetMealsInnerMomentEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetMealsInnerMomentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'breakfast': return ProductSheetMealsInnerMomentEnum.breakfast;
        case r'lunch': return ProductSheetMealsInnerMomentEnum.lunch;
        case r'dinner': return ProductSheetMealsInnerMomentEnum.dinner;
        case r'snack': return ProductSheetMealsInnerMomentEnum.snack;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetMealsInnerMomentEnumTypeTransformer? _instance;
}



enum ProductSheetMealsInnerModeEnum {
  fixed._(r'fixed'),
  choice._(r'choice'),
  optional._(r'optional'),
  notIncluded._(r'not_included'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetMealsInnerModeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetMealsInnerModeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetMealsInnerModeEnum? fromJson(dynamic value) => ProductSheetMealsInnerModeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetMealsInnerModeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetMealsInnerModeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetMealsInnerModeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetMealsInnerModeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetMealsInnerModeEnum] to String,
/// and [decode] dynamic data back to [ProductSheetMealsInnerModeEnum].
class ProductSheetMealsInnerModeEnumTypeTransformer {
  factory ProductSheetMealsInnerModeEnumTypeTransformer() => _instance ??= const ProductSheetMealsInnerModeEnumTypeTransformer._();

  const ProductSheetMealsInnerModeEnumTypeTransformer._();

  String encode(ProductSheetMealsInnerModeEnum data) => data._value;

  /// Returns the instance of [ProductSheetMealsInnerModeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetMealsInnerModeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetMealsInnerModeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'fixed': return ProductSheetMealsInnerModeEnum.fixed;
        case r'choice': return ProductSheetMealsInnerModeEnum.choice;
        case r'optional': return ProductSheetMealsInnerModeEnum.optional;
        case r'not_included': return ProductSheetMealsInnerModeEnum.notIncluded;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetMealsInnerModeEnumTypeTransformer? _instance;
}


