//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ThemeList {
  /// Returns a new [ThemeList] instance.
  ThemeList({
    this.items = const [],
  });

  List<TravelTheme> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ThemeList &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (items.hashCode);

  @override
  String toString() => 'ThemeList[items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [ThemeList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ThemeList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'items'), 'Required key "ThemeList[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "ThemeList[items]" has a null value in JSON.');
        return true;
      }());

      return ThemeList(
        items: TravelTheme.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<ThemeList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ThemeList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ThemeList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ThemeList> mapFromJson(dynamic json) {
    final map = <String, ThemeList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ThemeList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ThemeList-objects as value to a dart map
  static Map<String, List<ThemeList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ThemeList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ThemeList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'items',
  };
}

