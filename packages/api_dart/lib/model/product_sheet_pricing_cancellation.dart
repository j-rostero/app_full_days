//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetPricingCancellation {
  /// Returns a new [ProductSheetPricingCancellation] instance.
  ProductSheetPricingCancellation({
    required this.template,
    required this.text,
  });

  ProductSheetPricingCancellationTemplateEnum? template;

  String? text;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetPricingCancellation &&
    other.template == template &&
    other.text == text;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (template == null ? 0 : template!.hashCode) +
    (text == null ? 0 : text!.hashCode);

  @override
  String toString() => 'ProductSheetPricingCancellation[template=$template, text=$text]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.template != null) {
      json[r'template'] = this.template;
    } else {
      json[r'template'] = null;
    }
    if (this.text != null) {
      json[r'text'] = this.text;
    } else {
      json[r'text'] = null;
    }
    return json;
  }

  /// Returns a new [ProductSheetPricingCancellation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetPricingCancellation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'template'), 'Required key "ProductSheetPricingCancellation[template]" is missing from JSON.');
        assert(json.containsKey(r'text'), 'Required key "ProductSheetPricingCancellation[text]" is missing from JSON.');
        return true;
      }());

      return ProductSheetPricingCancellation(
        template: ProductSheetPricingCancellationTemplateEnum.fromJson(json[r'template']),
        text: mapValueOfType<String>(json, r'text'),
      );
    }
    return null;
  }

  static List<ProductSheetPricingCancellation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetPricingCancellation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetPricingCancellation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetPricingCancellation> mapFromJson(dynamic json) {
    final map = <String, ProductSheetPricingCancellation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetPricingCancellation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetPricingCancellation-objects as value to a dart map
  static Map<String, List<ProductSheetPricingCancellation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetPricingCancellation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetPricingCancellation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'template',
    'text',
  };
}


enum ProductSheetPricingCancellationTemplateEnum {
  flexible._(r'flexible'),
  moderate._(r'moderate'),
  strict._(r'strict'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetPricingCancellationTemplateEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetPricingCancellationTemplateEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetPricingCancellationTemplateEnum? fromJson(dynamic value) => ProductSheetPricingCancellationTemplateEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetPricingCancellationTemplateEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetPricingCancellationTemplateEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetPricingCancellationTemplateEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetPricingCancellationTemplateEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetPricingCancellationTemplateEnum] to String,
/// and [decode] dynamic data back to [ProductSheetPricingCancellationTemplateEnum].
class ProductSheetPricingCancellationTemplateEnumTypeTransformer {
  factory ProductSheetPricingCancellationTemplateEnumTypeTransformer() => _instance ??= const ProductSheetPricingCancellationTemplateEnumTypeTransformer._();

  const ProductSheetPricingCancellationTemplateEnumTypeTransformer._();

  String encode(ProductSheetPricingCancellationTemplateEnum data) => data._value;

  /// Returns the instance of [ProductSheetPricingCancellationTemplateEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetPricingCancellationTemplateEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetPricingCancellationTemplateEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'flexible': return ProductSheetPricingCancellationTemplateEnum.flexible;
        case r'moderate': return ProductSheetPricingCancellationTemplateEnum.moderate;
        case r'strict': return ProductSheetPricingCancellationTemplateEnum.strict;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetPricingCancellationTemplateEnumTypeTransformer? _instance;
}


