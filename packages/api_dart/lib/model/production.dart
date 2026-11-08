//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Production {
  /// Returns a new [Production] instance.
  Production({
    required this.departure,
    this.passengers = const [],
    this.meals = const [],
    this.items = const [],
    this.rooms = const [],
    this.restrictions = const [],
  });

  ProductionDeparture departure;

  List<ProductionPassengersInner> passengers;

  List<ProductionMealsInner> meals;

  List<ProductionItemsInner> items;

  List<ProductionRoomsInner> rooms;

  List<ProductionRestrictionsInner> restrictions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Production &&
    other.departure == departure &&
    _deepEquality.equals(other.passengers, passengers) &&
    _deepEquality.equals(other.meals, meals) &&
    _deepEquality.equals(other.items, items) &&
    _deepEquality.equals(other.rooms, rooms) &&
    _deepEquality.equals(other.restrictions, restrictions);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departure.hashCode) +
    (passengers.hashCode) +
    (meals.hashCode) +
    (items.hashCode) +
    (rooms.hashCode) +
    (restrictions.hashCode);

  @override
  String toString() => 'Production[departure=$departure, passengers=$passengers, meals=$meals, items=$items, rooms=$rooms, restrictions=$restrictions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departure'] = this.departure;
      json[r'passengers'] = this.passengers;
      json[r'meals'] = this.meals;
      json[r'items'] = this.items;
      json[r'rooms'] = this.rooms;
      json[r'restrictions'] = this.restrictions;
    return json;
  }

  /// Returns a new [Production] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Production? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departure'), 'Required key "Production[departure]" is missing from JSON.');
        assert(json[r'departure'] != null, 'Required key "Production[departure]" has a null value in JSON.');
        assert(json.containsKey(r'passengers'), 'Required key "Production[passengers]" is missing from JSON.');
        assert(json[r'passengers'] != null, 'Required key "Production[passengers]" has a null value in JSON.');
        assert(json.containsKey(r'meals'), 'Required key "Production[meals]" is missing from JSON.');
        assert(json[r'meals'] != null, 'Required key "Production[meals]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "Production[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "Production[items]" has a null value in JSON.');
        assert(json.containsKey(r'rooms'), 'Required key "Production[rooms]" is missing from JSON.');
        assert(json[r'rooms'] != null, 'Required key "Production[rooms]" has a null value in JSON.');
        assert(json.containsKey(r'restrictions'), 'Required key "Production[restrictions]" is missing from JSON.');
        assert(json[r'restrictions'] != null, 'Required key "Production[restrictions]" has a null value in JSON.');
        return true;
      }());

      return Production(
        departure: ProductionDeparture.fromJson(json[r'departure'])!,
        passengers: ProductionPassengersInner.listFromJson(json[r'passengers']),
        meals: ProductionMealsInner.listFromJson(json[r'meals']),
        items: ProductionItemsInner.listFromJson(json[r'items']),
        rooms: ProductionRoomsInner.listFromJson(json[r'rooms']),
        restrictions: ProductionRestrictionsInner.listFromJson(json[r'restrictions']),
      );
    }
    return null;
  }

  static List<Production> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Production>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Production.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Production> mapFromJson(dynamic json) {
    final map = <String, Production>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Production.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Production-objects as value to a dart map
  static Map<String, List<Production>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Production>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Production.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departure',
    'passengers',
    'meals',
    'items',
    'rooms',
    'restrictions',
  };
}

