//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VoucherList {
  /// Returns a new [VoucherList] instance.
  VoucherList({
    required this.bookingCode,
    required this.title,
    required this.date,
    this.items = const [],
  });

  String bookingCode;

  String title;

  DateTime date;

  List<Voucher> items;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VoucherList &&
    other.bookingCode == bookingCode &&
    other.title == title &&
    other.date == date &&
    _deepEquality.equals(other.items, items);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (bookingCode.hashCode) +
    (title.hashCode) +
    (date.hashCode) +
    (items.hashCode);

  @override
  String toString() => 'VoucherList[bookingCode=$bookingCode, title=$title, date=$date, items=$items]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'bookingCode'] = this.bookingCode;
      json[r'title'] = this.title;
      json[r'date'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.date.millisecondsSinceEpoch
        : _dateFormatter.format(this.date);
      json[r'items'] = this.items;
    return json;
  }

  /// Returns a new [VoucherList] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VoucherList? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'bookingCode'), 'Required key "VoucherList[bookingCode]" is missing from JSON.');
        assert(json[r'bookingCode'] != null, 'Required key "VoucherList[bookingCode]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "VoucherList[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "VoucherList[title]" has a null value in JSON.');
        assert(json.containsKey(r'date'), 'Required key "VoucherList[date]" is missing from JSON.');
        assert(json[r'date'] != null, 'Required key "VoucherList[date]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "VoucherList[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "VoucherList[items]" has a null value in JSON.');
        return true;
      }());

      return VoucherList(
        bookingCode: mapValueOfType<String>(json, r'bookingCode')!,
        title: mapValueOfType<String>(json, r'title')!,
        date: mapDateTime(json, r'date', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        items: Voucher.listFromJson(json[r'items']),
      );
    }
    return null;
  }

  static List<VoucherList> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VoucherList>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VoucherList.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VoucherList> mapFromJson(dynamic json) {
    final map = <String, VoucherList>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VoucherList.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VoucherList-objects as value to a dart map
  static Map<String, List<VoucherList>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VoucherList>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VoucherList.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'bookingCode',
    'title',
    'date',
    'items',
  };
}

