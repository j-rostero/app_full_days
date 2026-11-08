//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Cancellation {
  /// Returns a new [Cancellation] instance.
  Cancellation({
    required this.allowed,
    required this.amountUsd,
    required this.rule,
    required this.daysBefore,
  });

  bool allowed;

  num amountUsd;

  String rule;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int daysBefore;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Cancellation &&
    other.allowed == allowed &&
    other.amountUsd == amountUsd &&
    other.rule == rule &&
    other.daysBefore == daysBefore;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (allowed.hashCode) +
    (amountUsd.hashCode) +
    (rule.hashCode) +
    (daysBefore.hashCode);

  @override
  String toString() => 'Cancellation[allowed=$allowed, amountUsd=$amountUsd, rule=$rule, daysBefore=$daysBefore]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'allowed'] = this.allowed;
      json[r'amountUsd'] = this.amountUsd;
      json[r'rule'] = this.rule;
      json[r'daysBefore'] = this.daysBefore;
    return json;
  }

  /// Returns a new [Cancellation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Cancellation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'allowed'), 'Required key "Cancellation[allowed]" is missing from JSON.');
        assert(json[r'allowed'] != null, 'Required key "Cancellation[allowed]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "Cancellation[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "Cancellation[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'rule'), 'Required key "Cancellation[rule]" is missing from JSON.');
        assert(json[r'rule'] != null, 'Required key "Cancellation[rule]" has a null value in JSON.');
        assert(json.containsKey(r'daysBefore'), 'Required key "Cancellation[daysBefore]" is missing from JSON.');
        assert(json[r'daysBefore'] != null, 'Required key "Cancellation[daysBefore]" has a null value in JSON.');
        return true;
      }());

      return Cancellation(
        allowed: mapValueOfType<bool>(json, r'allowed')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        rule: mapValueOfType<String>(json, r'rule')!,
        daysBefore: mapValueOfType<int>(json, r'daysBefore')!,
      );
    }
    return null;
  }

  static List<Cancellation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Cancellation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Cancellation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Cancellation> mapFromJson(dynamic json) {
    final map = <String, Cancellation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Cancellation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Cancellation-objects as value to a dart map
  static Map<String, List<Cancellation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Cancellation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Cancellation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'allowed',
    'amountUsd',
    'rule',
    'daysBefore',
  };
}

