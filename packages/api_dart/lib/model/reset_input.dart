//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ResetInput {
  /// Returns a new [ResetInput] instance.
  ResetInput({
    required this.email,
    required this.code,
    required this.password,
  });

  String email;

  String code;

  String password;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ResetInput &&
    other.email == email &&
    other.code == code &&
    other.password == password;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (email.hashCode) +
    (code.hashCode) +
    (password.hashCode);

  @override
  String toString() => 'ResetInput[email=$email, code=$code, password=$password]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'email'] = this.email;
      json[r'code'] = this.code;
      json[r'password'] = this.password;
    return json;
  }

  /// Returns a new [ResetInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ResetInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'email'), 'Required key "ResetInput[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "ResetInput[email]" has a null value in JSON.');
        assert(json.containsKey(r'code'), 'Required key "ResetInput[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "ResetInput[code]" has a null value in JSON.');
        assert(json.containsKey(r'password'), 'Required key "ResetInput[password]" is missing from JSON.');
        assert(json[r'password'] != null, 'Required key "ResetInput[password]" has a null value in JSON.');
        return true;
      }());

      return ResetInput(
        email: mapValueOfType<String>(json, r'email')!,
        code: mapValueOfType<String>(json, r'code')!,
        password: mapValueOfType<String>(json, r'password')!,
      );
    }
    return null;
  }

  static List<ResetInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ResetInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ResetInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ResetInput> mapFromJson(dynamic json) {
    final map = <String, ResetInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ResetInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ResetInput-objects as value to a dart map
  static Map<String, List<ResetInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ResetInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ResetInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'email',
    'code',
    'password',
  };
}

