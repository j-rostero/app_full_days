//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class TodayDeparture {
  /// Returns a new [TodayDeparture] instance.
  TodayDeparture({
    required this.id,
    required this.date,
    required this.title,
    required this.productType,
    required this.status,
    required this.passengers,
    required this.boarded,
    this.guides = const [],
  });

  String id;

  DateTime date;

  String title;

  ProductType productType;

  DepartureStatus status;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int passengers;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int boarded;

  List<AuditEntryActor> guides;

  @override
  bool operator ==(Object other) => identical(this, other) || other is TodayDeparture &&
    other.id == id &&
    other.date == date &&
    other.title == title &&
    other.productType == productType &&
    other.status == status &&
    other.passengers == passengers &&
    other.boarded == boarded &&
    _deepEquality.equals(other.guides, guides);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (date.hashCode) +
    (title.hashCode) +
    (productType.hashCode) +
    (status.hashCode) +
    (passengers.hashCode) +
    (boarded.hashCode) +
    (guides.hashCode);

  @override
  String toString() => 'TodayDeparture[id=$id, date=$date, title=$title, productType=$productType, status=$status, passengers=$passengers, boarded=$boarded, guides=$guides]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'title'] = this.title;
      json[r'productType'] = this.productType;
      json[r'status'] = this.status;
      json[r'passengers'] = this.passengers;
      json[r'boarded'] = this.boarded;
      json[r'guides'] = this.guides;
    return json;
  }

  /// Returns a new [TodayDeparture] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static TodayDeparture? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "TodayDeparture[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "TodayDeparture[id]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "TodayDeparture[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "TodayDeparture[date]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "TodayDeparture[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "TodayDeparture[title]" has a null value in JSON.');
        assert(json.containsKey(r'productType'), 'Required key "TodayDeparture[productType]" is missing from JSON.');
        assert(json[r'productType'] != null, 'Required key "TodayDeparture[productType]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "TodayDeparture[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "TodayDeparture[status]" has a null value in JSON.');
        assert(json.containsKey(r'passengers'), 'Required key "TodayDeparture[passengers]" is missing from JSON.');
        assert(json[r'passengers'] != null, 'Required key "TodayDeparture[passengers]" has a null value in JSON.');
        assert(json.containsKey(r'boarded'), 'Required key "TodayDeparture[boarded]" is missing from JSON.');
        assert(json[r'boarded'] != null, 'Required key "TodayDeparture[boarded]" has a null value in JSON.');
        assert(json.containsKey(r'guides'), 'Required key "TodayDeparture[guides]" is missing from JSON.');
        assert(json[r'guides'] != null, 'Required key "TodayDeparture[guides]" has a null value in JSON.');
        return true;
      }());

      return TodayDeparture(
        id: mapValueOfType<String>(json, r'id')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        title: mapValueOfType<String>(json, r'title')!,
        productType: ProductType.fromJson(json[r'productType'])!,
        status: DepartureStatus.fromJson(json[r'status'])!,
        passengers: mapValueOfType<int>(json, r'passengers')!,
        boarded: mapValueOfType<int>(json, r'boarded')!,
        guides: AuditEntryActor.listFromJson(json[r'guides']),
      );
    }
    return null;
  }

  static List<TodayDeparture> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <TodayDeparture>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = TodayDeparture.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, TodayDeparture> mapFromJson(dynamic json) {
    final map = <String, TodayDeparture>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = TodayDeparture.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of TodayDeparture-objects as value to a dart map
  static Map<String, List<TodayDeparture>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<TodayDeparture>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = TodayDeparture.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'date',
    'title',
    'productType',
    'status',
    'passengers',
    'boarded',
    'guides',
  };
}

