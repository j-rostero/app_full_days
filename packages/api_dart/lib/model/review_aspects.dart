//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReviewAspects {
  /// Returns a new [ReviewAspects] instance.
  ReviewAspects({
    this.punctuality,
    this.transport,
    this.food,
    this.guide,
    this.value,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? punctuality;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? transport;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? food;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? guide;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? value;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReviewAspects &&
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
  String toString() => 'ReviewAspects[punctuality=$punctuality, transport=$transport, food=$food, guide=$guide, value=$value]';

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

  /// Returns a new [ReviewAspects] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReviewAspects? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ReviewAspects(
        punctuality: json[r'punctuality'] == null
            ? null
            : num.parse('${json[r'punctuality']}'),
        transport: json[r'transport'] == null
            ? null
            : num.parse('${json[r'transport']}'),
        food: json[r'food'] == null
            ? null
            : num.parse('${json[r'food']}'),
        guide: json[r'guide'] == null
            ? null
            : num.parse('${json[r'guide']}'),
        value: json[r'value'] == null
            ? null
            : num.parse('${json[r'value']}'),
      );
    }
    return null;
  }

  static List<ReviewAspects> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewAspects>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewAspects.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReviewAspects> mapFromJson(dynamic json) {
    final map = <String, ReviewAspects>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReviewAspects.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReviewAspects-objects as value to a dart map
  static Map<String, List<ReviewAspects>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReviewAspects>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReviewAspects.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

