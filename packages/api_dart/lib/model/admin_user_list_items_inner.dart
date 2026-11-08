//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AdminUserListItemsInner {
  /// Returns a new [AdminUserListItemsInner] instance.
  AdminUserListItemsInner({
    required this.id,
    required this.email,
    required this.name,
    required this.phone,
    required this.blockedAt,
    required this.createdAt,
    this.bookings = const [],
  });

  String id;

  String email;

  String? name;

  String? phone;

  DateTime? blockedAt;

  DateTime createdAt;

  List<AdminUserListItemsInnerBookingsInner> bookings;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AdminUserListItemsInner &&
    other.id == id &&
    other.email == email &&
    other.name == name &&
    other.phone == phone &&
    other.blockedAt == blockedAt &&
    other.createdAt == createdAt &&
    _deepEquality.equals(other.bookings, bookings);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (email.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (blockedAt == null ? 0 : blockedAt!.hashCode) +
    (createdAt.hashCode) +
    (bookings.hashCode);

  @override
  String toString() => 'AdminUserListItemsInner[id=$id, email=$email, name=$name, phone=$phone, blockedAt=$blockedAt, createdAt=$createdAt, bookings=$bookings]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'email'] = this.email;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.blockedAt != null) {
      json[r'blockedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.blockedAt!.millisecondsSinceEpoch
        : this.blockedAt!.toUtc().toIso8601String();
    } else {
      json[r'blockedAt'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
      json[r'bookings'] = this.bookings;
    return json;
  }

  /// Returns a new [AdminUserListItemsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AdminUserListItemsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AdminUserListItemsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AdminUserListItemsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'email'), 'Required key "AdminUserListItemsInner[email]" is missing from JSON.');
        assert(json[r'email'] != null, 'Required key "AdminUserListItemsInner[email]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "AdminUserListItemsInner[name]" is missing from JSON.');
        assert(json.containsKey(r'phone'), 'Required key "AdminUserListItemsInner[phone]" is missing from JSON.');
        assert(json.containsKey(r'blockedAt'), 'Required key "AdminUserListItemsInner[blockedAt]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "AdminUserListItemsInner[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "AdminUserListItemsInner[createdAt]" has a null value in JSON.');
        assert(json.containsKey(r'bookings'), 'Required key "AdminUserListItemsInner[bookings]" is missing from JSON.');
        assert(json[r'bookings'] != null, 'Required key "AdminUserListItemsInner[bookings]" has a null value in JSON.');
        return true;
      }());

      return AdminUserListItemsInner(
        id: mapValueOfType<String>(json, r'id')!,
        email: mapValueOfType<String>(json, r'email')!,
        name: mapValueOfType<String>(json, r'name'),
        phone: mapValueOfType<String>(json, r'phone'),
        blockedAt: mapDateTime(json, r'blockedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        bookings: AdminUserListItemsInnerBookingsInner.listFromJson(json[r'bookings']),
      );
    }
    return null;
  }

  static List<AdminUserListItemsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AdminUserListItemsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AdminUserListItemsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AdminUserListItemsInner> mapFromJson(dynamic json) {
    final map = <String, AdminUserListItemsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AdminUserListItemsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AdminUserListItemsInner-objects as value to a dart map
  static Map<String, List<AdminUserListItemsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AdminUserListItemsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AdminUserListItemsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'email',
    'name',
    'phone',
    'blockedAt',
    'createdAt',
    'bookings',
  };
}

