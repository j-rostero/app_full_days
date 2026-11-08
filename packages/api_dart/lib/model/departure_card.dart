//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DepartureCard {
  /// Returns a new [DepartureCard] instance.
  DepartureCard({
    required this.departureId,
    required this.productId,
    required this.date,
    required this.status,
    required this.type,
    required this.title,
    required this.summary,
    required this.cover,
    required this.priceUsd,
    required this.seatsLeft,
    required this.days,
    required this.destination,
    this.cities = const [],
    required this.featured,
    required this.provider,
  });

  String departureId;

  String productId;

  DateTime date;

  DepartureCardStatusEnum status;

  ProductType type;

  String title;

  String summary;

  ImageUrls? cover;

  num priceUsd;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seatsLeft;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int days;

  String? destination;

  List<String> cities;

  bool featured;

  PublicProviderRef provider;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DepartureCard &&
    other.departureId == departureId &&
    other.productId == productId &&
    other.date == date &&
    other.status == status &&
    other.type == type &&
    other.title == title &&
    other.summary == summary &&
    other.cover == cover &&
    other.priceUsd == priceUsd &&
    other.seatsLeft == seatsLeft &&
    other.days == days &&
    other.destination == destination &&
    _deepEquality.equals(other.cities, cities) &&
    other.featured == featured &&
    other.provider == provider;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departureId.hashCode) +
    (productId.hashCode) +
    (date.hashCode) +
    (status.hashCode) +
    (type.hashCode) +
    (title.hashCode) +
    (summary.hashCode) +
    (cover == null ? 0 : cover!.hashCode) +
    (priceUsd.hashCode) +
    (seatsLeft.hashCode) +
    (days.hashCode) +
    (destination == null ? 0 : destination!.hashCode) +
    (cities.hashCode) +
    (featured.hashCode) +
    (provider.hashCode);

  @override
  String toString() => 'DepartureCard[departureId=$departureId, productId=$productId, date=$date, status=$status, type=$type, title=$title, summary=$summary, cover=$cover, priceUsd=$priceUsd, seatsLeft=$seatsLeft, days=$days, destination=$destination, cities=$cities, featured=$featured, provider=$provider]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departureId'] = this.departureId;
      json[r'productId'] = this.productId;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'status'] = this.status;
      json[r'type'] = this.type;
      json[r'title'] = this.title;
      json[r'summary'] = this.summary;
    if (this.cover != null) {
      json[r'cover'] = this.cover;
    } else {
      json[r'cover'] = null;
    }
      json[r'priceUsd'] = this.priceUsd;
      json[r'seatsLeft'] = this.seatsLeft;
      json[r'days'] = this.days;
    if (this.destination != null) {
      json[r'destination'] = this.destination;
    } else {
      json[r'destination'] = null;
    }
      json[r'cities'] = this.cities;
      json[r'featured'] = this.featured;
      json[r'provider'] = this.provider;
    return json;
  }

  /// Returns a new [DepartureCard] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DepartureCard? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departureId'), 'Required key "DepartureCard[departureId]" is missing from JSON.');
        assert(json[r'departureId'] != null, 'Required key "DepartureCard[departureId]" has a null value in JSON.');
        assert(json.containsKey(r'productId'), 'Required key "DepartureCard[productId]" is missing from JSON.');
        assert(json[r'productId'] != null, 'Required key "DepartureCard[productId]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "DepartureCard[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "DepartureCard[date]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "DepartureCard[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "DepartureCard[status]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "DepartureCard[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "DepartureCard[type]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "DepartureCard[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "DepartureCard[title]" has a null value in JSON.');
        assert(json.containsKey(r'summary'), 'Required key "DepartureCard[summary]" is missing from JSON.');
        assert(json[r'summary'] != null, 'Required key "DepartureCard[summary]" has a null value in JSON.');
        assert(json.containsKey(r'cover'), 'Required key "DepartureCard[cover]" is missing from JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "DepartureCard[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "DepartureCard[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'seatsLeft'), 'Required key "DepartureCard[seatsLeft]" is missing from JSON.');
        assert(json[r'seatsLeft'] != null, 'Required key "DepartureCard[seatsLeft]" has a null value in JSON.');
        assert(json.containsKey(r'days'), 'Required key "DepartureCard[days]" is missing from JSON.');
        assert(json[r'days'] != null, 'Required key "DepartureCard[days]" has a null value in JSON.');
        assert(json.containsKey(r'destination'), 'Required key "DepartureCard[destination]" is missing from JSON.');
        assert(json.containsKey(r'cities'), 'Required key "DepartureCard[cities]" is missing from JSON.');
        assert(json[r'cities'] != null, 'Required key "DepartureCard[cities]" has a null value in JSON.');
        assert(json.containsKey(r'featured'), 'Required key "DepartureCard[featured]" is missing from JSON.');
        assert(json[r'featured'] != null, 'Required key "DepartureCard[featured]" has a null value in JSON.');
        assert(json.containsKey(r'provider'), 'Required key "DepartureCard[provider]" is missing from JSON.');
        assert(json[r'provider'] != null, 'Required key "DepartureCard[provider]" has a null value in JSON.');
        return true;
      }());

      return DepartureCard(
        departureId: mapValueOfType<String>(json, r'departureId')!,
        productId: mapValueOfType<String>(json, r'productId')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        status: DepartureCardStatusEnum.fromJson(json[r'status'])!,
        type: ProductType.fromJson(json[r'type'])!,
        title: mapValueOfType<String>(json, r'title')!,
        summary: mapValueOfType<String>(json, r'summary')!,
        cover: ImageUrls.fromJson(json[r'cover']),
        priceUsd: num.parse('${json[r'priceUsd']}'),
        seatsLeft: mapValueOfType<int>(json, r'seatsLeft')!,
        days: mapValueOfType<int>(json, r'days')!,
        destination: mapValueOfType<String>(json, r'destination'),
        cities: json[r'cities'] is Iterable
            ? (json[r'cities'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        featured: mapValueOfType<bool>(json, r'featured')!,
        provider: PublicProviderRef.fromJson(json[r'provider'])!,
      );
    }
    return null;
  }

  static List<DepartureCard> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureCard>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureCard.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DepartureCard> mapFromJson(dynamic json) {
    final map = <String, DepartureCard>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DepartureCard.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DepartureCard-objects as value to a dart map
  static Map<String, List<DepartureCard>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DepartureCard>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DepartureCard.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departureId',
    'productId',
    'date',
    'status',
    'type',
    'title',
    'summary',
    'cover',
    'priceUsd',
    'seatsLeft',
    'days',
    'destination',
    'cities',
    'featured',
    'provider',
  };
}


enum DepartureCardStatusEnum {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const DepartureCardStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DepartureCardStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DepartureCardStatusEnum? fromJson(dynamic value) => DepartureCardStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DepartureCardStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DepartureCardStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureCardStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureCardStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DepartureCardStatusEnum] to String,
/// and [decode] dynamic data back to [DepartureCardStatusEnum].
class DepartureCardStatusEnumTypeTransformer {
  factory DepartureCardStatusEnumTypeTransformer() => _instance ??= const DepartureCardStatusEnumTypeTransformer._();

  const DepartureCardStatusEnumTypeTransformer._();

  String encode(DepartureCardStatusEnum data) => data._value;

  /// Returns the instance of [DepartureCardStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DepartureCardStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DepartureCardStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return DepartureCardStatusEnum.open;
        case r'paused': return DepartureCardStatusEnum.paused;
        case r'closed': return DepartureCardStatusEnum.closed;
        case r'in_progress': return DepartureCardStatusEnum.inProgress;
        case r'finished': return DepartureCardStatusEnum.finished;
        case r'cancelled': return DepartureCardStatusEnum.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DepartureCardStatusEnumTypeTransformer? _instance;
}


