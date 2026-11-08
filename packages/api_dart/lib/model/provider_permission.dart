//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;


enum ProviderPermission {
  team._(r'team'),
  company._(r'company'),
  fulldays._(r'fulldays'),
  departures._(r'departures'),
  bookings._(r'bookings'),
  notices._(r'notices'),
  payments._(r'payments'),
  settlements._(r'settlements'),
  reports._(r'reports'),
  checkin._(r'checkin'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProviderPermission._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProviderPermission] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProviderPermission? fromJson(dynamic value) => ProviderPermissionTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProviderPermission]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProviderPermission> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderPermission>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderPermission.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProviderPermission] to String,
/// and [decode] dynamic data back to [ProviderPermission].
class ProviderPermissionTypeTransformer {
  factory ProviderPermissionTypeTransformer() => _instance ??= const ProviderPermissionTypeTransformer._();

  const ProviderPermissionTypeTransformer._();

  /// Encodes this enum as a value suitable for JSON.
  String encode(ProviderPermission data) => data._value;

  /// Returns the instance of [ProviderPermission] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProviderPermission? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProviderPermission) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'team': return ProviderPermission.team;
        case r'company': return ProviderPermission.company;
        case r'fulldays': return ProviderPermission.fulldays;
        case r'departures': return ProviderPermission.departures;
        case r'bookings': return ProviderPermission.bookings;
        case r'notices': return ProviderPermission.notices;
        case r'payments': return ProviderPermission.payments;
        case r'settlements': return ProviderPermission.settlements;
        case r'reports': return ProviderPermission.reports;
        case r'checkin': return ProviderPermission.checkin;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProviderPermissionTypeTransformer? _instance;
}

