//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingDeparture {
  /// Returns a new [BookingDeparture] instance.
  BookingDeparture({
    required this.id,
    required this.date,
    required this.status,
  });

  String id;

  DateTime date;

  BookingDepartureStatusEnum status;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingDeparture &&
    other.id == id &&
    other.date == date &&
    other.status == status;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (date.hashCode) +
    (status.hashCode);

  @override
  String toString() => 'BookingDeparture[id=$id, date=$date, status=$status]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'status'] = this.status;
    return json;
  }

  /// Returns a new [BookingDeparture] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingDeparture? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "BookingDeparture[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "BookingDeparture[id]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "BookingDeparture[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "BookingDeparture[date]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "BookingDeparture[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "BookingDeparture[status]" has a null value in JSON.');
        return true;
      }());

      return BookingDeparture(
        id: mapValueOfType<String>(json, r'id')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        status: BookingDepartureStatusEnum.fromJson(json[r'status'])!,
      );
    }
    return null;
  }

  static List<BookingDeparture> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingDeparture>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingDeparture.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingDeparture> mapFromJson(dynamic json) {
    final map = <String, BookingDeparture>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingDeparture.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingDeparture-objects as value to a dart map
  static Map<String, List<BookingDeparture>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingDeparture>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingDeparture.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'date',
    'status',
  };
}


enum BookingDepartureStatusEnum {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingDepartureStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingDepartureStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingDepartureStatusEnum? fromJson(dynamic value) => BookingDepartureStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingDepartureStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingDepartureStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingDepartureStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingDepartureStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingDepartureStatusEnum] to String,
/// and [decode] dynamic data back to [BookingDepartureStatusEnum].
class BookingDepartureStatusEnumTypeTransformer {
  factory BookingDepartureStatusEnumTypeTransformer() => _instance ??= const BookingDepartureStatusEnumTypeTransformer._();

  const BookingDepartureStatusEnumTypeTransformer._();

  String encode(BookingDepartureStatusEnum data) => data._value;

  /// Returns the instance of [BookingDepartureStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingDepartureStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingDepartureStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return BookingDepartureStatusEnum.open;
        case r'paused': return BookingDepartureStatusEnum.paused;
        case r'closed': return BookingDepartureStatusEnum.closed;
        case r'in_progress': return BookingDepartureStatusEnum.inProgress;
        case r'finished': return BookingDepartureStatusEnum.finished;
        case r'cancelled': return BookingDepartureStatusEnum.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingDepartureStatusEnumTypeTransformer? _instance;
}


