//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum StaffPermission {
  staff._(r'staff'),
  audit._(r'audit'),
  providers._(r'providers'),
  users._(r'users'),
  bookings._(r'bookings'),
  claims._(r'claims'),
  reviews._(r'reviews'),
  content._(r'content'),
  fulldays._(r'fulldays'),
  catalogs._(r'catalogs'),
  themes._(r'themes'),
  commissions._(r'commissions'),
  payments._(r'payments'),
  refunds._(r'refunds'),
  settlements._(r'settlements'),
  rates._(r'rates'),
  settings._(r'settings'),
  metrics._(r'metrics'),
  ;

  /// Instantiate a new enum with the provided value.
  const StaffPermission._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [StaffPermission] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static StaffPermission? fromJson(dynamic value) => StaffPermissionTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [StaffPermission]
  /// that were successfully decoded from the passed [JSON][json].
  static List<StaffPermission> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <StaffPermission>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = StaffPermission.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [StaffPermission] to String,
/// and [decode] dynamic data back to [StaffPermission].
class StaffPermissionTypeTransformer {
  factory StaffPermissionTypeTransformer() => _instance ??= const StaffPermissionTypeTransformer._();

  const StaffPermissionTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(StaffPermission data) => data._value;

  /// Returns the instance of [StaffPermission] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  StaffPermission? decode(dynamic data, {bool allowNull = true}) {
    if (data is StaffPermission) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'staff': return StaffPermission.staff;
        case r'audit': return StaffPermission.audit;
        case r'providers': return StaffPermission.providers;
        case r'users': return StaffPermission.users;
        case r'bookings': return StaffPermission.bookings;
        case r'claims': return StaffPermission.claims;
        case r'reviews': return StaffPermission.reviews;
        case r'content': return StaffPermission.content;
        case r'fulldays': return StaffPermission.fulldays;
        case r'catalogs': return StaffPermission.catalogs;
        case r'themes': return StaffPermission.themes;
        case r'commissions': return StaffPermission.commissions;
        case r'payments': return StaffPermission.payments;
        case r'refunds': return StaffPermission.refunds;
        case r'settlements': return StaffPermission.settlements;
        case r'rates': return StaffPermission.rates;
        case r'settings': return StaffPermission.settings;
        case r'metrics': return StaffPermission.metrics;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static StaffPermissionTypeTransformer? _instance;
}

