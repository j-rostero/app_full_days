//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SettlementLinesInner {
  /// Returns a new [SettlementLinesInner] instance.
  SettlementLinesInner({
    required this.at,
    required this.kind,
    required this.bookingCode,
    required this.amountUsd,
    required this.commissionUsd,
  });

  DateTime at;

  SettlementLinesInnerKindEnum kind;

  String? bookingCode;

  num amountUsd;

  num commissionUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SettlementLinesInner &&
    other.at == at &&
    other.kind == kind &&
    other.bookingCode == bookingCode &&
    other.amountUsd == amountUsd &&
    other.commissionUsd == commissionUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (at.hashCode) +
    (kind.hashCode) +
    (bookingCode == null ? 0 : bookingCode!.hashCode) +
    (amountUsd.hashCode) +
    (commissionUsd.hashCode);

  @override
  String toString() => 'SettlementLinesInner[at=$at, kind=$kind, bookingCode=$bookingCode, amountUsd=$amountUsd, commissionUsd=$commissionUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'at'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.at.millisecondsSinceEpoch
        : this.at.toUtc().toIso8601String();
      json[r'kind'] = this.kind;
    if (this.bookingCode != null) {
      json[r'bookingCode'] = this.bookingCode;
    } else {
      json[r'bookingCode'] = null;
    }
      json[r'amountUsd'] = this.amountUsd;
      json[r'commissionUsd'] = this.commissionUsd;
    return json;
  }

  /// Returns a new [SettlementLinesInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SettlementLinesInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'at'), 'Required key "SettlementLinesInner[at]" is missing from JSON.');
        assert(json[r'at'] != null, 'Required key "SettlementLinesInner[at]" has a null value in JSON.');
        assert(json.containsKey(r'kind'), 'Required key "SettlementLinesInner[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "SettlementLinesInner[kind]" has a null value in JSON.');
        assert(json.containsKey(r'bookingCode'), 'Required key "SettlementLinesInner[bookingCode]" is missing from JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "SettlementLinesInner[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "SettlementLinesInner[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'commissionUsd'), 'Required key "SettlementLinesInner[commissionUsd]" is missing from JSON.');
        assert(json[r'commissionUsd'] != null, 'Required key "SettlementLinesInner[commissionUsd]" has a null value in JSON.');
        return true;
      }());

      return SettlementLinesInner(
        at: mapDateTime(json, r'at', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        kind: SettlementLinesInnerKindEnum.fromJson(json[r'kind'])!,
        bookingCode: mapValueOfType<String>(json, r'bookingCode'),
        amountUsd: num.parse('${json[r'amountUsd']}'),
        commissionUsd: num.parse('${json[r'commissionUsd']}'),
      );
    }
    return null;
  }

  static List<SettlementLinesInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SettlementLinesInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SettlementLinesInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SettlementLinesInner> mapFromJson(dynamic json) {
    final map = <String, SettlementLinesInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SettlementLinesInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SettlementLinesInner-objects as value to a dart map
  static Map<String, List<SettlementLinesInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SettlementLinesInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SettlementLinesInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'at',
    'kind',
    'bookingCode',
    'amountUsd',
    'commissionUsd',
  };
}


enum SettlementLinesInnerKindEnum {
  payment._(r'payment'),
  refund._(r'refund'),
  ;

  /// Instantiate a new enum with the provided value.
  const SettlementLinesInnerKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [SettlementLinesInnerKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static SettlementLinesInnerKindEnum? fromJson(dynamic value) => SettlementLinesInnerKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [SettlementLinesInnerKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<SettlementLinesInnerKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SettlementLinesInnerKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SettlementLinesInnerKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [SettlementLinesInnerKindEnum] to String,
/// and [decode] dynamic data back to [SettlementLinesInnerKindEnum].
class SettlementLinesInnerKindEnumTypeTransformer {
  factory SettlementLinesInnerKindEnumTypeTransformer() => _instance ??= const SettlementLinesInnerKindEnumTypeTransformer._();

  const SettlementLinesInnerKindEnumTypeTransformer._();

  String encode(SettlementLinesInnerKindEnum data) => data._value;

  /// Returns the instance of [SettlementLinesInnerKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  SettlementLinesInnerKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is SettlementLinesInnerKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'payment': return SettlementLinesInnerKindEnum.payment;
        case r'refund': return SettlementLinesInnerKindEnum.refund;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static SettlementLinesInnerKindEnumTypeTransformer? _instance;
}


