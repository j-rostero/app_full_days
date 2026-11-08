//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReportPaymentInput {
  /// Returns a new [ReportPaymentInput] instance.
  ReportPaymentInput({
    required this.method,
    required this.reference,
    required this.amountUsd,
    required this.proofFileId,
    required this.idempotencyKey,
  });

  ReportPaymentInputMethodEnum method;

  String reference;

  /// Minimum value: 0.01
  /// Maximum value: 100000
  num amountUsd;

  String? proofFileId;

  String idempotencyKey;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReportPaymentInput &&
    other.method == method &&
    other.reference == reference &&
    other.amountUsd == amountUsd &&
    other.proofFileId == proofFileId &&
    other.idempotencyKey == idempotencyKey;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (method.hashCode) +
    (reference.hashCode) +
    (amountUsd.hashCode) +
    (proofFileId == null ? 0 : proofFileId!.hashCode) +
    (idempotencyKey.hashCode);

  @override
  String toString() => 'ReportPaymentInput[method=$method, reference=$reference, amountUsd=$amountUsd, proofFileId=$proofFileId, idempotencyKey=$idempotencyKey]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'method'] = this.method;
      json[r'reference'] = this.reference;
      json[r'amountUsd'] = this.amountUsd;
    if (this.proofFileId != null) {
      json[r'proofFileId'] = this.proofFileId;
    } else {
      json[r'proofFileId'] = null;
    }
      json[r'idempotencyKey'] = this.idempotencyKey;
    return json;
  }

  /// Returns a new [ReportPaymentInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReportPaymentInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'method'), 'Required key "ReportPaymentInput[method]" is missing from JSON.');
        assert(json[r'method'] != null, 'Required key "ReportPaymentInput[method]" has a null value in JSON.');
        assert(json.containsKey(r'reference'), 'Required key "ReportPaymentInput[reference]" is missing from JSON.');
        assert(json[r'reference'] != null, 'Required key "ReportPaymentInput[reference]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "ReportPaymentInput[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "ReportPaymentInput[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'proofFileId'), 'Required key "ReportPaymentInput[proofFileId]" is missing from JSON.');
        assert(json.containsKey(r'idempotencyKey'), 'Required key "ReportPaymentInput[idempotencyKey]" is missing from JSON.');
        assert(json[r'idempotencyKey'] != null, 'Required key "ReportPaymentInput[idempotencyKey]" has a null value in JSON.');
        return true;
      }());

      return ReportPaymentInput(
        method: ReportPaymentInputMethodEnum.fromJson(json[r'method'])!,
        reference: mapValueOfType<String>(json, r'reference')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        proofFileId: mapValueOfType<String>(json, r'proofFileId'),
        idempotencyKey: mapValueOfType<String>(json, r'idempotencyKey')!,
      );
    }
    return null;
  }

  static List<ReportPaymentInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportPaymentInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportPaymentInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReportPaymentInput> mapFromJson(dynamic json) {
    final map = <String, ReportPaymentInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReportPaymentInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReportPaymentInput-objects as value to a dart map
  static Map<String, List<ReportPaymentInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReportPaymentInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReportPaymentInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'method',
    'reference',
    'amountUsd',
    'proofFileId',
    'idempotencyKey',
  };
}


enum ReportPaymentInputMethodEnum {
  mobilePayment._(r'mobile_payment'),
  bankTransfer._(r'bank_transfer'),
  zelle._(r'zelle'),
  cashUsd._(r'cash_usd'),
  ;

  /// Instantiate a new enum with the provided value.
  const ReportPaymentInputMethodEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ReportPaymentInputMethodEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ReportPaymentInputMethodEnum? fromJson(dynamic value) => ReportPaymentInputMethodEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ReportPaymentInputMethodEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ReportPaymentInputMethodEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReportPaymentInputMethodEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReportPaymentInputMethodEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReportPaymentInputMethodEnum] to String,
/// and [decode] dynamic data back to [ReportPaymentInputMethodEnum].
class ReportPaymentInputMethodEnumTypeTransformer {
  factory ReportPaymentInputMethodEnumTypeTransformer() => _instance ??= const ReportPaymentInputMethodEnumTypeTransformer._();

  const ReportPaymentInputMethodEnumTypeTransformer._();

  String encode(ReportPaymentInputMethodEnum data) => data._value;

  /// Returns the instance of [ReportPaymentInputMethodEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReportPaymentInputMethodEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ReportPaymentInputMethodEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'mobile_payment': return ReportPaymentInputMethodEnum.mobilePayment;
        case r'bank_transfer': return ReportPaymentInputMethodEnum.bankTransfer;
        case r'zelle': return ReportPaymentInputMethodEnum.zelle;
        case r'cash_usd': return ReportPaymentInputMethodEnum.cashUsd;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ReportPaymentInputMethodEnumTypeTransformer? _instance;
}


