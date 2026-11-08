//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Notice {
  /// Returns a new [Notice] instance.
  Notice({
    required this.id,
    required this.body,
    required this.author,
    required this.createdAt,
  });

  String id;

  String body;

  String? author;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Notice &&
    other.id == id &&
    other.body == body &&
    other.author == author &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (body.hashCode) +
    (author == null ? 0 : author!.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'Notice[id=$id, body=$body, author=$author, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'body'] = this.body;
    if (this.author != null) {
      json[r'author'] = this.author;
    } else {
      json[r'author'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [Notice] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Notice? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Notice[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Notice[id]" has a null value in JSON.');
        assert(json.containsKey(r'body'), 'Required key "Notice[body]" is missing from JSON.');
        assert(json[r'body'] != null, 'Required key "Notice[body]" has a null value in JSON.');
        assert(json.containsKey(r'author'), 'Required key "Notice[author]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Notice[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Notice[createdAt]" has a null value in JSON.');
        return true;
      }());

      return Notice(
        id: mapValueOfType<String>(json, r'id')!,
        body: mapValueOfType<String>(json, r'body')!,
        author: mapValueOfType<String>(json, r'author'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<Notice> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Notice>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Notice.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Notice> mapFromJson(dynamic json) {
    final map = <String, Notice>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Notice.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Notice-objects as value to a dart map
  static Map<String, List<Notice>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Notice>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Notice.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'body',
    'author',
    'createdAt',
  };
}

