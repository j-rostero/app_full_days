//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionDeparture {
  /// Returns a new [ProductionDeparture] instance.
  ProductionDeparture({
    required this.id,
    required this.date,
    required this.title,
  });

  String id;

  DateTime date;

  String title;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionDeparture &&
    other.id == id &&
    other.date == date &&
    other.title == title;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (date.hashCode) +
    (title.hashCode);

  @override
  String toString() => 'ProductionDeparture[id=$id, date=$date, title=$title]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'title'] = this.title;
    return json;
  }

  /// Returns a new [ProductionDeparture] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionDeparture? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductionDeparture[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductionDeparture[id]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "ProductionDeparture[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "ProductionDeparture[date]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "ProductionDeparture[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "ProductionDeparture[title]" has a null value in JSON.');
        return true;
      }());

      return ProductionDeparture(
        id: mapValueOfType<String>(json, r'id')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        title: mapValueOfType<String>(json, r'title')!,
      );
    }
    return null;
  }

  static List<ProductionDeparture> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionDeparture>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionDeparture.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionDeparture> mapFromJson(dynamic json) {
    final map = <String, ProductionDeparture>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionDeparture.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionDeparture-objects as value to a dart map
  static Map<String, List<ProductionDeparture>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionDeparture>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionDeparture.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'date',
    'title',
  };
}

