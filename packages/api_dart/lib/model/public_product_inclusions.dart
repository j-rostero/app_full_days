//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProductInclusions {
  /// Returns a new [PublicProductInclusions] instance.
  PublicProductInclusions({
    this.included = const [],
    this.optional = const [],
    this.payAtDestination = const [],
    this.notIncluded = const [],
  });

  List<String> included;

  List<String> optional;

  List<String> payAtDestination;

  List<String> notIncluded;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProductInclusions &&
    _deepEquality.equals(other.included, included) &&
    _deepEquality.equals(other.optional, optional) &&
    _deepEquality.equals(other.payAtDestination, payAtDestination) &&
    _deepEquality.equals(other.notIncluded, notIncluded);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (included.hashCode) +
    (optional.hashCode) +
    (payAtDestination.hashCode) +
    (notIncluded.hashCode);

  @override
  String toString() => 'PublicProductInclusions[included=$included, optional=$optional, payAtDestination=$payAtDestination, notIncluded=$notIncluded]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'included'] = this.included;
      json[r'optional'] = this.optional;
      json[r'payAtDestination'] = this.payAtDestination;
      json[r'notIncluded'] = this.notIncluded;
    return json;
  }

  /// Returns a new [PublicProductInclusions] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProductInclusions? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'included'), 'Required key "PublicProductInclusions[included]" is missing from JSON.');
        assert(json[r'included'] != null, 'Required key "PublicProductInclusions[included]" has a null value in JSON.');
        assert(json.containsKey(r'optional'), 'Required key "PublicProductInclusions[optional]" is missing from JSON.');
        assert(json[r'optional'] != null, 'Required key "PublicProductInclusions[optional]" has a null value in JSON.');
        assert(json.containsKey(r'payAtDestination'), 'Required key "PublicProductInclusions[payAtDestination]" is missing from JSON.');
        assert(json[r'payAtDestination'] != null, 'Required key "PublicProductInclusions[payAtDestination]" has a null value in JSON.');
        assert(json.containsKey(r'notIncluded'), 'Required key "PublicProductInclusions[notIncluded]" is missing from JSON.');
        assert(json[r'notIncluded'] != null, 'Required key "PublicProductInclusions[notIncluded]" has a null value in JSON.');
        return true;
      }());

      return PublicProductInclusions(
        included: json[r'included'] is Iterable
            ? (json[r'included'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        optional: json[r'optional'] is Iterable
            ? (json[r'optional'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        payAtDestination: json[r'payAtDestination'] is Iterable
            ? (json[r'payAtDestination'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        notIncluded: json[r'notIncluded'] is Iterable
            ? (json[r'notIncluded'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<PublicProductInclusions> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProductInclusions>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProductInclusions.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProductInclusions> mapFromJson(dynamic json) {
    final map = <String, PublicProductInclusions>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProductInclusions.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProductInclusions-objects as value to a dart map
  static Map<String, List<PublicProductInclusions>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProductInclusions>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProductInclusions.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'included',
    'optional',
    'payAtDestination',
    'notIncluded',
  };
}

