//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Reputation {
  /// Returns a new [Reputation] instance.
  Reputation({
    required this.average,
    required this.count,
    required this.asDescribedPercent,
    required this.aspects,
  });

  num? average;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int count;

  num? asDescribedPercent;

  ReviewAspects aspects;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Reputation &&
    other.average == average &&
    other.count == count &&
    other.asDescribedPercent == asDescribedPercent &&
    other.aspects == aspects;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (average == null ? 0 : average!.hashCode) +
    (count.hashCode) +
    (asDescribedPercent == null ? 0 : asDescribedPercent!.hashCode) +
    (aspects.hashCode);

  @override
  String toString() => 'Reputation[average=$average, count=$count, asDescribedPercent=$asDescribedPercent, aspects=$aspects]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.average != null) {
      json[r'average'] = this.average;
    } else {
      json[r'average'] = null;
    }
      json[r'count'] = this.count;
    if (this.asDescribedPercent != null) {
      json[r'asDescribedPercent'] = this.asDescribedPercent;
    } else {
      json[r'asDescribedPercent'] = null;
    }
      json[r'aspects'] = this.aspects;
    return json;
  }

  /// Returns a new [Reputation] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Reputation? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'average'), 'Required key "Reputation[average]" is missing from JSON.');
        assert(json.containsKey(r'count'), 'Required key "Reputation[count]" is missing from JSON.');
        assert(json[r'count'] != null, 'Required key "Reputation[count]" has a null value in JSON.');
        assert(json.containsKey(r'asDescribedPercent'), 'Required key "Reputation[asDescribedPercent]" is missing from JSON.');
        assert(json.containsKey(r'aspects'), 'Required key "Reputation[aspects]" is missing from JSON.');
        assert(json[r'aspects'] != null, 'Required key "Reputation[aspects]" has a null value in JSON.');
        return true;
      }());

      return Reputation(
        average: json[r'average'] == null
            ? null
            : num.parse('${json[r'average']}'),
        count: mapValueOfType<int>(json, r'count')!,
        asDescribedPercent: json[r'asDescribedPercent'] == null
            ? null
            : num.parse('${json[r'asDescribedPercent']}'),
        aspects: ReviewAspects.fromJson(json[r'aspects'])!,
      );
    }
    return null;
  }

  static List<Reputation> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Reputation>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Reputation.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Reputation> mapFromJson(dynamic json) {
    final map = <String, Reputation>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Reputation.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Reputation-objects as value to a dart map
  static Map<String, List<Reputation>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Reputation>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Reputation.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'average',
    'count',
    'asDescribedPercent',
    'aspects',
  };
}

