//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Quote {
  /// Returns a new [Quote] instance.
  Quote({
    this.lines = const [],
    required this.totalUsd,
    required this.depositUsd,
    required this.seats,
    required this.balanceDueDate,
  });

  List<BookingLinesInner> lines;

  num totalUsd;

  num depositUsd;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seats;

  DateTime balanceDueDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Quote &&
    _deepEquality.equals(other.lines, lines) &&
    other.totalUsd == totalUsd &&
    other.depositUsd == depositUsd &&
    other.seats == seats &&
    other.balanceDueDate == balanceDueDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (lines.hashCode) +
    (totalUsd.hashCode) +
    (depositUsd.hashCode) +
    (seats.hashCode) +
    (balanceDueDate.hashCode);

  @override
  String toString() => 'Quote[lines=$lines, totalUsd=$totalUsd, depositUsd=$depositUsd, seats=$seats, balanceDueDate=$balanceDueDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'lines'] = this.lines;
      json[r'totalUsd'] = this.totalUsd;
      json[r'depositUsd'] = this.depositUsd;
      json[r'seats'] = this.seats;
      json[r'balanceDueDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.balanceDueDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.balanceDueDate);
    return json;
  }

  /// Returns a new [Quote] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Quote? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'lines'), 'Required key "Quote[lines]" is missing from JSON.');
        assert(json[r'lines'] != null, 'Required key "Quote[lines]" has a null value in JSON.');
        assert(json.containsKey(r'totalUsd'), 'Required key "Quote[totalUsd]" is missing from JSON.');
        assert(json[r'totalUsd'] != null, 'Required key "Quote[totalUsd]" has a null value in JSON.');
        assert(json.containsKey(r'depositUsd'), 'Required key "Quote[depositUsd]" is missing from JSON.');
        assert(json[r'depositUsd'] != null, 'Required key "Quote[depositUsd]" has a null value in JSON.');
        assert(json.containsKey(r'seats'), 'Required key "Quote[seats]" is missing from JSON.');
        assert(json[r'seats'] != null, 'Required key "Quote[seats]" has a null value in JSON.');
        assert(json.containsKey(r'balanceDueDate'), 'Required key "Quote[balanceDueDate]" is missing from JSON.');
        assert(json[r'balanceDueDate'] != null, 'Required key "Quote[balanceDueDate]" has a null value in JSON.');
        return true;
      }());

      return Quote(
        lines: BookingLinesInner.listFromJson(json[r'lines']),
        totalUsd: num.parse('${json[r'totalUsd']}'),
        depositUsd: num.parse('${json[r'depositUsd']}'),
        seats: mapValueOfType<int>(json, r'seats')!,
        balanceDueDate: mapDateTime(json, r'balanceDueDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
      );
    }
    return null;
  }

  static List<Quote> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Quote>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Quote.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Quote> mapFromJson(dynamic json) {
    final map = <String, Quote>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Quote.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Quote-objects as value to a dart map
  static Map<String, List<Quote>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Quote>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Quote.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'lines',
    'totalUsd',
    'depositUsd',
    'seats',
    'balanceDueDate',
  };
}

