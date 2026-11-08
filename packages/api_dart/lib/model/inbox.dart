//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Inbox {
  /// Returns a new [Inbox] instance.
  Inbox({
    required this.unread,
    this.items = const [],
  });

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int unread;

  List<InboxItemsInner> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Inbox &&
    other.unread == unread &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (unread.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'Inbox[unread=$unread, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'unread'] = this.unread;
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [Inbox] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Inbox? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'unread'), 'Required key "Inbox[unread]" is missing from JSON.');
        assert(json[r'unread'] != null, 'Required key "Inbox[unread]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "Inbox[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "Inbox[items]" has a null value in JSON.');
        return true;
      }());

      return Inbox(
        unread: mapValueOfType<int>(json, r'unread')!,
        items: InboxItemsInner.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<Inbox> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Inbox>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Inbox.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Inbox> mapFromJson(dynamic json) {
    final map = <String, Inbox>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Inbox.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Inbox-objects as value to a dart map
  static Map<String, List<Inbox>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Inbox>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Inbox.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'unread',
    'items',
  };
}

