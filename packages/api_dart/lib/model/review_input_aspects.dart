//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReviewInputAspects {
  /// Returns a new [ReviewInputAspects] instance.
  ReviewInputAspects({
    this.punctuality,
    this.transport,
    this.food,
    this.guide,
    this.value,
  });

  /// Minimum value: 1
  /// Maximum value: 5
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? punctuality;

  /// Minimum value: 1
  /// Maximum value: 5
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? transport;

  /// Minimum value: 1
  /// Maximum value: 5
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? food;

  /// Minimum value: 1
  /// Maximum value: 5
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? guide;

  /// Minimum value: 1
  /// Maximum value: 5
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReviewInputAspects &&
    other.punctuality == punctuality &&
    other.transport == transport &&
    other.food == food &&
    other.guide == guide &&
    other.value == value;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (punctuality == null ? 0 : punctuality!.hashCode) +
    (transport == null ? 0 : transport!.hashCode) +
    (food == null ? 0 : food!.hashCode) +
    (guide == null ? 0 : guide!.hashCode) +
    (value == null ? 0 : value!.hashCode);

  @override
  String toString() => 'ReviewInputAspects[punctuality=$punctuality, transport=$transport, food=$food, guide=$guide, value=$value]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.punctuality != null) {
      json[r'punctuality'] = this.punctuality;
    } else {
      json[r'punctuality'] = null;
    }
    if (this.transport != null) {
      json[r'transport'] = this.transport;
    } else {
      json[r'transport'] = null;
    }
    if (this.food != null) {
      json[r'food'] = this.food;
    } else {
      json[r'food'] = null;
    }
    if (this.guide != null) {
      json[r'guide'] = this.guide;
    } else {
      json[r'guide'] = null;
    }
    if (this.value != null) {
      json[r'value'] = this.value;
    } else {
      json[r'value'] = null;
    }
    return json;
  }

  /// Returns a new [ReviewInputAspects] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReviewInputAspects? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ReviewInputAspects(
        punctuality: mapValueOfType<int>(json, r'punctuality'),
        transport: mapValueOfType<int>(json, r'transport'),
        food: mapValueOfType<int>(json, r'food'),
        guide: mapValueOfType<int>(json, r'guide'),
        value: mapValueOfType<int>(json, r'value'),
      );
    }
    return null;
  }

  static List<ReviewInputAspects> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewInputAspects>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewInputAspects.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReviewInputAspects> mapFromJson(dynamic json) {
    final map = <String, ReviewInputAspects>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReviewInputAspects.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReviewInputAspects-objects as value to a dart map
  static Map<String, List<ReviewInputAspects>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReviewInputAspects>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReviewInputAspects.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

