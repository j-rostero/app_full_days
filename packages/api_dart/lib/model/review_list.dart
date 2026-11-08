//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReviewList {
  /// Returns a new [ReviewList] instance.
  ReviewList({
    required this.reputation,
    this.items = const [],
  });

  Reputation reputation;

  List<Review> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReviewList &&
    other.reputation == reputation &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (reputation.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'ReviewList[reputation=$reputation, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'reputation'] = this.reputation;
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [ReviewList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReviewList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'reputation'), 'Required key "ReviewList[reputation]" is missing from JSON.');
        assert(json[r'reputation'] != null, 'Required key "ReviewList[reputation]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "ReviewList[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "ReviewList[items]" has a null value in JSON.');
        return true;
      }());

      return ReviewList(
        reputation: Reputation.fromJson(json[r'reputation'])!,
        items: Review.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<ReviewList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReviewList> mapFromJson(dynamic json) {
    final map = <String, ReviewList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReviewList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReviewList-objects as value to a dart map
  static Map<String, List<ReviewList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReviewList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReviewList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'reputation',
    'items',
  };
}

