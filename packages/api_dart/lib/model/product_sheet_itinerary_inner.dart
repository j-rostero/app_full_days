//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetItineraryInner {
  /// Returns a new [ProductSheetItineraryInner] instance.
  ProductSheetItineraryInner({
    this.day = 1,
    required this.time,
    required this.title,
    this.description = '',
  });

  /// Minimum value: 1
  /// Maximum value: 30
  int day;

  String? time;

  String title;

  String description;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetItineraryInner &&
    other.day == day &&
    other.time == time &&
    other.title == title &&
    other.description == description;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (day.hashCode) +
    (time == null ? 0 : time!.hashCode) +
    (title.hashCode) +
    (description.hashCode);

  @override
  String toString() => 'ProductSheetItineraryInner[day=$day, time=$time, title=$title, description=$description]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'day'] = this.day;
    if (this.time != null) {
      json[r'time'] = this.time;
    } else {
      json[r'time'] = null;
    }
      json[r'title'] = this.title;
      json[r'description'] = this.description;
    return json;
  }

  /// Returns a new [ProductSheetItineraryInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetItineraryInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'day'), 'Required key "ProductSheetItineraryInner[day]" is missing from JSON.');
        assert(json[r'day'] != null, 'Required key "ProductSheetItineraryInner[day]" has a null value in JSON.');
        assert(json.containsKey(r'time'), 'Required key "ProductSheetItineraryInner[time]" is missing from JSON.');
        assert(json.containsKey(r'title'), 'Required key "ProductSheetItineraryInner[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "ProductSheetItineraryInner[title]" has a null value in JSON.');
        assert(json.containsKey(r'description'), 'Required key "ProductSheetItineraryInner[description]" is missing from JSON.');
        assert(json[r'description'] != null, 'Required key "ProductSheetItineraryInner[description]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetItineraryInner(
        day: mapValueOfType<int>(json, r'day')!,
        time: mapValueOfType<String>(json, r'time'),
        title: mapValueOfType<String>(json, r'title')!,
        description: mapValueOfType<String>(json, r'description')!,
      );
    }
    return null;
  }

  static List<ProductSheetItineraryInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetItineraryInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetItineraryInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetItineraryInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetItineraryInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetItineraryInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetItineraryInner-objects as value to a dart map
  static Map<String, List<ProductSheetItineraryInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetItineraryInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetItineraryInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'day',
    'time',
    'title',
    'description',
  };
}

