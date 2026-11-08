//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DepartureDate {
  /// Returns a new [DepartureDate] instance.
  DepartureDate({
    required this.id,
    required this.date,
    required this.status,
    required this.priceUsd,
    required this.seatsLeft,
  });

  String id;

  DateTime date;

  DepartureDateStatusEnum status;

  num priceUsd;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seatsLeft;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DepartureDate &&
    other.id == id &&
    other.date == date &&
    other.status == status &&
    other.priceUsd == priceUsd &&
    other.seatsLeft == seatsLeft;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (date.hashCode) +
    (status.hashCode) +
    (priceUsd.hashCode) +
    (seatsLeft.hashCode);

  @override
  String toString() => 'DepartureDate[id=$id, date=$date, status=$status, priceUsd=$priceUsd, seatsLeft=$seatsLeft]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'status'] = this.status;
      json[r'priceUsd'] = this.priceUsd;
      json[r'seatsLeft'] = this.seatsLeft;
    return json;
  }

  /// Returns a new [DepartureDate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DepartureDate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "DepartureDate[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "DepartureDate[id]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "DepartureDate[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "DepartureDate[date]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "DepartureDate[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "DepartureDate[status]" has a null value in JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "DepartureDate[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "DepartureDate[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'seatsLeft'), 'Required key "DepartureDate[seatsLeft]" is missing from JSON.');
        assert(json[r'seatsLeft'] != null, 'Required key "DepartureDate[seatsLeft]" has a null value in JSON.');
        return true;
      }());

      return DepartureDate(
        id: mapValueOfType<String>(json, r'id')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        status: DepartureDateStatusEnum.fromJson(json[r'status'])!,
        priceUsd: num.parse('${json[r'priceUsd']}'),
        seatsLeft: mapValueOfType<int>(json, r'seatsLeft')!,
      );
    }
    return null;
  }

  static List<DepartureDate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureDate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureDate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DepartureDate> mapFromJson(dynamic json) {
    final map = <String, DepartureDate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DepartureDate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DepartureDate-objects as value to a dart map
  static Map<String, List<DepartureDate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DepartureDate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DepartureDate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'date',
    'status',
    'priceUsd',
    'seatsLeft',
  };
}


enum DepartureDateStatusEnum {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const DepartureDateStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DepartureDateStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DepartureDateStatusEnum? fromJson(dynamic value) => DepartureDateStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DepartureDateStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DepartureDateStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureDateStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureDateStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DepartureDateStatusEnum] to String,
/// and [decode] dynamic data back to [DepartureDateStatusEnum].
class DepartureDateStatusEnumTypeTransformer {
  factory DepartureDateStatusEnumTypeTransformer() => _instance ??= const DepartureDateStatusEnumTypeTransformer._();

  const DepartureDateStatusEnumTypeTransformer._();

  String encode(DepartureDateStatusEnum data) => data._value;

  /// Returns the instance of [DepartureDateStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DepartureDateStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DepartureDateStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return DepartureDateStatusEnum.open;
        case r'paused': return DepartureDateStatusEnum.paused;
        case r'closed': return DepartureDateStatusEnum.closed;
        case r'in_progress': return DepartureDateStatusEnum.inProgress;
        case r'finished': return DepartureDateStatusEnum.finished;
        case r'cancelled': return DepartureDateStatusEnum.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DepartureDateStatusEnumTypeTransformer? _instance;
}


