//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class SignedIn {
  /// Returns a new [SignedIn] instance.
  SignedIn({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresIn,
    required this.user,
  });

  String accessToken;

  String refreshToken;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int expiresIn;

  Account user;

  @override
  bool operator ==(Object other) => identical(this, other) || other is SignedIn &&
    other.accessToken == accessToken &&
    other.refreshToken == refreshToken &&
    other.expiresIn == expiresIn &&
    other.user == user;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (accessToken.hashCode) +
    (refreshToken.hashCode) +
    (expiresIn.hashCode) +
    (user.hashCode);

  @override
  String toString() => 'SignedIn[accessToken=$accessToken, refreshToken=$refreshToken, expiresIn=$expiresIn, user=$user]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'accessToken'] = this.accessToken;
      json[r'refreshToken'] = this.refreshToken;
      json[r'expiresIn'] = this.expiresIn;
      json[r'user'] = this.user;
    return json;
  }

  /// Returns a new [SignedIn] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static SignedIn? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'accessToken'), 'Required key "SignedIn[accessToken]" is missing from JSON.');
        assert(json[r'accessToken'] != null, 'Required key "SignedIn[accessToken]" has a null value in JSON.');
        assert(json.containsKey(r'refreshToken'), 'Required key "SignedIn[refreshToken]" is missing from JSON.');
        assert(json[r'refreshToken'] != null, 'Required key "SignedIn[refreshToken]" has a null value in JSON.');
        assert(json.containsKey(r'expiresIn'), 'Required key "SignedIn[expiresIn]" is missing from JSON.');
        assert(json[r'expiresIn'] != null, 'Required key "SignedIn[expiresIn]" has a null value in JSON.');
        assert(json.containsKey(r'user'), 'Required key "SignedIn[user]" is missing from JSON.');
        assert(json[r'user'] != null, 'Required key "SignedIn[user]" has a null value in JSON.');
        return true;
      }());

      return SignedIn(
        accessToken: mapValueOfType<String>(json, r'accessToken')!,
        refreshToken: mapValueOfType<String>(json, r'refreshToken')!,
        expiresIn: mapValueOfType<int>(json, r'expiresIn')!,
        user: Account.fromJson(json[r'user'])!,
      );
    }
    return null;
  }

  static List<SignedIn> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <SignedIn>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = SignedIn.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, SignedIn> mapFromJson(dynamic json) {
    final map = <String, SignedIn>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = SignedIn.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of SignedIn-objects as value to a dart map
  static Map<String, List<SignedIn>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<SignedIn>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = SignedIn.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'accessToken',
    'refreshToken',
    'expiresIn',
    'user',
  };
}

