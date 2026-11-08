//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingRefund {
  /// Returns a new [BookingRefund] instance.
  BookingRefund({
    required this.id,
    required this.amountUsd,
    required this.rule,
    required this.status,
    required this.reference,
  });

  String id;

  num amountUsd;

  String rule;

  BookingRefundStatusEnum status;

  String? reference;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingRefund &&
    other.id == id &&
    other.amountUsd == amountUsd &&
    other.rule == rule &&
    other.status == status &&
    other.reference == reference;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (amountUsd.hashCode) +
    (rule.hashCode) +
    (status.hashCode) +
    (reference == null ? 0 : reference!.hashCode);

  @override
  String toString() => 'BookingRefund[id=$id, amountUsd=$amountUsd, rule=$rule, status=$status, reference=$reference]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'amountUsd'] = this.amountUsd;
      json[r'rule'] = this.rule;
      json[r'status'] = this.status;
    if (this.reference != null) {
      json[r'reference'] = this.reference;
    } else {
      json[r'reference'] = null;
    }
    return json;
  }

  /// Returns a new [BookingRefund] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingRefund? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "BookingRefund[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "BookingRefund[id]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "BookingRefund[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "BookingRefund[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'rule'), 'Required key "BookingRefund[rule]" is missing from JSON.');
        assert(json[r'rule'] != null, 'Required key "BookingRefund[rule]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "BookingRefund[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "BookingRefund[status]" has a null value in JSON.');
        assert(json.containsKey(r'reference'), 'Required key "BookingRefund[reference]" is missing from JSON.');
        return true;
      }());

      return BookingRefund(
        id: mapValueOfType<String>(json, r'id')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        rule: mapValueOfType<String>(json, r'rule')!,
        status: BookingRefundStatusEnum.fromJson(json[r'status'])!,
        reference: mapValueOfType<String>(json, r'reference'),
      );
    }
    return null;
  }

  static List<BookingRefund> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingRefund>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingRefund.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingRefund> mapFromJson(dynamic json) {
    final map = <String, BookingRefund>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingRefund.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingRefund-objects as value to a dart map
  static Map<String, List<BookingRefund>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingRefund>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingRefund.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'amountUsd',
    'rule',
    'status',
    'reference',
  };
}


enum BookingRefundStatusEnum {
  pending._(r'pending'),
  paid._(r'paid'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingRefundStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingRefundStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingRefundStatusEnum? fromJson(dynamic value) => BookingRefundStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingRefundStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingRefundStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingRefundStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingRefundStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingRefundStatusEnum] to String,
/// and [decode] dynamic data back to [BookingRefundStatusEnum].
class BookingRefundStatusEnumTypeTransformer {
  factory BookingRefundStatusEnumTypeTransformer() => _instance ??= const BookingRefundStatusEnumTypeTransformer._();

  const BookingRefundStatusEnumTypeTransformer._();

  String encode(BookingRefundStatusEnum data) => data._value;

  /// Returns the instance of [BookingRefundStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingRefundStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingRefundStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'pending': return BookingRefundStatusEnum.pending;
        case r'paid': return BookingRefundStatusEnum.paid;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingRefundStatusEnumTypeTransformer? _instance;
}


