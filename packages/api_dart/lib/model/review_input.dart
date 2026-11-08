//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReviewInput {
  /// Returns a new [ReviewInput] instance.
  ReviewInput({
    required this.rating,
    required this.aspects,
    required this.asDescribed,
    this.comment = '',
  });

  /// Minimum value: 1
  /// Maximum value: 5
  int rating;

  ReviewInputAspects aspects;

  bool asDescribed;

  String comment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReviewInput &&
    other.rating == rating &&
    other.aspects == aspects &&
    other.asDescribed == asDescribed &&
    other.comment == comment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (rating.hashCode) +
    (aspects.hashCode) +
    (asDescribed.hashCode) +
    (comment.hashCode);

  @override
  String toString() => 'ReviewInput[rating=$rating, aspects=$aspects, asDescribed=$asDescribed, comment=$comment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'rating'] = this.rating;
      json[r'aspects'] = this.aspects;
      json[r'asDescribed'] = this.asDescribed;
      json[r'comment'] = this.comment;
    return json;
  }

  /// Returns a new [ReviewInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReviewInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'rating'), 'Required key "ReviewInput[rating]" is missing from JSON.');
        assert(json[r'rating'] != null, 'Required key "ReviewInput[rating]" has a null value in JSON.');
        assert(json.containsKey(r'aspects'), 'Required key "ReviewInput[aspects]" is missing from JSON.');
        assert(json[r'aspects'] != null, 'Required key "ReviewInput[aspects]" has a null value in JSON.');
        assert(json.containsKey(r'asDescribed'), 'Required key "ReviewInput[asDescribed]" is missing from JSON.');
        assert(json[r'asDescribed'] != null, 'Required key "ReviewInput[asDescribed]" has a null value in JSON.');
        assert(json.containsKey(r'comment'), 'Required key "ReviewInput[comment]" is missing from JSON.');
        assert(json[r'comment'] != null, 'Required key "ReviewInput[comment]" has a null value in JSON.');
        return true;
      }());

      return ReviewInput(
        rating: mapValueOfType<int>(json, r'rating')!,
        aspects: ReviewInputAspects.fromJson(json[r'aspects'])!,
        asDescribed: mapValueOfType<bool>(json, r'asDescribed')!,
        comment: mapValueOfType<String>(json, r'comment')!,
      );
    }
    return null;
  }

  static List<ReviewInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReviewInput> mapFromJson(dynamic json) {
    final map = <String, ReviewInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReviewInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReviewInput-objects as value to a dart map
  static Map<String, List<ReviewInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReviewInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReviewInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'rating',
    'aspects',
    'asDescribed',
    'comment',
  };
}

