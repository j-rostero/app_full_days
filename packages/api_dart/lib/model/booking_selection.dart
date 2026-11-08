//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingSelection {
  /// Returns a new [BookingSelection] instance.
  BookingSelection({
    required this.boardingId,
    required this.travelers,
    this.rooms = const [],
    this.mealIds = const [],
    this.itemIds = const [],
  });

  String boardingId;

  BookingSelectionTravelers travelers;

  List<BookingSelectionRoomsInner> rooms;

  List<String> mealIds;

  List<String> itemIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingSelection &&
    other.boardingId == boardingId &&
    other.travelers == travelers &&
    _deepEquality.equals(other.rooms, rooms) &&
    _deepEquality.equals(other.mealIds, mealIds) &&
    _deepEquality.equals(other.itemIds, itemIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (boardingId.hashCode) +
    (travelers.hashCode) +
    (rooms.hashCode) +
    (mealIds.hashCode) +
    (itemIds.hashCode);

  @override
  String toString() => 'BookingSelection[boardingId=$boardingId, travelers=$travelers, rooms=$rooms, mealIds=$mealIds, itemIds=$itemIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'boardingId'] = this.boardingId;
      json[r'travelers'] = this.travelers;
      json[r'rooms'] = this.rooms;
      json[r'mealIds'] = this.mealIds;
      json[r'itemIds'] = this.itemIds;
    return json;
  }

  /// Returns a new [BookingSelection] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingSelection? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'boardingId'), 'Required key "BookingSelection[boardingId]" is missing from JSON.');
        assert(json[r'boardingId'] != null, 'Required key "BookingSelection[boardingId]" has a null value in JSON.');
        assert(json.containsKey(r'travelers'), 'Required key "BookingSelection[travelers]" is missing from JSON.');
        assert(json[r'travelers'] != null, 'Required key "BookingSelection[travelers]" has a null value in JSON.');
        assert(json.containsKey(r'rooms'), 'Required key "BookingSelection[rooms]" is missing from JSON.');
        assert(json[r'rooms'] != null, 'Required key "BookingSelection[rooms]" has a null value in JSON.');
        assert(json.containsKey(r'mealIds'), 'Required key "BookingSelection[mealIds]" is missing from JSON.');
        assert(json[r'mealIds'] != null, 'Required key "BookingSelection[mealIds]" has a null value in JSON.');
        assert(json.containsKey(r'itemIds'), 'Required key "BookingSelection[itemIds]" is missing from JSON.');
        assert(json[r'itemIds'] != null, 'Required key "BookingSelection[itemIds]" has a null value in JSON.');
        return true;
      }());

      return BookingSelection(
        boardingId: mapValueOfType<String>(json, r'boardingId')!,
        travelers: BookingSelectionTravelers.fromJson(json[r'travelers'])!,
        rooms: BookingSelectionRoomsInner.listFromJson(json[r'rooms']),
        mealIds: json[r'mealIds'] is Iterable
            ? (json[r'mealIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        itemIds: json[r'itemIds'] is Iterable
            ? (json[r'itemIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<BookingSelection> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingSelection>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingSelection.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingSelection> mapFromJson(dynamic json) {
    final map = <String, BookingSelection>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingSelection.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingSelection-objects as value to a dart map
  static Map<String, List<BookingSelection>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingSelection>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingSelection.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'boardingId',
    'travelers',
    'rooms',
    'mealIds',
    'itemIds',
  };
}

