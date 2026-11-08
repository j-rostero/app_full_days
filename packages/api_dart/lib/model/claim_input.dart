//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ClaimInput {
  /// Returns a new [ClaimInput] instance.
  ClaimInput({
    required this.subject,
    required this.message,
  });

  String subject;

  String message;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ClaimInput &&
    other.subject == subject &&
    other.message == message;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (subject.hashCode) +
    (message.hashCode);

  @override
  String toString() => 'ClaimInput[subject=$subject, message=$message]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'subject'] = this.subject;
      json[r'message'] = this.message;
    return json;
  }

  /// Returns a new [ClaimInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ClaimInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'subject'), 'Required key "ClaimInput[subject]" is missing from JSON.');
        assert(json[r'subject'] != null, 'Required key "ClaimInput[subject]" has a null value in JSON.');
        assert(json.containsKey(r'message'), 'Required key "ClaimInput[message]" is missing from JSON.');
        assert(json[r'message'] != null, 'Required key "ClaimInput[message]" has a null value in JSON.');
        return true;
      }());

      return ClaimInput(
        subject: mapValueOfType<String>(json, r'subject')!,
        message: mapValueOfType<String>(json, r'message')!,
      );
    }
    return null;
  }

  static List<ClaimInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClaimInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClaimInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ClaimInput> mapFromJson(dynamic json) {
    final map = <String, ClaimInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ClaimInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ClaimInput-objects as value to a dart map
  static Map<String, List<ClaimInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ClaimInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ClaimInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'subject',
    'message',
  };
}

