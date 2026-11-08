//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ScheduleDeparturesInput {
  /// Returns a new [ScheduleDeparturesInput] instance.
  ScheduleDeparturesInput({
    required this.productId,
    this.dates = const [],
    required this.capacity,
    this.minCapacity = 1,
    required this.adultPriceUsd,
  });

  String productId;

  List<String> dates;

  /// Minimum value: 1
  /// Maximum value: 1000
  int capacity;

  /// Minimum value: 1
  /// Maximum value: 1000
  int minCapacity;

  /// Minimum value: 0.01
  /// Maximum value: 100000
  num? adultPriceUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ScheduleDeparturesInput &&
    other.productId == productId &&
    _deepEquality.equals(other.dates, dates) &&
    other.capacity == capacity &&
    other.minCapacity == minCapacity &&
    other.adultPriceUsd == adultPriceUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (productId.hashCode) +
    (dates.hashCode) +
    (capacity.hashCode) +
    (minCapacity.hashCode) +
    (adultPriceUsd == null ? 0 : adultPriceUsd!.hashCode);

  @override
  String toString() => 'ScheduleDeparturesInput[productId=$productId, dates=$dates, capacity=$capacity, minCapacity=$minCapacity, adultPriceUsd=$adultPriceUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'productId'] = this.productId;
      json[r'dates'] = this.dates;
      json[r'capacity'] = this.capacity;
      json[r'minCapacity'] = this.minCapacity;
    if (this.adultPriceUsd != null) {
      json[r'adultPriceUsd'] = this.adultPriceUsd;
    } else {
      json[r'adultPriceUsd'] = null;
    }
    return json;
  }

  /// Returns a new [ScheduleDeparturesInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ScheduleDeparturesInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'productId'), 'Required key "ScheduleDeparturesInput[productId]" is missing from JSON.');
        assert(json[r'productId'] != null, 'Required key "ScheduleDeparturesInput[productId]" has a null value in JSON.');
        assert(json.containsKey(r'dates'), 'Required key "ScheduleDeparturesInput[dates]" is missing from JSON.');
        assert(json[r'dates'] != null, 'Required key "ScheduleDeparturesInput[dates]" has a null value in JSON.');
        assert(json.containsKey(r'capacity'), 'Required key "ScheduleDeparturesInput[capacity]" is missing from JSON.');
        assert(json[r'capacity'] != null, 'Required key "ScheduleDeparturesInput[capacity]" has a null value in JSON.');
        assert(json.containsKey(r'minCapacity'), 'Required key "ScheduleDeparturesInput[minCapacity]" is missing from JSON.');
        assert(json[r'minCapacity'] != null, 'Required key "ScheduleDeparturesInput[minCapacity]" has a null value in JSON.');
        assert(json.containsKey(r'adultPriceUsd'), 'Required key "ScheduleDeparturesInput[adultPriceUsd]" is missing from JSON.');
        return true;
      }());

      return ScheduleDeparturesInput(
        productId: mapValueOfType<String>(json, r'productId')!,
        dates: json[r'dates'] is Iterable
            ? (json[r'dates'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        capacity: mapValueOfType<int>(json, r'capacity')!,
        minCapacity: mapValueOfType<int>(json, r'minCapacity')!,
        adultPriceUsd: json[r'adultPriceUsd'] == null
            ? null
            : num.parse('${json[r'adultPriceUsd']}'),
      );
    }
    return null;
  }

  static List<ScheduleDeparturesInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ScheduleDeparturesInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ScheduleDeparturesInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ScheduleDeparturesInput> mapFromJson(dynamic json) {
    final map = <String, ScheduleDeparturesInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ScheduleDeparturesInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ScheduleDeparturesInput-objects as value to a dart map
  static Map<String, List<ScheduleDeparturesInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ScheduleDeparturesInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ScheduleDeparturesInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'productId',
    'dates',
    'capacity',
    'minCapacity',
    'adultPriceUsd',
  };
}

