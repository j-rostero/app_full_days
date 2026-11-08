//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingLinesInner {
  /// Returns a new [BookingLinesInner] instance.
  BookingLinesInner({
    required this.label,
    required this.amountUsd,
  });

  String label;

  num amountUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingLinesInner &&
    other.label == label &&
    other.amountUsd == amountUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (label.hashCode) +
    (amountUsd.hashCode);

  @override
  String toString() => 'BookingLinesInner[label=$label, amountUsd=$amountUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'label'] = this.label;
      json[r'amountUsd'] = this.amountUsd;
    return json;
  }

  /// Returns a new [BookingLinesInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingLinesInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'label'), 'Required key "BookingLinesInner[label]" is missing from JSON.');
        assert(json[r'label'] != null, 'Required key "BookingLinesInner[label]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "BookingLinesInner[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "BookingLinesInner[amountUsd]" has a null value in JSON.');
        return true;
      }());

      return BookingLinesInner(
        label: mapValueOfType<String>(json, r'label')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
      );
    }
    return null;
  }

  static List<BookingLinesInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingLinesInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingLinesInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingLinesInner> mapFromJson(dynamic json) {
    final map = <String, BookingLinesInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingLinesInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingLinesInner-objects as value to a dart map
  static Map<String, List<BookingLinesInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingLinesInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingLinesInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'label',
    'amountUsd',
  };
}

