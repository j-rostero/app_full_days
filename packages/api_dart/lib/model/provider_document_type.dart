//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProviderDocumentType {
  rif._(r'rif'),
  representativeId._(r'representative_id'),
  rtn._(r'rtn'),
  commercialRegistry._(r'commercial_registry'),
  other._(r'other'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProviderDocumentType._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProviderDocumentType] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProviderDocumentType? fromJson(dynamic value) => ProviderDocumentTypeTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProviderDocumentType]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProviderDocumentType> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderDocumentType>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderDocumentType.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProviderDocumentType] to String,
/// and [decode] dynamic data back to [ProviderDocumentType].
class ProviderDocumentTypeTypeTransformer {
  factory ProviderDocumentTypeTypeTransformer() => _instance ??= const ProviderDocumentTypeTypeTransformer._();

  const ProviderDocumentTypeTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProviderDocumentType data) => data._value;

  /// Returns the instance of [ProviderDocumentType] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProviderDocumentType? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProviderDocumentType) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'rif': return ProviderDocumentType.rif;
        case r'representative_id': return ProviderDocumentType.representativeId;
        case r'rtn': return ProviderDocumentType.rtn;
        case r'commercial_registry': return ProviderDocumentType.commercialRegistry;
        case r'other': return ProviderDocumentType.other;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProviderDocumentTypeTypeTransformer? _instance;
}

