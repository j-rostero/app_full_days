//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Claim {
  /// Returns a new [Claim] instance.
  Claim({
    required this.id,
    required this.bookingId,
    required this.bookingCode,
    required this.title,
    required this.providerName,
    required this.traveler,
    required this.subject,
    required this.status,
    required this.resolution,
    required this.createdAt,
    required this.updatedAt,
    this.messages = const [],
  });

  String id;

  String bookingId;

  String bookingCode;

  String title;

  String providerName;

  String traveler;

  String subject;

  ClaimStatusEnum status;

  String? resolution;

  DateTime createdAt;

  DateTime updatedAt;

  List<ClaimMessagesInner> messages;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Claim &&
    other.id == id &&
    other.bookingId == bookingId &&
    other.bookingCode == bookingCode &&
    other.title == title &&
    other.providerName == providerName &&
    other.traveler == traveler &&
    other.subject == subject &&
    other.status == status &&
    other.resolution == resolution &&
    other.createdAt == createdAt &&
    other.updatedAt == updatedAt &&
    _deepEquality.equals(other.messages, messages);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (bookingId.hashCode) +
    (bookingCode.hashCode) +
    (title.hashCode) +
    (providerName.hashCode) +
    (traveler.hashCode) +
    (subject.hashCode) +
    (status.hashCode) +
    (resolution == null ? 0 : resolution!.hashCode) +
    (createdAt.hashCode) +
    (updatedAt.hashCode) +
    (messages.hashCode);

  @override
  String toString() => 'Claim[id=$id, bookingId=$bookingId, bookingCode=$bookingCode, title=$title, providerName=$providerName, traveler=$traveler, subject=$subject, status=$status, resolution=$resolution, createdAt=$createdAt, updatedAt=$updatedAt, messages=$messages]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'bookingId'] = this.bookingId;
      json[r'bookingCode'] = this.bookingCode;
      json[r'title'] = this.title;
      json[r'providerName'] = this.providerName;
      json[r'traveler'] = this.traveler;
      json[r'subject'] = this.subject;
      json[r'status'] = this.status;
    if (this.resolution != null) {
      json[r'resolution'] = this.resolution;
    } else {
      json[r'resolution'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
      json[r'updatedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.updatedAt.millisecondsSinceEpoch
        : this.updatedAt.toUtc().toIso8601String();
      json[r'messages'] = this.messages;
    return json;
  }

  /// Returns a new [Claim] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Claim? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Claim[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Claim[id]" has a null value in JSON.');
        assert(json.containsKey(r'bookingId'), 'Required key "Claim[bookingId]" is missing from JSON.');
        assert(json[r'bookingId'] != null, 'Required key "Claim[bookingId]" has a null value in JSON.');
        assert(json.containsKey(r'bookingCode'), 'Required key "Claim[bookingCode]" is missing from JSON.');
        assert(json[r'bookingCode'] != null, 'Required key "Claim[bookingCode]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Claim[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Claim[title]" has a null value in JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "Claim[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "Claim[providerName]" has a null value in JSON.');
        assert(json.containsKey(r'traveler'), 'Required key "Claim[traveler]" is missing from JSON.');
        assert(json[r'traveler'] != null, 'Required key "Claim[traveler]" has a null value in JSON.');
        assert(json.containsKey(r'subject'), 'Required key "Claim[subject]" is missing from JSON.');
        assert(json[r'subject'] != null, 'Required key "Claim[subject]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "Claim[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Claim[status]" has a null value in JSON.');
        assert(json.containsKey(r'resolution'), 'Required key "Claim[resolution]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Claim[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Claim[createdAt]" has a null value in JSON.');
        assert(json.containsKey(r'updatedAt'), 'Required key "Claim[updatedAt]" is missing from JSON.');
        assert(json[r'updatedAt'] != null, 'Required key "Claim[updatedAt]" has a null value in JSON.');
        assert(json.containsKey(r'messages'), 'Required key "Claim[messages]" is missing from JSON.');
        assert(json[r'messages'] != null, 'Required key "Claim[messages]" has a null value in JSON.');
        return true;
      }());

      return Claim(
        id: mapValueOfType<String>(json, r'id')!,
        bookingId: mapValueOfType<String>(json, r'bookingId')!,
        bookingCode: mapValueOfType<String>(json, r'bookingCode')!,
        title: mapValueOfType<String>(json, r'title')!,
        providerName: mapValueOfType<String>(json, r'providerName')!,
        traveler: mapValueOfType<String>(json, r'traveler')!,
        subject: mapValueOfType<String>(json, r'subject')!,
        status: ClaimStatusEnum.fromJson(json[r'status'])!,
        resolution: mapValueOfType<String>(json, r'resolution'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        updatedAt: mapDateTime(json, r'updatedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        messages: ClaimMessagesInner.listFromJson(json[r'messages']),
      );
    }
    return null;
  }

  static List<Claim> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Claim>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Claim.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Claim> mapFromJson(dynamic json) {
    final map = <String, Claim>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Claim.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Claim-objects as value to a dart map
  static Map<String, List<Claim>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Claim>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Claim.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'bookingId',
    'bookingCode',
    'title',
    'providerName',
    'traveler',
    'subject',
    'status',
    'resolution',
    'createdAt',
    'updatedAt',
    'messages',
  };
}


enum ClaimStatusEnum {
  open._(r'open'),
  escalated._(r'escalated'),
  resolved._(r'resolved'),
  ;

  /// Instantiate a new enum with the provided value.
  const ClaimStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ClaimStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ClaimStatusEnum? fromJson(dynamic value) => ClaimStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ClaimStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ClaimStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ClaimStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ClaimStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ClaimStatusEnum] to String,
/// and [decode] dynamic data back to [ClaimStatusEnum].
class ClaimStatusEnumTypeTransformer {
  factory ClaimStatusEnumTypeTransformer() => _instance ??= const ClaimStatusEnumTypeTransformer._();

  const ClaimStatusEnumTypeTransformer._();

  String encode(ClaimStatusEnum data) => data._value;

  /// Returns the instance of [ClaimStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ClaimStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ClaimStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return ClaimStatusEnum.open;
        case r'escalated': return ClaimStatusEnum.escalated;
        case r'resolved': return ClaimStatusEnum.resolved;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ClaimStatusEnumTypeTransformer? _instance;
}


