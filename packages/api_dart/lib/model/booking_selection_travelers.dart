//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingSelectionTravelers {
  /// Returns a new [BookingSelectionTravelers] instance.
  BookingSelectionTravelers({
    this.adult = 0,
    this.child = 0,
    this.senior = 0,
    this.infant = 0,
  });

  /// Minimum value: 0
  /// Maximum value: 20
  int adult;

  /// Minimum value: 0
  /// Maximum value: 20
  int child;

  /// Minimum value: 0
  /// Maximum value: 20
  int senior;

  /// Minimum value: 0
  /// Maximum value: 20
  int infant;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingSelectionTravelers &&
    other.adult == adult &&
    other.child == child &&
    other.senior == senior &&
    other.infant == infant;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (adult.hashCode) +
    (child.hashCode) +
    (senior.hashCode) +
    (infant.hashCode);

  @override
  String toString() => 'BookingSelectionTravelers[adult=$adult, child=$child, senior=$senior, infant=$infant]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'adult'] = this.adult;
      json[r'child'] = this.child;
      json[r'senior'] = this.senior;
      json[r'infant'] = this.infant;
    return json;
  }

  /// Returns a new [BookingSelectionTravelers] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingSelectionTravelers? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'adult'), 'Required key "BookingSelectionTravelers[adult]" is missing from JSON.');
        assert(json[r'adult'] != null, 'Required key "BookingSelectionTravelers[adult]" has a null value in JSON.');
        assert(json.containsKey(r'child'), 'Required key "BookingSelectionTravelers[child]" is missing from JSON.');
        assert(json[r'child'] != null, 'Required key "BookingSelectionTravelers[child]" has a null value in JSON.');
        assert(json.containsKey(r'senior'), 'Required key "BookingSelectionTravelers[senior]" is missing from JSON.');
        assert(json[r'senior'] != null, 'Required key "BookingSelectionTravelers[senior]" has a null value in JSON.');
        assert(json.containsKey(r'infant'), 'Required key "BookingSelectionTravelers[infant]" is missing from JSON.');
        assert(json[r'infant'] != null, 'Required key "BookingSelectionTravelers[infant]" has a null value in JSON.');
        return true;
      }());

      return BookingSelectionTravelers(
        adult: mapValueOfType<int>(json, r'adult')!,
        child: mapValueOfType<int>(json, r'child')!,
        senior: mapValueOfType<int>(json, r'senior')!,
        infant: mapValueOfType<int>(json, r'infant')!,
      );
    }
    return null;
  }

  static List<BookingSelectionTravelers> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingSelectionTravelers>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingSelectionTravelers.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingSelectionTravelers> mapFromJson(dynamic json) {
    final map = <String, BookingSelectionTravelers>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingSelectionTravelers.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingSelectionTravelers-objects as value to a dart map
  static Map<String, List<BookingSelectionTravelers>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingSelectionTravelers>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingSelectionTravelers.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'adult',
    'child',
    'senior',
    'infant',
  };
}

