//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderReport {
  /// Returns a new [ProviderReport] instance.
  ProviderReport({
    required this.month,
    required this.salesUsd,
    required this.confirmedBookings,
    required this.cancellations,
    required this.occupancyPercent,
    required this.reputation,
  });

  String month;

  num salesUsd;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int confirmedBookings;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int cancellations;

  num? occupancyPercent;

  Reputation reputation;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderReport &&
    other.month == month &&
    other.salesUsd == salesUsd &&
    other.confirmedBookings == confirmedBookings &&
    other.cancellations == cancellations &&
    other.occupancyPercent == occupancyPercent &&
    other.reputation == reputation;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (month.hashCode) +
    (salesUsd.hashCode) +
    (confirmedBookings.hashCode) +
    (cancellations.hashCode) +
    (occupancyPercent == null ? 0 : occupancyPercent!.hashCode) +
    (reputation.hashCode);

  @override
  String toString() => 'ProviderReport[month=$month, salesUsd=$salesUsd, confirmedBookings=$confirmedBookings, cancellations=$cancellations, occupancyPercent=$occupancyPercent, reputation=$reputation]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'month'] = this.month;
      json[r'salesUsd'] = this.salesUsd;
      json[r'confirmedBookings'] = this.confirmedBookings;
      json[r'cancellations'] = this.cancellations;
    if (this.occupancyPercent != null) {
      json[r'occupancyPercent'] = this.occupancyPercent;
    } else {
      json[r'occupancyPercent'] = null;
    }
      json[r'reputation'] = this.reputation;
    return json;
  }

  /// Returns a new [ProviderReport] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderReport? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'month'), 'Required key "ProviderReport[month]" is missing from JSON.');
        assert(json[r'month'] != null, 'Required key "ProviderReport[month]" has a null value in JSON.');
        assert(json.containsKey(r'salesUsd'), 'Required key "ProviderReport[salesUsd]" is missing from JSON.');
        assert(json[r'salesUsd'] != null, 'Required key "ProviderReport[salesUsd]" has a null value in JSON.');
        assert(json.containsKey(r'confirmedBookings'), 'Required key "ProviderReport[confirmedBookings]" is missing from JSON.');
        assert(json[r'confirmedBookings'] != null, 'Required key "ProviderReport[confirmedBookings]" has a null value in JSON.');
        assert(json.containsKey(r'cancellations'), 'Required key "ProviderReport[cancellations]" is missing from JSON.');
        assert(json[r'cancellations'] != null, 'Required key "ProviderReport[cancellations]" has a null value in JSON.');
        assert(json.containsKey(r'occupancyPercent'), 'Required key "ProviderReport[occupancyPercent]" is missing from JSON.');
        assert(json.containsKey(r'reputation'), 'Required key "ProviderReport[reputation]" is missing from JSON.');
        assert(json[r'reputation'] != null, 'Required key "ProviderReport[reputation]" has a null value in JSON.');
        return true;
      }());

      return ProviderReport(
        month: mapValueOfType<String>(json, r'month')!,
        salesUsd: num.parse('${json[r'salesUsd']}'),
        confirmedBookings: mapValueOfType<int>(json, r'confirmedBookings')!,
        cancellations: mapValueOfType<int>(json, r'cancellations')!,
        occupancyPercent: json[r'occupancyPercent'] == null
            ? null
            : num.parse('${json[r'occupancyPercent']}'),
        reputation: Reputation.fromJson(json[r'reputation'])!,
      );
    }
    return null;
  }

  static List<ProviderReport> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderReport>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderReport.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderReport> mapFromJson(dynamic json) {
    final map = <String, ProviderReport>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderReport.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderReport-objects as value to a dart map
  static Map<String, List<ProviderReport>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderReport>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderReport.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'month',
    'salesUsd',
    'confirmedBookings',
    'cancellations',
    'occupancyPercent',
    'reputation',
  };
}

