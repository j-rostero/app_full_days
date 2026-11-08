//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Metrics {
  /// Returns a new [Metrics] instance.
  Metrics({
    required this.from,
    required this.to,
    required this.bookings,
    required this.confirmed,
    required this.gmvUsd,
    required this.commissionUsd,
    required this.occupancyPercent,
    required this.sellingProviders,
    required this.searches,
    this.topSearches = const [],
    this.emptySearches = const [],
  });

  DateTime from;

  DateTime to;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int bookings;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int confirmed;

  num gmvUsd;

  num commissionUsd;

  num? occupancyPercent;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int sellingProviders;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int searches;

  List<MetricsTopSearchesInner> topSearches;

  List<MetricsTopSearchesInner> emptySearches;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Metrics &&
    other.from == from &&
    other.to == to &&
    other.bookings == bookings &&
    other.confirmed == confirmed &&
    other.gmvUsd == gmvUsd &&
    other.commissionUsd == commissionUsd &&
    other.occupancyPercent == occupancyPercent &&
    other.sellingProviders == sellingProviders &&
    other.searches == searches &&
    _deepEquality.equals(other.topSearches, topSearches) &&
    _deepEquality.equals(other.emptySearches, emptySearches);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (from.hashCode) +
    (to.hashCode) +
    (bookings.hashCode) +
    (confirmed.hashCode) +
    (gmvUsd.hashCode) +
    (commissionUsd.hashCode) +
    (occupancyPercent == null ? 0 : occupancyPercent!.hashCode) +
    (sellingProviders.hashCode) +
    (searches.hashCode) +
    (topSearches.hashCode) +
    (emptySearches.hashCode);

  @override
  String toString() => 'Metrics[from=$from, to=$to, bookings=$bookings, confirmed=$confirmed, gmvUsd=$gmvUsd, commissionUsd=$commissionUsd, occupancyPercent=$occupancyPercent, sellingProviders=$sellingProviders, searches=$searches, topSearches=$topSearches, emptySearches=$emptySearches]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'from'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.from.millisecondsSinceEpoch
        : _dateFormatter.format(this.from);
      json[r'to'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.to.millisecondsSinceEpoch
        : _dateFormatter.format(this.to);
      json[r'bookings'] = this.bookings;
      json[r'confirmed'] = this.confirmed;
      json[r'gmvUsd'] = this.gmvUsd;
      json[r'commissionUsd'] = this.commissionUsd;
    if (this.occupancyPercent != null) {
      json[r'occupancyPercent'] = this.occupancyPercent;
    } else {
      json[r'occupancyPercent'] = null;
    }
      json[r'sellingProviders'] = this.sellingProviders;
      json[r'searches'] = this.searches;
      json[r'topSearches'] = this.topSearches;
      json[r'emptySearches'] = this.emptySearches;
    return json;
  }

  /// Returns a new [Metrics] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Metrics? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'from'), 'Required key "Metrics[from]" is missing from JSON.');
        assert(json[r'from'] != null, 'Required key "Metrics[from]" has a null value in JSON.');
        assert(json.containsKey(r'to'), 'Required key "Metrics[to]" is missing from JSON.');
        assert(json[r'to'] != null, 'Required key "Metrics[to]" has a null value in JSON.');
        assert(json.containsKey(r'bookings'), 'Required key "Metrics[bookings]" is missing from JSON.');
        assert(json[r'bookings'] != null, 'Required key "Metrics[bookings]" has a null value in JSON.');
        assert(json.containsKey(r'confirmed'), 'Required key "Metrics[confirmed]" is missing from JSON.');
        assert(json[r'confirmed'] != null, 'Required key "Metrics[confirmed]" has a null value in JSON.');
        assert(json.containsKey(r'gmvUsd'), 'Required key "Metrics[gmvUsd]" is missing from JSON.');
        assert(json[r'gmvUsd'] != null, 'Required key "Metrics[gmvUsd]" has a null value in JSON.');
        assert(json.containsKey(r'commissionUsd'), 'Required key "Metrics[commissionUsd]" is missing from JSON.');
        assert(json[r'commissionUsd'] != null, 'Required key "Metrics[commissionUsd]" has a null value in JSON.');
        assert(json.containsKey(r'occupancyPercent'), 'Required key "Metrics[occupancyPercent]" is missing from JSON.');
        assert(json.containsKey(r'sellingProviders'), 'Required key "Metrics[sellingProviders]" is missing from JSON.');
        assert(json[r'sellingProviders'] != null, 'Required key "Metrics[sellingProviders]" has a null value in JSON.');
        assert(json.containsKey(r'searches'), 'Required key "Metrics[searches]" is missing from JSON.');
        assert(json[r'searches'] != null, 'Required key "Metrics[searches]" has a null value in JSON.');
        assert(json.containsKey(r'topSearches'), 'Required key "Metrics[topSearches]" is missing from JSON.');
        assert(json[r'topSearches'] != null, 'Required key "Metrics[topSearches]" has a null value in JSON.');
        assert(json.containsKey(r'emptySearches'), 'Required key "Metrics[emptySearches]" is missing from JSON.');
        assert(json[r'emptySearches'] != null, 'Required key "Metrics[emptySearches]" has a null value in JSON.');
        return true;
      }());

      return Metrics(
        from: mapDateTime(json, r'from', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        to: mapDateTime(json, r'to', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        bookings: mapValueOfType<int>(json, r'bookings')!,
        confirmed: mapValueOfType<int>(json, r'confirmed')!,
        gmvUsd: num.parse('${json[r'gmvUsd']}'),
        commissionUsd: num.parse('${json[r'commissionUsd']}'),
        occupancyPercent: json[r'occupancyPercent'] == null
            ? null
            : num.parse('${json[r'occupancyPercent']}'),
        sellingProviders: mapValueOfType<int>(json, r'sellingProviders')!,
        searches: mapValueOfType<int>(json, r'searches')!,
        topSearches: MetricsTopSearchesInner.listFromJson(json[r'topSearches']),
        emptySearches: MetricsTopSearchesInner.listFromJson(json[r'emptySearches']),
      );
    }
    return null;
  }

  static List<Metrics> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Metrics>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Metrics.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Metrics> mapFromJson(dynamic json) {
    final map = <String, Metrics>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Metrics.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Metrics-objects as value to a dart map
  static Map<String, List<Metrics>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Metrics>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Metrics.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'from',
    'to',
    'bookings',
    'confirmed',
    'gmvUsd',
    'commissionUsd',
    'occupancyPercent',
    'sellingProviders',
    'searches',
    'topSearches',
    'emptySearches',
  };
}

