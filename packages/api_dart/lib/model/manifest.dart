//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Manifest {
  /// Returns a new [Manifest] instance.
  Manifest({
    required this.departure,
    this.keys = const [],
    this.passengers = const [],
    this.discarded = const [],
  });

  ManifestDeparture departure;

  List<VoucherKey> keys;

  List<ManifestPassenger> passengers;

  List<ManifestDiscardedInner> discarded;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Manifest &&
    other.departure == departure &&
    _deepEquality.equals(other.keys, keys) &&
    _deepEquality.equals(other.passengers, passengers) &&
    _deepEquality.equals(other.discarded, discarded);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departure.hashCode) +
    (keys.hashCode) +
    (passengers.hashCode) +
    (discarded.hashCode);

  @override
  String toString() => 'Manifest[departure=$departure, keys=$keys, passengers=$passengers, discarded=$discarded]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departure'] = this.departure;
      json[r'keys'] = this.keys;
      json[r'passengers'] = this.passengers;
      json[r'discarded'] = this.discarded;
    return json;
  }

  /// Returns a new [Manifest] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Manifest? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departure'), 'Required key "Manifest[departure]" is missing from JSON.');
        assert(json[r'departure'] != null, 'Required key "Manifest[departure]" has a null value in JSON.');
        assert(json.containsKey(r'keys'), 'Required key "Manifest[keys]" is missing from JSON.');
        assert(json[r'keys'] != null, 'Required key "Manifest[keys]" has a null value in JSON.');
        assert(json.containsKey(r'passengers'), 'Required key "Manifest[passengers]" is missing from JSON.');
        assert(json[r'passengers'] != null, 'Required key "Manifest[passengers]" has a null value in JSON.');
        assert(json.containsKey(r'discarded'), 'Required key "Manifest[discarded]" is missing from JSON.');
        assert(json[r'discarded'] != null, 'Required key "Manifest[discarded]" has a null value in JSON.');
        return true;
      }());

      return Manifest(
        departure: ManifestDeparture.fromJson(json[r'departure'])!,
        keys: VoucherKey.listFromJson(json[r'keys']),
        passengers: ManifestPassenger.listFromJson(json[r'passengers']),
        discarded: ManifestDiscardedInner.listFromJson(json[r'discarded']),
      );
    }
    return null;
  }

  static List<Manifest> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Manifest>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Manifest.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Manifest> mapFromJson(dynamic json) {
    final map = <String, Manifest>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Manifest.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Manifest-objects as value to a dart map
  static Map<String, List<Manifest>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Manifest>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Manifest.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departure',
    'keys',
    'passengers',
    'discarded',
  };
}

