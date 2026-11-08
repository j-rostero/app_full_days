//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BoardingPointUpdateInput {
  /// Returns a new [BoardingPointUpdateInput] instance.
  BoardingPointUpdateInput({
    this.city,
    this.name,
    this.address = '',
    this.lat,
    this.lng,
  });

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? city;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  String address;

  /// Minimum value: -90
  /// Maximum value: 90
  num? lat;

  /// Minimum value: -180
  /// Maximum value: 180
  num? lng;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BoardingPointUpdateInput &&
    other.city == city &&
    other.name == name &&
    other.address == address &&
    other.lat == lat &&
    other.lng == lng;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (city == null ? 0 : city!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (address.hashCode) +
    (lat == null ? 0 : lat!.hashCode) +
    (lng == null ? 0 : lng!.hashCode);

  @override
  String toString() => 'BoardingPointUpdateInput[city=$city, name=$name, address=$address, lat=$lat, lng=$lng]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.city != null) {
      json[r'city'] = this.city;
    } else {
      json[r'city'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
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

  /// Returns a new [BoardingPointUpdateInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BoardingPointUpdateInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return BoardingPointUpdateInput(
        city: mapValueOfType<String>(json, r'city'),
        name: mapValueOfType<String>(json, r'name'),
        address: mapValueOfType<String>(json, r'address') ?? '',
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

  static List<BoardingPointUpdateInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BoardingPointUpdateInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BoardingPointUpdateInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BoardingPointUpdateInput> mapFromJson(dynamic json) {
    final map = <String, BoardingPointUpdateInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BoardingPointUpdateInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BoardingPointUpdateInput-objects as value to a dart map
  static Map<String, List<BoardingPointUpdateInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BoardingPointUpdateInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BoardingPointUpdateInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}

