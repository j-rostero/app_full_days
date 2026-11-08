//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Settings {
  /// Returns a new [Settings] instance.
  Settings({
    required this.holdMinutes,
    required this.minDepositPercent,
    required this.mealChoiceDeadlineHours,
    this.paymentMethods = const [],
    required this.platformCommissionPercent,
  });

  /// Minimum value: 5
  /// Maximum value: 120
  int holdMinutes;

  /// Minimum value: 0
  /// Maximum value: 100
  int minDepositPercent;

  /// Minimum value: 0
  /// Maximum value: 720
  int mealChoiceDeadlineHours;

  List<SettingsPaymentMethodsEnum> paymentMethods;

  /// Minimum value: 0
  /// Maximum value: 50
  num platformCommissionPercent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Settings &&
    other.holdMinutes == holdMinutes &&
    other.minDepositPercent == minDepositPercent &&
    other.mealChoiceDeadlineHours == mealChoiceDeadlineHours &&
    _deepEquality.equals(other.paymentMethods, paymentMethods) &&
    other.platformCommissionPercent == platformCommissionPercent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (holdMinutes.hashCode) +
    (minDepositPercent.hashCode) +
    (mealChoiceDeadlineHours.hashCode) +
    (paymentMethods.hashCode) +
    (platformCommissionPercent.hashCode);

  @override
  String toString() => 'Settings[holdMinutes=$holdMinutes, minDepositPercent=$minDepositPercent, mealChoiceDeadlineHours=$mealChoiceDeadlineHours, paymentMethods=$paymentMethods, platformCommissionPercent=$platformCommissionPercent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'holdMinutes'] = this.holdMinutes;
      json[r'minDepositPercent'] = this.minDepositPercent;
      json[r'mealChoiceDeadlineHours'] = this.mealChoiceDeadlineHours;
      json[r'paymentMethods'] = this.paymentMethods;
      json[r'platformCommissionPercent'] = this.platformCommissionPercent;
    return json;
  }

  /// Returns a new [Settings] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Settings? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'holdMinutes'), 'Required key "Settings[holdMinutes]" is missing from JSON.');
        assert(json[r'holdMinutes'] != null, 'Required key "Settings[holdMinutes]" has a null value in JSON.');
        assert(json.containsKey(r'minDepositPercent'), 'Required key "Settings[minDepositPercent]" is missing from JSON.');
        assert(json[r'minDepositPercent'] != null, 'Required key "Settings[minDepositPercent]" has a null value in JSON.');
        assert(json.containsKey(r'mealChoiceDeadlineHours'), 'Required key "Settings[mealChoiceDeadlineHours]" is missing from JSON.');
        assert(json[r'mealChoiceDeadlineHours'] != null, 'Required key "Settings[mealChoiceDeadlineHours]" has a null value in JSON.');
        assert(json.containsKey(r'paymentMethods'), 'Required key "Settings[paymentMethods]" is missing from JSON.');
        assert(json[r'paymentMethods'] != null, 'Required key "Settings[paymentMethods]" has a null value in JSON.');
        assert(json.containsKey(r'platformCommissionPercent'), 'Required key "Settings[platformCommissionPercent]" is missing from JSON.');
        assert(json[r'platformCommissionPercent'] != null, 'Required key "Settings[platformCommissionPercent]" has a null value in JSON.');
        return true;
      }());

      return Settings(
        holdMinutes: mapValueOfType<int>(json, r'holdMinutes')!,
        minDepositPercent: mapValueOfType<int>(json, r'minDepositPercent')!,
        mealChoiceDeadlineHours: mapValueOfType<int>(json, r'mealChoiceDeadlineHours')!,
        paymentMethods: SettingsPaymentMethodsEnum.listFromJson(json[r'paymentMethods']),
        platformCommissionPercent: num.parse('${json[r'platformCommissionPercent']}'),
      );
    }
    return null;
  }

  static List<Settings> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Settings>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Settings.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Settings> mapFromJson(dynamic json) {
    final map = <String, Settings>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Settings.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Settings-objects as value to a dart map
  static Map<String, List<Settings>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Settings>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Settings.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'holdMinutes',
    'minDepositPercent',
    'mealChoiceDeadlineHours',
    'paymentMethods',
    'platformCommissionPercent',
  };
}


enum SettingsPaymentMethodsEnum {
  mobilePayment._(r'mobile_payment'),
  bankTransfer._(r'bank_transfer'),
  zelle._(r'zelle'),
  cashUsd._(r'cash_usd'),
  ;

  /// Instantiate a new enum with the provided value.
  const SettingsPaymentMethodsEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SettingsPaymentMethodsEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SettingsPaymentMethodsEnum? fromJson(dynamic value) => SettingsPaymentMethodsEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SettingsPaymentMethodsEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SettingsPaymentMethodsEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SettingsPaymentMethodsEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SettingsPaymentMethodsEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SettingsPaymentMethodsEnum] to String,
/// and [decode] dynamic data back to [SettingsPaymentMethodsEnum].
class SettingsPaymentMethodsEnumTypeTransformer {
  factory SettingsPaymentMethodsEnumTypeTransformer() => _instance ??= const SettingsPaymentMethodsEnumTypeTransformer._();

  const SettingsPaymentMethodsEnumTypeTransformer._();

  String encode(SettingsPaymentMethodsEnum data) => data._value;

  /// Returns the instance of [SettingsPaymentMethodsEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SettingsPaymentMethodsEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SettingsPaymentMethodsEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mobile_payment': return SettingsPaymentMethodsEnum.mobilePayment;
        case r'bank_transfer': return SettingsPaymentMethodsEnum.bankTransfer;
        case r'zelle': return SettingsPaymentMethodsEnum.zelle;
        case r'cash_usd': return SettingsPaymentMethodsEnum.cashUsd;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SettingsPaymentMethodsEnumTypeTransformer? _instance;
}


