//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CheckinSyncInputEventsInner {
  /// Returns a new [CheckinSyncInputEventsInner] instance.
  CheckinSyncInputEventsInner({
    required this.passengerId,
    required this.checkin,
    required this.at,
  });

  String passengerId;

  CheckinSyncInputEventsInnerCheckinEnum? checkin;

  DateTime at;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CheckinSyncInputEventsInner &&
    other.passengerId == passengerId &&
    other.checkin == checkin &&
    other.at == at;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (passengerId.hashCode) +
    (checkin == null ? 0 : checkin!.hashCode) +
    (at.hashCode);

  @override
  String toString() => 'CheckinSyncInputEventsInner[passengerId=$passengerId, checkin=$checkin, at=$at]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'passengerId'] = this.passengerId;
    if (this.checkin != null) {
      json[r'checkin'] = this.checkin;
    } else {
      json[r'checkin'] = null;
    }
      json[r'at'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z|([+-](?:[01]\\d|2[0-3]):[0-5]\\d)))$/')
        ? this.at.millisecondsSinceEpoch
        : this.at.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [CheckinSyncInputEventsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CheckinSyncInputEventsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'passengerId'), 'Required key "CheckinSyncInputEventsInner[passengerId]" is missing from JSON.');
        assert(json[r'passengerId'] != null, 'Required key "CheckinSyncInputEventsInner[passengerId]" has a null value in JSON.');
        assert(json.containsKey(r'checkin'), 'Required key "CheckinSyncInputEventsInner[checkin]" is missing from JSON.');
        assert(json.containsKey(r'at'), 'Required key "CheckinSyncInputEventsInner[at]" is missing from JSON.');
        assert(json[r'at'] != null, 'Required key "CheckinSyncInputEventsInner[at]" has a null value in JSON.');
        return true;
      }());

      return CheckinSyncInputEventsInner(
        passengerId: mapValueOfType<String>(json, r'passengerId')!,
        checkin: CheckinSyncInputEventsInnerCheckinEnum.fromJson(json[r'checkin']),
        at: mapDateTime(json, r'at', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z|([+-](?:[01]\\d|2[0-3]):[0-5]\\d)))$/')!,
      );
    }
    return null;
  }

  static List<CheckinSyncInputEventsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckinSyncInputEventsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckinSyncInputEventsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CheckinSyncInputEventsInner> mapFromJson(dynamic json) {
    final map = <String, CheckinSyncInputEventsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CheckinSyncInputEventsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CheckinSyncInputEventsInner-objects as value to a dart map
  static Map<String, List<CheckinSyncInputEventsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CheckinSyncInputEventsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CheckinSyncInputEventsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'passengerId',
    'checkin',
    'at',
  };
}


enum CheckinSyncInputEventsInnerCheckinEnum {
  boarded._(r'boarded'),
  noShow._(r'no_show'),
  ;

  /// Instantiate a new enum with the provided value.
  const CheckinSyncInputEventsInnerCheckinEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CheckinSyncInputEventsInnerCheckinEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CheckinSyncInputEventsInnerCheckinEnum? fromJson(dynamic value) => CheckinSyncInputEventsInnerCheckinEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CheckinSyncInputEventsInnerCheckinEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CheckinSyncInputEventsInnerCheckinEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CheckinSyncInputEventsInnerCheckinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CheckinSyncInputEventsInnerCheckinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CheckinSyncInputEventsInnerCheckinEnum] to String,
/// and [decode] dynamic data back to [CheckinSyncInputEventsInnerCheckinEnum].
class CheckinSyncInputEventsInnerCheckinEnumTypeTransformer {
  factory CheckinSyncInputEventsInnerCheckinEnumTypeTransformer() => _instance ??= const CheckinSyncInputEventsInnerCheckinEnumTypeTransformer._();

  const CheckinSyncInputEventsInnerCheckinEnumTypeTransformer._();

  String encode(CheckinSyncInputEventsInnerCheckinEnum data) => data._value;

  /// Returns the instance of [CheckinSyncInputEventsInnerCheckinEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CheckinSyncInputEventsInnerCheckinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is CheckinSyncInputEventsInnerCheckinEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'boarded': return CheckinSyncInputEventsInnerCheckinEnum.boarded;
        case r'no_show': return CheckinSyncInputEventsInnerCheckinEnum.noShow;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CheckinSyncInputEventsInnerCheckinEnumTypeTransformer? _instance;
}


