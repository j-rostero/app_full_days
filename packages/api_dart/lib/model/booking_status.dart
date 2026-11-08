//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum BookingStatus {
  held._(r'held'),
  inReview._(r'in_review'),
  depositPaid._(r'deposit_paid'),
  paid._(r'paid'),
  expired._(r'expired'),
  cancelled._(r'cancelled'),
  completed._(r'completed'),
  noShow._(r'no_show'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingStatus._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingStatus] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingStatus? fromJson(dynamic value) => BookingStatusTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingStatus]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingStatus] to String,
/// and [decode] dynamic data back to [BookingStatus].
class BookingStatusTypeTransformer {
  factory BookingStatusTypeTransformer() => _instance ??= const BookingStatusTypeTransformer._();

  const BookingStatusTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(BookingStatus data) => data._value;

  /// Returns the instance of [BookingStatus] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingStatus) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'held': return BookingStatus.held;
        case r'in_review': return BookingStatus.inReview;
        case r'deposit_paid': return BookingStatus.depositPaid;
        case r'paid': return BookingStatus.paid;
        case r'expired': return BookingStatus.expired;
        case r'cancelled': return BookingStatus.cancelled;
        case r'completed': return BookingStatus.completed;
        case r'no_show': return BookingStatus.noShow;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingStatusTypeTransformer? _instance;
}

