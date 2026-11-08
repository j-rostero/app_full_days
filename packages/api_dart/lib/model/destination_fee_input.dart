//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DestinationFeeInput {
  /// Returns a new [DestinationFeeInput] instance.
  DestinationFeeInput({
    required this.name,
    required this.amountUsd,
    required this.payment,
  });

  String name;

  /// Minimum value: 0
  /// Maximum value: 10000
  num amountUsd;

  DestinationFeeInputPaymentEnum payment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DestinationFeeInput &&
    other.name == name &&
    other.amountUsd == amountUsd &&
    other.payment == payment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (name.hashCode) +
    (amountUsd.hashCode) +
    (payment.hashCode);

  @override
  String toString() => 'DestinationFeeInput[name=$name, amountUsd=$amountUsd, payment=$payment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'name'] = this.name;
      json[r'amountUsd'] = this.amountUsd;
      json[r'payment'] = this.payment;
    return json;
  }

  /// Returns a new [DestinationFeeInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DestinationFeeInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'name'), 'Required key "DestinationFeeInput[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "DestinationFeeInput[name]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "DestinationFeeInput[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "DestinationFeeInput[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'payment'), 'Required key "DestinationFeeInput[payment]" is missing from JSON.');
        assert(json[r'payment'] != null, 'Required key "DestinationFeeInput[payment]" has a null value in JSON.');
        return true;
      }());

      return DestinationFeeInput(
        name: mapValueOfType<String>(json, r'name')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        payment: DestinationFeeInputPaymentEnum.fromJson(json[r'payment'])!,
      );
    }
    return null;
  }

  static List<DestinationFeeInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DestinationFeeInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DestinationFeeInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DestinationFeeInput> mapFromJson(dynamic json) {
    final map = <String, DestinationFeeInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DestinationFeeInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DestinationFeeInput-objects as value to a dart map
  static Map<String, List<DestinationFeeInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DestinationFeeInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DestinationFeeInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'name',
    'amountUsd',
    'payment',
  };
}


enum DestinationFeeInputPaymentEnum {
  cashUsd._(r'cash_usd'),
  cashBs._(r'cash_bs'),
  mobilePayment._(r'mobile_payment'),
  ;

  /// Instantiate a new enum with the provided value.
  const DestinationFeeInputPaymentEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DestinationFeeInputPaymentEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DestinationFeeInputPaymentEnum? fromJson(dynamic value) => DestinationFeeInputPaymentEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DestinationFeeInputPaymentEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DestinationFeeInputPaymentEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DestinationFeeInputPaymentEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DestinationFeeInputPaymentEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DestinationFeeInputPaymentEnum] to String,
/// and [decode] dynamic data back to [DestinationFeeInputPaymentEnum].
class DestinationFeeInputPaymentEnumTypeTransformer {
  factory DestinationFeeInputPaymentEnumTypeTransformer() => _instance ??= const DestinationFeeInputPaymentEnumTypeTransformer._();

  const DestinationFeeInputPaymentEnumTypeTransformer._();

  String encode(DestinationFeeInputPaymentEnum data) => data._value;

  /// Returns the instance of [DestinationFeeInputPaymentEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DestinationFeeInputPaymentEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DestinationFeeInputPaymentEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'cash_usd': return DestinationFeeInputPaymentEnum.cashUsd;
        case r'cash_bs': return DestinationFeeInputPaymentEnum.cashBs;
        case r'mobile_payment': return DestinationFeeInputPaymentEnum.mobilePayment;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DestinationFeeInputPaymentEnumTypeTransformer? _instance;
}


