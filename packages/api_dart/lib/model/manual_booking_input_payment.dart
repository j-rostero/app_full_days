//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManualBookingInputPayment {
  /// Returns a new [ManualBookingInputPayment] instance.
  ManualBookingInputPayment({
    required this.method,
    required this.reference,
    required this.amountUsd,
  });

  ManualBookingInputPaymentMethodEnum method;

  String reference;

  /// Minimum value: 0.01
  /// Maximum value: 100000
  num amountUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManualBookingInputPayment &&
    other.method == method &&
    other.reference == reference &&
    other.amountUsd == amountUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (method.hashCode) +
    (reference.hashCode) +
    (amountUsd.hashCode);

  @override
  String toString() => 'ManualBookingInputPayment[method=$method, reference=$reference, amountUsd=$amountUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'method'] = this.method;
      json[r'reference'] = this.reference;
      json[r'amountUsd'] = this.amountUsd;
    return json;
  }

  /// Returns a new [ManualBookingInputPayment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManualBookingInputPayment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'method'), 'Required key "ManualBookingInputPayment[method]" is missing from JSON.');
        assert(json[r'method'] != null, 'Required key "ManualBookingInputPayment[method]" has a null value in JSON.');
        assert(json.containsKey(r'reference'), 'Required key "ManualBookingInputPayment[reference]" is missing from JSON.');
        assert(json[r'reference'] != null, 'Required key "ManualBookingInputPayment[reference]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "ManualBookingInputPayment[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "ManualBookingInputPayment[amountUsd]" has a null value in JSON.');
        return true;
      }());

      return ManualBookingInputPayment(
        method: ManualBookingInputPaymentMethodEnum.fromJson(json[r'method'])!,
        reference: mapValueOfType<String>(json, r'reference')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
      );
    }
    return null;
  }

  static List<ManualBookingInputPayment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualBookingInputPayment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualBookingInputPayment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManualBookingInputPayment> mapFromJson(dynamic json) {
    final map = <String, ManualBookingInputPayment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManualBookingInputPayment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManualBookingInputPayment-objects as value to a dart map
  static Map<String, List<ManualBookingInputPayment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManualBookingInputPayment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManualBookingInputPayment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'method',
    'reference',
    'amountUsd',
  };
}


enum ManualBookingInputPaymentMethodEnum {
  mobilePayment._(r'mobile_payment'),
  bankTransfer._(r'bank_transfer'),
  zelle._(r'zelle'),
  cashUsd._(r'cash_usd'),
  ;

  /// Instantiate a new enum with the provided value.
  const ManualBookingInputPaymentMethodEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ManualBookingInputPaymentMethodEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ManualBookingInputPaymentMethodEnum? fromJson(dynamic value) => ManualBookingInputPaymentMethodEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ManualBookingInputPaymentMethodEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ManualBookingInputPaymentMethodEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualBookingInputPaymentMethodEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualBookingInputPaymentMethodEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ManualBookingInputPaymentMethodEnum] to String,
/// and [decode] dynamic data back to [ManualBookingInputPaymentMethodEnum].
class ManualBookingInputPaymentMethodEnumTypeTransformer {
  factory ManualBookingInputPaymentMethodEnumTypeTransformer() => _instance ??= const ManualBookingInputPaymentMethodEnumTypeTransformer._();

  const ManualBookingInputPaymentMethodEnumTypeTransformer._();

  String encode(ManualBookingInputPaymentMethodEnum data) => data._value;

  /// Returns the instance of [ManualBookingInputPaymentMethodEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ManualBookingInputPaymentMethodEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ManualBookingInputPaymentMethodEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mobile_payment': return ManualBookingInputPaymentMethodEnum.mobilePayment;
        case r'bank_transfer': return ManualBookingInputPaymentMethodEnum.bankTransfer;
        case r'zelle': return ManualBookingInputPaymentMethodEnum.zelle;
        case r'cash_usd': return ManualBookingInputPaymentMethodEnum.cashUsd;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ManualBookingInputPaymentMethodEnumTypeTransformer? _instance;
}


