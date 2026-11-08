//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Departure {
  /// Returns a new [Departure] instance.
  Departure({
    required this.id,
    required this.productId,
    required this.productType,
    required this.title,
    required this.date,
    required this.status,
    required this.capacity,
    required this.minCapacity,
    required this.reserved,
    required this.seatsLeft,
    required this.adultPriceUsd,
    required this.priceUsd,
    this.guides = const [],
  });

  String id;

  String productId;

  ProductType productType;

  String title;

  DateTime date;

  DepartureStatus status;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int capacity;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int minCapacity;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int reserved;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seatsLeft;

  num? adultPriceUsd;

  num priceUsd;

  List<AuditEntryActor> guides;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Departure &&
    other.id == id &&
    other.productId == productId &&
    other.productType == productType &&
    other.title == title &&
    other.date == date &&
    other.status == status &&
    other.capacity == capacity &&
    other.minCapacity == minCapacity &&
    other.reserved == reserved &&
    other.seatsLeft == seatsLeft &&
    other.adultPriceUsd == adultPriceUsd &&
    other.priceUsd == priceUsd &&
    _deepEquality.equals(other.guides, guides);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (productId.hashCode) +
    (productType.hashCode) +
    (title.hashCode) +
    (date.hashCode) +
    (status.hashCode) +
    (capacity.hashCode) +
    (minCapacity.hashCode) +
    (reserved.hashCode) +
    (seatsLeft.hashCode) +
    (adultPriceUsd == null ? 0 : adultPriceUsd!.hashCode) +
    (priceUsd.hashCode) +
    (guides.hashCode);

  @override
  String toString() => 'Departure[id=$id, productId=$productId, productType=$productType, title=$title, date=$date, status=$status, capacity=$capacity, minCapacity=$minCapacity, reserved=$reserved, seatsLeft=$seatsLeft, adultPriceUsd=$adultPriceUsd, priceUsd=$priceUsd, guides=$guides]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'productId'] = this.productId;
      json[r'productType'] = this.productType;
      json[r'title'] = this.title;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'status'] = this.status;
      json[r'capacity'] = this.capacity;
      json[r'minCapacity'] = this.minCapacity;
      json[r'reserved'] = this.reserved;
      json[r'seatsLeft'] = this.seatsLeft;
    if (this.adultPriceUsd != null) {
      json[r'adultPriceUsd'] = this.adultPriceUsd;
    } else {
      json[r'adultPriceUsd'] = null;
    }
      json[r'priceUsd'] = this.priceUsd;
      json[r'guides'] = this.guides;
    return json;
  }

  /// Returns a new [Departure] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Departure? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Departure[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Departure[id]" has a null value in JSON.');
        assert(json.containsKey(r'productId'), 'Required key "Departure[productId]" is missing from JSON.');
        assert(json[r'productId'] != null, 'Required key "Departure[productId]" has a null value in JSON.');
        assert(json.containsKey(r'productType'), 'Required key "Departure[productType]" is missing from JSON.');
        assert(json[r'productType'] != null, 'Required key "Departure[productType]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Departure[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Departure[title]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "Departure[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "Departure[date]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "Departure[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Departure[status]" has a null value in JSON.');
        assert(json.containsKey(r'capacity'), 'Required key "Departure[capacity]" is missing from JSON.');
        assert(json[r'capacity'] != null, 'Required key "Departure[capacity]" has a null value in JSON.');
        assert(json.containsKey(r'minCapacity'), 'Required key "Departure[minCapacity]" is missing from JSON.');
        assert(json[r'minCapacity'] != null, 'Required key "Departure[minCapacity]" has a null value in JSON.');
        assert(json.containsKey(r'reserved'), 'Required key "Departure[reserved]" is missing from JSON.');
        assert(json[r'reserved'] != null, 'Required key "Departure[reserved]" has a null value in JSON.');
        assert(json.containsKey(r'seatsLeft'), 'Required key "Departure[seatsLeft]" is missing from JSON.');
        assert(json[r'seatsLeft'] != null, 'Required key "Departure[seatsLeft]" has a null value in JSON.');
        assert(json.containsKey(r'adultPriceUsd'), 'Required key "Departure[adultPriceUsd]" is missing from JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "Departure[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "Departure[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'guides'), 'Required key "Departure[guides]" is missing from JSON.');
        assert(json[r'guides'] != null, 'Required key "Departure[guides]" has a null value in JSON.');
        return true;
      }());

      return Departure(
        id: mapValueOfType<String>(json, r'id')!,
        productId: mapValueOfType<String>(json, r'productId')!,
        productType: ProductType.fromJson(json[r'productType'])!,
        title: mapValueOfType<String>(json, r'title')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        status: DepartureStatus.fromJson(json[r'status'])!,
        capacity: mapValueOfType<int>(json, r'capacity')!,
        minCapacity: mapValueOfType<int>(json, r'minCapacity')!,
        reserved: mapValueOfType<int>(json, r'reserved')!,
        seatsLeft: mapValueOfType<int>(json, r'seatsLeft')!,
        adultPriceUsd: json[r'adultPriceUsd'] == null
            ? null
            : num.parse('${json[r'adultPriceUsd']}'),
        priceUsd: num.parse('${json[r'priceUsd']}'),
        guides: AuditEntryActor.listFromJson(json[r'guides']),
      );
    }
    return null;
  }

  static List<Departure> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Departure>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Departure.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Departure> mapFromJson(dynamic json) {
    final map = <String, Departure>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Departure.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Departure-objects as value to a dart map
  static Map<String, List<Departure>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Departure>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Departure.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'productId',
    'productType',
    'title',
    'date',
    'status',
    'capacity',
    'minCapacity',
    'reserved',
    'seatsLeft',
    'adultPriceUsd',
    'priceUsd',
    'guides',
  };
}

