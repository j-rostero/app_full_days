//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AvailabilityDeparture {
  /// Returns a new [AvailabilityDeparture] instance.
  AvailabilityDeparture({
    required this.id,
    required this.date,
    required this.status,
    required this.priceUsd,
    required this.seatsLeft,
    required this.productId,
    required this.adultPriceUsd,
  });

  String id;

  DateTime date;

  AvailabilityDepartureStatusEnum status;

  num priceUsd;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seatsLeft;

  String productId;

  num? adultPriceUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AvailabilityDeparture &&
    other.id == id &&
    other.date == date &&
    other.status == status &&
    other.priceUsd == priceUsd &&
    other.seatsLeft == seatsLeft &&
    other.productId == productId &&
    other.adultPriceUsd == adultPriceUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (date.hashCode) +
    (status.hashCode) +
    (priceUsd.hashCode) +
    (seatsLeft.hashCode) +
    (productId.hashCode) +
    (adultPriceUsd == null ? 0 : adultPriceUsd!.hashCode);

  @override
  String toString() => 'AvailabilityDeparture[id=$id, date=$date, status=$status, priceUsd=$priceUsd, seatsLeft=$seatsLeft, productId=$productId, adultPriceUsd=$adultPriceUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'status'] = this.status;
      json[r'priceUsd'] = this.priceUsd;
      json[r'seatsLeft'] = this.seatsLeft;
      json[r'productId'] = this.productId;
    if (this.adultPriceUsd != null) {
      json[r'adultPriceUsd'] = this.adultPriceUsd;
    } else {
      json[r'adultPriceUsd'] = null;
    }
    return json;
  }

  /// Returns a new [AvailabilityDeparture] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AvailabilityDeparture? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AvailabilityDeparture[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AvailabilityDeparture[id]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "AvailabilityDeparture[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "AvailabilityDeparture[date]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "AvailabilityDeparture[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "AvailabilityDeparture[status]" has a null value in JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "AvailabilityDeparture[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "AvailabilityDeparture[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'seatsLeft'), 'Required key "AvailabilityDeparture[seatsLeft]" is missing from JSON.');
        assert(json[r'seatsLeft'] != null, 'Required key "AvailabilityDeparture[seatsLeft]" has a null value in JSON.');
        assert(json.containsKey(r'productId'), 'Required key "AvailabilityDeparture[productId]" is missing from JSON.');
        assert(json[r'productId'] != null, 'Required key "AvailabilityDeparture[productId]" has a null value in JSON.');
        assert(json.containsKey(r'adultPriceUsd'), 'Required key "AvailabilityDeparture[adultPriceUsd]" is missing from JSON.');
        return true;
      }());

      return AvailabilityDeparture(
        id: mapValueOfType<String>(json, r'id')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        status: AvailabilityDepartureStatusEnum.fromJson(json[r'status'])!,
        priceUsd: num.parse('${json[r'priceUsd']}'),
        seatsLeft: mapValueOfType<int>(json, r'seatsLeft')!,
        productId: mapValueOfType<String>(json, r'productId')!,
        adultPriceUsd: json[r'adultPriceUsd'] == null
            ? null
            : num.parse('${json[r'adultPriceUsd']}'),
      );
    }
    return null;
  }

  static List<AvailabilityDeparture> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AvailabilityDeparture>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AvailabilityDeparture.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AvailabilityDeparture> mapFromJson(dynamic json) {
    final map = <String, AvailabilityDeparture>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AvailabilityDeparture.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AvailabilityDeparture-objects as value to a dart map
  static Map<String, List<AvailabilityDeparture>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AvailabilityDeparture>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AvailabilityDeparture.listFromJson(entry.value, growable: growable,);
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
    'productId',
    'adultPriceUsd',
  };
}


enum AvailabilityDepartureStatusEnum {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const AvailabilityDepartureStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AvailabilityDepartureStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AvailabilityDepartureStatusEnum? fromJson(dynamic value) => AvailabilityDepartureStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AvailabilityDepartureStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AvailabilityDepartureStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AvailabilityDepartureStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AvailabilityDepartureStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AvailabilityDepartureStatusEnum] to String,
/// and [decode] dynamic data back to [AvailabilityDepartureStatusEnum].
class AvailabilityDepartureStatusEnumTypeTransformer {
  factory AvailabilityDepartureStatusEnumTypeTransformer() => _instance ??= const AvailabilityDepartureStatusEnumTypeTransformer._();

  const AvailabilityDepartureStatusEnumTypeTransformer._();

  String encode(AvailabilityDepartureStatusEnum data) => data._value;

  /// Returns the instance of [AvailabilityDepartureStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AvailabilityDepartureStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AvailabilityDepartureStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return AvailabilityDepartureStatusEnum.open;
        case r'paused': return AvailabilityDepartureStatusEnum.paused;
        case r'closed': return AvailabilityDepartureStatusEnum.closed;
        case r'in_progress': return AvailabilityDepartureStatusEnum.inProgress;
        case r'finished': return AvailabilityDepartureStatusEnum.finished;
        case r'cancelled': return AvailabilityDepartureStatusEnum.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AvailabilityDepartureStatusEnumTypeTransformer? _instance;
}


