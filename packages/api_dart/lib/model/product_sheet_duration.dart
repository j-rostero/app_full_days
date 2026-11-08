//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetDuration {
  /// Returns a new [ProductSheetDuration] instance.
  ProductSheetDuration({
    this.days = 1,
    this.nights = 0,
    required this.hours,
  });

  /// Minimum value: 1
  /// Maximum value: 30
  int days;

  /// Minimum value: 0
  /// Maximum value: 29
  int nights;

  /// Minimum value: 1
  /// Maximum value: 24
  num? hours;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetDuration &&
    other.days == days &&
    other.nights == nights &&
    other.hours == hours;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (days.hashCode) +
    (nights.hashCode) +
    (hours == null ? 0 : hours!.hashCode);

  @override
  String toString() => 'ProductSheetDuration[days=$days, nights=$nights, hours=$hours]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'days'] = this.days;
      json[r'nights'] = this.nights;
    if (this.hours != null) {
      json[r'hours'] = this.hours;
    } else {
      json[r'hours'] = null;
    }
    return json;
  }

  /// Returns a new [ProductSheetDuration] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetDuration? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'days'), 'Required key "ProductSheetDuration[days]" is missing from JSON.');
        assert(json[r'days'] != null, 'Required key "ProductSheetDuration[days]" has a null value in JSON.');
        assert(json.containsKey(r'nights'), 'Required key "ProductSheetDuration[nights]" is missing from JSON.');
        assert(json[r'nights'] != null, 'Required key "ProductSheetDuration[nights]" has a null value in JSON.');
        assert(json.containsKey(r'hours'), 'Required key "ProductSheetDuration[hours]" is missing from JSON.');
        return true;
      }());

      return ProductSheetDuration(
        days: mapValueOfType<int>(json, r'days')!,
        nights: mapValueOfType<int>(json, r'nights')!,
        hours: json[r'hours'] == null
            ? null
            : num.parse('${json[r'hours']}'),
      );
    }
    return null;
  }

  static List<ProductSheetDuration> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetDuration>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetDuration.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetDuration> mapFromJson(dynamic json) {
    final map = <String, ProductSheetDuration>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetDuration.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetDuration-objects as value to a dart map
  static Map<String, List<ProductSheetDuration>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetDuration>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetDuration.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'days',
    'nights',
    'hours',
  };
}

