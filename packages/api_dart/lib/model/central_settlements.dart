//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CentralSettlements {
  /// Returns a new [CentralSettlements] instance.
  CentralSettlements({
    required this.month,
    this.items = const [],
  });

  String month;

  List<CentralSettlementsItemsInner> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CentralSettlements &&
    other.month == month &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (month.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'CentralSettlements[month=$month, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'month'] = this.month;
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [CentralSettlements] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CentralSettlements? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'month'), 'Required key "CentralSettlements[month]" is missing from JSON.');
        assert(json[r'month'] != null, 'Required key "CentralSettlements[month]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "CentralSettlements[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "CentralSettlements[items]" has a null value in JSON.');
        return true;
      }());

      return CentralSettlements(
        month: mapValueOfType<String>(json, r'month')!,
        items: CentralSettlementsItemsInner.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<CentralSettlements> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CentralSettlements>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CentralSettlements.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CentralSettlements> mapFromJson(dynamic json) {
    final map = <String, CentralSettlements>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CentralSettlements.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CentralSettlements-objects as value to a dart map
  static Map<String, List<CentralSettlements>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CentralSettlements>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CentralSettlements.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'month',
    'items',
  };
}

