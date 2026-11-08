//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminUserListItemsInnerBookingsInner {
  /// Returns a new [AdminUserListItemsInnerBookingsInner] instance.
  AdminUserListItemsInnerBookingsInner({
    required this.id,
    required this.code,
    required this.status,
    required this.title,
    required this.date,
  });

  String id;

  String code;

  String status;

  String title;

  DateTime date;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminUserListItemsInnerBookingsInner &&
    other.id == id &&
    other.code == code &&
    other.status == status &&
    other.title == title &&
    other.date == date;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (code.hashCode) +
    (status.hashCode) +
    (title.hashCode) +
    (date.hashCode);

  @override
  String toString() => 'AdminUserListItemsInnerBookingsInner[id=$id, code=$code, status=$status, title=$title, date=$date]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'code'] = this.code;
      json[r'status'] = this.status;
      json[r'title'] = this.title;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
    return json;
  }

  /// Returns a new [AdminUserListItemsInnerBookingsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminUserListItemsInnerBookingsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AdminUserListItemsInnerBookingsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AdminUserListItemsInnerBookingsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'code'), 'Required key "AdminUserListItemsInnerBookingsInner[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "AdminUserListItemsInnerBookingsInner[code]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "AdminUserListItemsInnerBookingsInner[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "AdminUserListItemsInnerBookingsInner[status]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "AdminUserListItemsInnerBookingsInner[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "AdminUserListItemsInnerBookingsInner[title]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "AdminUserListItemsInnerBookingsInner[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "AdminUserListItemsInnerBookingsInner[date]" has a null value in JSON.');
        return true;
      }());

      return AdminUserListItemsInnerBookingsInner(
        id: mapValueOfType<String>(json, r'id')!,
        code: mapValueOfType<String>(json, r'code')!,
        status: mapValueOfType<String>(json, r'status')!,
        title: mapValueOfType<String>(json, r'title')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
      );
    }
    return null;
  }

  static List<AdminUserListItemsInnerBookingsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminUserListItemsInnerBookingsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminUserListItemsInnerBookingsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminUserListItemsInnerBookingsInner> mapFromJson(dynamic json) {
    final map = <String, AdminUserListItemsInnerBookingsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminUserListItemsInnerBookingsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminUserListItemsInnerBookingsInner-objects as value to a dart map
  static Map<String, List<AdminUserListItemsInnerBookingsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminUserListItemsInnerBookingsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminUserListItemsInnerBookingsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'code',
    'status',
    'title',
    'date',
  };
}

