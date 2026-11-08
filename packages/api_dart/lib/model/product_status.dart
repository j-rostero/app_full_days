//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProductStatus {
  draft._(r'draft'),
  inReview._(r'in_review'),
  published._(r'published'),
  paused._(r'paused'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductStatus._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductStatus] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductStatus? fromJson(dynamic value) => ProductStatusTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductStatus]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductStatus] to String,
/// and [decode] dynamic data back to [ProductStatus].
class ProductStatusTypeTransformer {
  factory ProductStatusTypeTransformer() => _instance ??= const ProductStatusTypeTransformer._();

  const ProductStatusTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProductStatus data) => data._value;

  /// Returns the instance of [ProductStatus] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductStatus) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'draft': return ProductStatus.draft;
        case r'in_review': return ProductStatus.inReview;
        case r'published': return ProductStatus.published;
        case r'paused': return ProductStatus.paused;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductStatusTypeTransformer? _instance;
}

