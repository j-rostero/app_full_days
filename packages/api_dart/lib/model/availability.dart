//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Availability {
  /// Returns a new [Availability] instance.
  Availability({
    required this.departure,
    required this.type,
    required this.title,
    required this.sheet,
    required this.provider,
    this.roomsLeft = const {},
  });

  AvailabilityDeparture departure;

  ProductType type;

  String title;

  ProductSheet sheet;

  PublicProviderRef provider;

  Map<String, int> roomsLeft;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Availability &&
    other.departure == departure &&
    other.type == type &&
    other.title == title &&
    other.sheet == sheet &&
    other.provider == provider &&
    _deepEquality.equals(other.roomsLeft, roomsLeft);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departure.hashCode) +
    (type.hashCode) +
    (title.hashCode) +
    (sheet.hashCode) +
    (provider.hashCode) +
    (roomsLeft.hashCode);

  @override
  String toString() => 'Availability[departure=$departure, type=$type, title=$title, sheet=$sheet, provider=$provider, roomsLeft=$roomsLeft]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departure'] = this.departure;
      json[r'type'] = this.type;
      json[r'title'] = this.title;
      json[r'sheet'] = this.sheet;
      json[r'provider'] = this.provider;
      json[r'roomsLeft'] = this.roomsLeft;
    return json;
  }

  /// Returns a new [Availability] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Availability? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departure'), 'Required key "Availability[departure]" is missing from JSON.');
        assert(json[r'departure'] != null, 'Required key "Availability[departure]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "Availability[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "Availability[type]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Availability[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Availability[title]" has a null value in JSON.');
        assert(json.containsKey(r'sheet'), 'Required key "Availability[sheet]" is missing from JSON.');
        assert(json[r'sheet'] != null, 'Required key "Availability[sheet]" has a null value in JSON.');
        assert(json.containsKey(r'provider'), 'Required key "Availability[provider]" is missing from JSON.');
        assert(json[r'provider'] != null, 'Required key "Availability[provider]" has a null value in JSON.');
        assert(json.containsKey(r'roomsLeft'), 'Required key "Availability[roomsLeft]" is missing from JSON.');
        assert(json[r'roomsLeft'] != null, 'Required key "Availability[roomsLeft]" has a null value in JSON.');
        return true;
      }());

      return Availability(
        departure: AvailabilityDeparture.fromJson(json[r'departure'])!,
        type: ProductType.fromJson(json[r'type'])!,
        title: mapValueOfType<String>(json, r'title')!,
        sheet: ProductSheet.fromJson(json[r'sheet'])!,
        provider: PublicProviderRef.fromJson(json[r'provider'])!,
        roomsLeft: mapCastOfType<String, int>(json, r'roomsLeft')!,
      );
    }
    return null;
  }

  static List<Availability> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Availability>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Availability.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Availability> mapFromJson(dynamic json) {
    final map = <String, Availability>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Availability.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Availability-objects as value to a dart map
  static Map<String, List<Availability>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Availability>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Availability.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departure',
    'type',
    'title',
    'sheet',
    'provider',
    'roomsLeft',
  };
}

