//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Refund {
  /// Returns a new [Refund] instance.
  Refund({
    required this.id,
    required this.bookingId,
    required this.bookingCode,
    required this.title,
    required this.departureDate,
    required this.traveler,
    required this.amountUsd,
    required this.rule,
    required this.status,
    required this.reference,
    required this.createdAt,
    required this.paidAt,
  });

  String id;

  String bookingId;

  String bookingCode;

  String title;

  DateTime departureDate;

  String? traveler;

  num amountUsd;

  String rule;

  RefundStatusEnum status;

  String? reference;

  DateTime createdAt;

  DateTime? paidAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Refund &&
    other.id == id &&
    other.bookingId == bookingId &&
    other.bookingCode == bookingCode &&
    other.title == title &&
    other.departureDate == departureDate &&
    other.traveler == traveler &&
    other.amountUsd == amountUsd &&
    other.rule == rule &&
    other.status == status &&
    other.reference == reference &&
    other.createdAt == createdAt &&
    other.paidAt == paidAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (bookingId.hashCode) +
    (bookingCode.hashCode) +
    (title.hashCode) +
    (departureDate.hashCode) +
    (traveler == null ? 0 : traveler!.hashCode) +
    (amountUsd.hashCode) +
    (rule.hashCode) +
    (status.hashCode) +
    (reference == null ? 0 : reference!.hashCode) +
    (createdAt.hashCode) +
    (paidAt == null ? 0 : paidAt!.hashCode);

  @override
  String toString() => 'Refund[id=$id, bookingId=$bookingId, bookingCode=$bookingCode, title=$title, departureDate=$departureDate, traveler=$traveler, amountUsd=$amountUsd, rule=$rule, status=$status, reference=$reference, createdAt=$createdAt, paidAt=$paidAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'bookingId'] = this.bookingId;
      json[r'bookingCode'] = this.bookingCode;
      json[r'title'] = this.title;
      json[r'departureDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.departureDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.departureDate);
    if (this.traveler != null) {
      json[r'traveler'] = this.traveler;
    } else {
      json[r'traveler'] = null;
    }
      json[r'amountUsd'] = this.amountUsd;
      json[r'rule'] = this.rule;
      json[r'status'] = this.status;
    if (this.reference != null) {
      json[r'reference'] = this.reference;
    } else {
      json[r'reference'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    if (this.paidAt != null) {
      json[r'paidAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.paidAt!.millisecondsSinceEpoch
        : this.paidAt!.toUtc().toIso8601String();
    } else {
      json[r'paidAt'] = null;
    }
    return json;
  }

  /// Returns a new [Refund] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Refund? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Refund[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Refund[id]" has a null value in JSON.');
        assert(json.containsKey(r'bookingId'), 'Required key "Refund[bookingId]" is missing from JSON.');
        assert(json[r'bookingId'] != null, 'Required key "Refund[bookingId]" has a null value in JSON.');
        assert(json.containsKey(r'bookingCode'), 'Required key "Refund[bookingCode]" is missing from JSON.');
        assert(json[r'bookingCode'] != null, 'Required key "Refund[bookingCode]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Refund[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Refund[title]" has a null value in JSON.');
        assert(json.containsKey(r'departureDate'), 'Required key "Refund[departureDate]" is missing from JSON.');
        assert(json[r'departureDate'] != null, 'Required key "Refund[departureDate]" has a null value in JSON.');
        assert(json.containsKey(r'traveler'), 'Required key "Refund[traveler]" is missing from JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "Refund[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "Refund[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'rule'), 'Required key "Refund[rule]" is missing from JSON.');
        assert(json[r'rule'] != null, 'Required key "Refund[rule]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "Refund[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Refund[status]" has a null value in JSON.');
        assert(json.containsKey(r'reference'), 'Required key "Refund[reference]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Refund[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Refund[createdAt]" has a null value in JSON.');
        assert(json.containsKey(r'paidAt'), 'Required key "Refund[paidAt]" is missing from JSON.');
        return true;
      }());

      return Refund(
        id: mapValueOfType<String>(json, r'id')!,
        bookingId: mapValueOfType<String>(json, r'bookingId')!,
        bookingCode: mapValueOfType<String>(json, r'bookingCode')!,
        title: mapValueOfType<String>(json, r'title')!,
        departureDate: mapDateTime(json, r'departureDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        traveler: mapValueOfType<String>(json, r'traveler'),
        amountUsd: num.parse('${json[r'amountUsd']}'),
        rule: mapValueOfType<String>(json, r'rule')!,
        status: RefundStatusEnum.fromJson(json[r'status'])!,
        reference: mapValueOfType<String>(json, r'reference'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        paidAt: mapDateTime(json, r'paidAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
      );
    }
    return null;
  }

  static List<Refund> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Refund>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Refund.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Refund> mapFromJson(dynamic json) {
    final map = <String, Refund>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Refund.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Refund-objects as value to a dart map
  static Map<String, List<Refund>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Refund>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Refund.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'bookingId',
    'bookingCode',
    'title',
    'departureDate',
    'traveler',
    'amountUsd',
    'rule',
    'status',
    'reference',
    'createdAt',
    'paidAt',
  };
}


enum RefundStatusEnum {
  pending._(r'pending'),
  paid._(r'paid'),
  ;

  /// Instantiate a new enum with the provided value.
  const RefundStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [RefundStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static RefundStatusEnum? fromJson(dynamic value) => RefundStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [RefundStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<RefundStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <RefundStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = RefundStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [RefundStatusEnum] to String,
/// and [decode] dynamic data back to [RefundStatusEnum].
class RefundStatusEnumTypeTransformer {
  factory RefundStatusEnumTypeTransformer() => _instance ??= const RefundStatusEnumTypeTransformer._();

  const RefundStatusEnumTypeTransformer._();

  String encode(RefundStatusEnum data) => data._value;

  /// Returns the instance of [RefundStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  RefundStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is RefundStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'pending': return RefundStatusEnum.pending;
        case r'paid': return RefundStatusEnum.paid;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static RefundStatusEnumTypeTransformer? _instance;
}


