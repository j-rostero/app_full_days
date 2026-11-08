//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class InboxItemsInner {
  /// Returns a new [InboxItemsInner] instance.
  InboxItemsInner({
    required this.id,
    required this.event,
    required this.title,
    required this.body,
    required this.link,
    required this.read,
    required this.createdAt,
  });

  String id;

  String event;

  String title;

  String body;

  String? link;

  bool read;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is InboxItemsInner &&
    other.id == id &&
    other.event == event &&
    other.title == title &&
    other.body == body &&
    other.link == link &&
    other.read == read &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (event.hashCode) +
    (title.hashCode) +
    (body.hashCode) +
    (link == null ? 0 : link!.hashCode) +
    (read.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'InboxItemsInner[id=$id, event=$event, title=$title, body=$body, link=$link, read=$read, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'event'] = this.event;
      json[r'title'] = this.title;
      json[r'body'] = this.body;
    if (this.link != null) {
      json[r'link'] = this.link;
    } else {
      json[r'link'] = null;
    }
      json[r'read'] = this.read;
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [InboxItemsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static InboxItemsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "InboxItemsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "InboxItemsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'event'), 'Required key "InboxItemsInner[event]" is missing from JSON.');
        assert(json[r'event'] != null, 'Required key "InboxItemsInner[event]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "InboxItemsInner[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "InboxItemsInner[title]" has a null value in JSON.');
        assert(json.containsKey(r'body'), 'Required key "InboxItemsInner[body]" is missing from JSON.');
        assert(json[r'body'] != null, 'Required key "InboxItemsInner[body]" has a null value in JSON.');
        assert(json.containsKey(r'link'), 'Required key "InboxItemsInner[link]" is missing from JSON.');
        assert(json.containsKey(r'read'), 'Required key "InboxItemsInner[read]" is missing from JSON.');
        assert(json[r'read'] != null, 'Required key "InboxItemsInner[read]" has a null value in JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "InboxItemsInner[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "InboxItemsInner[createdAt]" has a null value in JSON.');
        return true;
      }());

      return InboxItemsInner(
        id: mapValueOfType<String>(json, r'id')!,
        event: mapValueOfType<String>(json, r'event')!,
        title: mapValueOfType<String>(json, r'title')!,
        body: mapValueOfType<String>(json, r'body')!,
        link: mapValueOfType<String>(json, r'link'),
        read: mapValueOfType<bool>(json, r'read')!,
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<InboxItemsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <InboxItemsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = InboxItemsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, InboxItemsInner> mapFromJson(dynamic json) {
    final map = <String, InboxItemsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = InboxItemsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of InboxItemsInner-objects as value to a dart map
  static Map<String, List<InboxItemsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<InboxItemsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = InboxItemsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'event',
    'title',
    'body',
    'link',
    'read',
    'createdAt',
  };
}

