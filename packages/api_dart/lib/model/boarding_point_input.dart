//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BoardingPointInput {
  /// Returns a new [BoardingPointInput] instance.
  BoardingPointInput({
    required this.city,
    required this.name,
    this.address = '',
    required this.lat,
    required this.lng,
  });

  String city;

  String name;

  String address;

  /// Minimum value: -90
  /// Maximum value: 90
  num? lat;

  /// Minimum value: -180
  /// Maximum value: 180
  num? lng;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BoardingPointInput &&
    other.city == city &&
    other.name == name &&
    other.address == address &&
    other.lat == lat &&
    other.lng == lng;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (city.hashCode) +
    (name.hashCode) +
    (address.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lng == null ? 0 : lng!.hashCode);

  @override
  String toString() => 'BoardingPointInput[city=$city, name=$name, address=$address, lat=$lat, lng=$lng]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'city'] = this.city;
      json[r'name'] = this.name;
      json[r'address'] = this.address;
    if (this.lat != null) {
      json[r'lat'] = this.lat;
    } else {
      json[r'lat'] = null;
    }
    if (this.lng != null) {
      json[r'lng'] = this.lng;
    } else {
      json[r'lng'] = null;
    }
    return json;
  }

  /// Returns a new [BoardingPointInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BoardingPointInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'city'), 'Required key "BoardingPointInput[city]" is missing from JSON.');
        assert(json[r'city'] != null, 'Required key "BoardingPointInput[city]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "BoardingPointInput[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "BoardingPointInput[name]" has a null value in JSON.');
        assert(json.containsKey(r'address'), 'Required key "BoardingPointInput[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "BoardingPointInput[address]" has a null value in JSON.');
        assert(json.containsKey(r'lat'), 'Required key "BoardingPointInput[lat]" is missing from JSON.');
        assert(json.containsKey(r'lng'), 'Required key "BoardingPointInput[lng]" is missing from JSON.');
        return true;
      }());

      return BoardingPointInput(
        city: mapValueOfType<String>(json, r'city')!,
        name: mapValueOfType<String>(json, r'name')!,
        address: mapValueOfType<String>(json, r'address')!,
        lat: json[r'lat'] == null
            ? null
            : num.parse('${json[r'lat']}'),
        lng: json[r'lng'] == null
            ? null
            : num.parse('${json[r'lng']}'),
      );
    }
    return null;
  }

  static List<BoardingPointInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BoardingPointInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BoardingPointInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BoardingPointInput> mapFromJson(dynamic json) {
    final map = <String, BoardingPointInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BoardingPointInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BoardingPointInput-objects as value to a dart map
  static Map<String, List<BoardingPointInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BoardingPointInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BoardingPointInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'city',
    'name',
    'address',
    'lat',
    'lng',
  };
}

