//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Rate {
  /// Returns a new [Rate] instance.
  Rate({
    required this.date,
    required this.bsPerUsd,
  });

  DateTime date;

  num bsPerUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Rate &&
    other.date == date &&
    other.bsPerUsd == bsPerUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (date.hashCode) +
    (bsPerUsd.hashCode);

  @override
  String toString() => 'Rate[date=$date, bsPerUsd=$bsPerUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'bsPerUsd'] = this.bsPerUsd;
    return json;
  }

  /// Returns a new [Rate] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Rate? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'date'), 'Required key "Rate[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "Rate[date]" has a null value in JSON.');
        assert(json.containsKey(r'bsPerUsd'), 'Required key "Rate[bsPerUsd]" is missing from JSON.');
        assert(json[r'bsPerUsd'] != null, 'Required key "Rate[bsPerUsd]" has a null value in JSON.');
        return true;
      }());

      return Rate(
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        bsPerUsd: num.parse('${json[r'bsPerUsd']}'),
      );
    }
    return null;
  }

  static List<Rate> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Rate>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Rate.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Rate> mapFromJson(dynamic json) {
    final map = <String, Rate>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Rate.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Rate-objects as value to a dart map
  static Map<String, List<Rate>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Rate>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Rate.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'date',
    'bsPerUsd',
  };
}

