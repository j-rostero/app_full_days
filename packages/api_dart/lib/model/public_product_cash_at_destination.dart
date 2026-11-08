//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProductCashAtDestination {
  /// Returns a new [PublicProductCashAtDestination] instance.
  PublicProductCashAtDestination({
    required this.totalUsd,
    this.concepts = const [],
  });

  num totalUsd;

  List<String> concepts;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProductCashAtDestination &&
    other.totalUsd == totalUsd &&
    _deepEquality.equals(other.concepts, concepts);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (totalUsd.hashCode) +
    (concepts.hashCode);

  @override
  String toString() => 'PublicProductCashAtDestination[totalUsd=$totalUsd, concepts=$concepts]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'totalUsd'] = this.totalUsd;
      json[r'concepts'] = this.concepts;
    return json;
  }

  /// Returns a new [PublicProductCashAtDestination] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProductCashAtDestination? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'totalUsd'), 'Required key "PublicProductCashAtDestination[totalUsd]" is missing from JSON.');
        assert(json[r'totalUsd'] != null, 'Required key "PublicProductCashAtDestination[totalUsd]" has a null value in JSON.');
        assert(json.containsKey(r'concepts'), 'Required key "PublicProductCashAtDestination[concepts]" is missing from JSON.');
        assert(json[r'concepts'] != null, 'Required key "PublicProductCashAtDestination[concepts]" has a null value in JSON.');
        return true;
      }());

      return PublicProductCashAtDestination(
        totalUsd: num.parse('${json[r'totalUsd']}'),
        concepts: json[r'concepts'] is Iterable
            ? (json[r'concepts'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<PublicProductCashAtDestination> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProductCashAtDestination>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProductCashAtDestination.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProductCashAtDestination> mapFromJson(dynamic json) {
    final map = <String, PublicProductCashAtDestination>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProductCashAtDestination.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProductCashAtDestination-objects as value to a dart map
  static Map<String, List<PublicProductCashAtDestination>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProductCashAtDestination>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProductCashAtDestination.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'totalUsd',
    'concepts',
  };
}

