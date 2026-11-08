//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BoardingPoint {
  /// Returns a new [BoardingPoint] instance.
  BoardingPoint({
    required this.id,
    required this.city,
    required this.name,
    required this.address,
    required this.lat,
    required this.lng,
  });

  String id;

  String city;

  String name;

  String address;

  num? lat;

  num? lng;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BoardingPoint &&
    other.id == id &&
    other.city == city &&
    other.name == name &&
    other.address == address &&
    other.lat == lat &&
    other.lng == lng;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (city.hashCode) +
    (name.hashCode) +
    (address.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lng == null ? 0 : lng!.hashCode);

  @override
  String toString() => 'BoardingPoint[id=$id, city=$city, name=$name, address=$address, lat=$lat, lng=$lng]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
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

  /// Returns a new [BoardingPoint] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BoardingPoint? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "BoardingPoint[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "BoardingPoint[id]" has a null value in JSON.');
        assert(json.containsKey(r'city'), 'Required key "BoardingPoint[city]" is missing from JSON.');
        assert(json[r'city'] != null, 'Required key "BoardingPoint[city]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "BoardingPoint[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "BoardingPoint[name]" has a null value in JSON.');
        assert(json.containsKey(r'address'), 'Required key "BoardingPoint[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "BoardingPoint[address]" has a null value in JSON.');
        assert(json.containsKey(r'lat'), 'Required key "BoardingPoint[lat]" is missing from JSON.');
        assert(json.containsKey(r'lng'), 'Required key "BoardingPoint[lng]" is missing from JSON.');
        return true;
      }());

      return BoardingPoint(
        id: mapValueOfType<String>(json, r'id')!,
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

  static List<BoardingPoint> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BoardingPoint>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BoardingPoint.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BoardingPoint> mapFromJson(dynamic json) {
    final map = <String, BoardingPoint>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BoardingPoint.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BoardingPoint-objects as value to a dart map
  static Map<String, List<BoardingPoint>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BoardingPoint>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BoardingPoint.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'city',
    'name',
    'address',
    'lat',
    'lng',
  };
}

