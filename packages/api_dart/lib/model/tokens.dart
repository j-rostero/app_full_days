//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Tokens {
  /// Returns a new [Tokens] instance.
  Tokens({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
  });

  String accessToken;

  String refreshToken;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int expiresIn;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Tokens &&
    other.accessToken == accessToken &&
    other.refreshToken == refreshToken &&
    other.expiresIn == expiresIn;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken.hashCode) +
    (refreshToken.hashCode) +
    (expiresIn.hashCode);

  @override
  String toString() => 'Tokens[accessToken=$accessToken, refreshToken=$refreshToken, expiresIn=$expiresIn]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accessToken'] = this.accessToken;
      json[r'refreshToken'] = this.refreshToken;
      json[r'expiresIn'] = this.expiresIn;
    return json;
  }

  /// Returns a new [Tokens] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Tokens? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accessToken'), 'Required key "Tokens[accessToken]" is missing from JSON.');
        assert(json[r'accessToken'] != null, 'Required key "Tokens[accessToken]" has a null value in JSON.');
        assert(json.containsKey(r'refreshToken'), 'Required key "Tokens[refreshToken]" is missing from JSON.');
        assert(json[r'refreshToken'] != null, 'Required key "Tokens[refreshToken]" has a null value in JSON.');
        assert(json.containsKey(r'expiresIn'), 'Required key "Tokens[expiresIn]" is missing from JSON.');
        assert(json[r'expiresIn'] != null, 'Required key "Tokens[expiresIn]" has a null value in JSON.');
        return true;
      }());

      return Tokens(
        accessToken: mapValueOfType<String>(json, r'accessToken')!,
        refreshToken: mapValueOfType<String>(json, r'refreshToken')!,
        expiresIn: mapValueOfType<int>(json, r'expiresIn')!,
      );
    }
    return null;
  }

  static List<Tokens> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Tokens>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Tokens.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Tokens> mapFromJson(dynamic json) {
    final map = <String, Tokens>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Tokens.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Tokens-objects as value to a dart map
  static Map<String, List<Tokens>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Tokens>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Tokens.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accessToken',
    'refreshToken',
    'expiresIn',
  };
}

