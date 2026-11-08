//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum DepartureStatus {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const DepartureStatus._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DepartureStatus] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DepartureStatus? fromJson(dynamic value) => DepartureStatusTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DepartureStatus]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DepartureStatus> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureStatus>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureStatus.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DepartureStatus] to String,
/// and [decode] dynamic data back to [DepartureStatus].
class DepartureStatusTypeTransformer {
  factory DepartureStatusTypeTransformer() => _instance ??= const DepartureStatusTypeTransformer._();

  const DepartureStatusTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(DepartureStatus data) => data._value;

  /// Returns the instance of [DepartureStatus] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DepartureStatus? decode(dynamic data, {bool allowNull = true}) {
    if (data is DepartureStatus) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return DepartureStatus.open;
        case r'paused': return DepartureStatus.paused;
        case r'closed': return DepartureStatus.closed;
        case r'in_progress': return DepartureStatus.inProgress;
        case r'finished': return DepartureStatus.finished;
        case r'cancelled': return DepartureStatus.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DepartureStatusTypeTransformer? _instance;
}

