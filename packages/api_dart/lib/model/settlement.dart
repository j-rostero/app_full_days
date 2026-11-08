//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Settlement {
  /// Returns a new [Settlement] instance.
  Settlement({
    required this.month,
    required this.paymentsUsd,
    required this.refundsUsd,
    required this.commissionUsd,
    required this.netUsd,
    this.lines = const [],
  });

  String month;

  num paymentsUsd;

  num refundsUsd;

  num commissionUsd;

  num netUsd;

  List<SettlementLinesInner> lines;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Settlement &&
    other.month == month &&
    other.paymentsUsd == paymentsUsd &&
    other.refundsUsd == refundsUsd &&
    other.commissionUsd == commissionUsd &&
    other.netUsd == netUsd &&
    _deepEquality.equals(other.lines, lines);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (month.hashCode) +
    (paymentsUsd.hashCode) +
    (refundsUsd.hashCode) +
    (commissionUsd.hashCode) +
    (netUsd.hashCode) +
    (lines.hashCode);

  @override
  String toString() => 'Settlement[month=$month, paymentsUsd=$paymentsUsd, refundsUsd=$refundsUsd, commissionUsd=$commissionUsd, netUsd=$netUsd, lines=$lines]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'month'] = this.month;
      json[r'paymentsUsd'] = this.paymentsUsd;
      json[r'refundsUsd'] = this.refundsUsd;
      json[r'commissionUsd'] = this.commissionUsd;
      json[r'netUsd'] = this.netUsd;
      json[r'lines'] = this.lines;
    return json;
  }

  /// Returns a new [Settlement] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Settlement? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'month'), 'Required key "Settlement[month]" is missing from JSON.');
        assert(json[r'month'] != null, 'Required key "Settlement[month]" has a null value in JSON.');
        assert(json.containsKey(r'paymentsUsd'), 'Required key "Settlement[paymentsUsd]" is missing from JSON.');
        assert(json[r'paymentsUsd'] != null, 'Required key "Settlement[paymentsUsd]" has a null value in JSON.');
        assert(json.containsKey(r'refundsUsd'), 'Required key "Settlement[refundsUsd]" is missing from JSON.');
        assert(json[r'refundsUsd'] != null, 'Required key "Settlement[refundsUsd]" has a null value in JSON.');
        assert(json.containsKey(r'commissionUsd'), 'Required key "Settlement[commissionUsd]" is missing from JSON.');
        assert(json[r'commissionUsd'] != null, 'Required key "Settlement[commissionUsd]" has a null value in JSON.');
        assert(json.containsKey(r'netUsd'), 'Required key "Settlement[netUsd]" is missing from JSON.');
        assert(json[r'netUsd'] != null, 'Required key "Settlement[netUsd]" has a null value in JSON.');
        assert(json.containsKey(r'lines'), 'Required key "Settlement[lines]" is missing from JSON.');
        assert(json[r'lines'] != null, 'Required key "Settlement[lines]" has a null value in JSON.');
        return true;
      }());

      return Settlement(
        month: mapValueOfType<String>(json, r'month')!,
        paymentsUsd: num.parse('${json[r'paymentsUsd']}'),
        refundsUsd: num.parse('${json[r'refundsUsd']}'),
        commissionUsd: num.parse('${json[r'commissionUsd']}'),
        netUsd: num.parse('${json[r'netUsd']}'),
        lines: SettlementLinesInner.listFromJson(json[r'lines']),
      );
    }
    return null;
  }

  static List<Settlement> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Settlement>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Settlement.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Settlement> mapFromJson(dynamic json) {
    final map = <String, Settlement>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Settlement.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Settlement-objects as value to a dart map
  static Map<String, List<Settlement>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Settlement>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Settlement.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'month',
    'paymentsUsd',
    'refundsUsd',
    'commissionUsd',
    'netUsd',
    'lines',
  };
}

