//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManifestPassenger {
  /// Returns a new [ManifestPassenger] instance.
  ManifestPassenger({
    required this.id,
    required this.bookingId,
    required this.bookingCode,
    required this.position,
    required this.type,
    required this.name,
    required this.cedula,
    required this.restrictions,
    this.meals = const [],
    required this.boarding,
    required this.balanceUsd,
    required this.checkin,
    required this.checkinAt,
  });

  String id;

  String bookingId;

  String bookingCode;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int position;

  ManifestPassengerTypeEnum type;

  String? name;

  String? cedula;

  String? restrictions;

  List<String> meals;

  String? boarding;

  num balanceUsd;

  ManifestPassengerCheckinEnum? checkin;

  DateTime? checkinAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManifestPassenger &&
    other.id == id &&
    other.bookingId == bookingId &&
    other.bookingCode == bookingCode &&
    other.position == position &&
    other.type == type &&
    other.name == name &&
    other.cedula == cedula &&
    other.restrictions == restrictions &&
    _deepEquality.equals(other.meals, meals) &&
    other.boarding == boarding &&
    other.balanceUsd == balanceUsd &&
    other.checkin == checkin &&
    other.checkinAt == checkinAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (bookingId.hashCode) +
    (bookingCode.hashCode) +
    (position.hashCode) +
    (type.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (cedula == null ? 0 : cedula!.hashCode) +
    (restrictions == null ? 0 : restrictions!.hashCode) +
    (meals.hashCode) +
    (boarding == null ? 0 : boarding!.hashCode) +
    (balanceUsd.hashCode) +
    (checkin == null ? 0 : checkin!.hashCode) +
    (checkinAt == null ? 0 : checkinAt!.hashCode);

  @override
  String toString() => 'ManifestPassenger[id=$id, bookingId=$bookingId, bookingCode=$bookingCode, position=$position, type=$type, name=$name, cedula=$cedula, restrictions=$restrictions, meals=$meals, boarding=$boarding, balanceUsd=$balanceUsd, checkin=$checkin, checkinAt=$checkinAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'bookingId'] = this.bookingId;
      json[r'bookingCode'] = this.bookingCode;
      json[r'position'] = this.position;
      json[r'type'] = this.type;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.cedula != null) {
      json[r'cedula'] = this.cedula;
    } else {
      json[r'cedula'] = null;
    }
    if (this.restrictions != null) {
      json[r'restrictions'] = this.restrictions;
    } else {
      json[r'restrictions'] = null;
    }
      json[r'meals'] = this.meals;
    if (this.boarding != null) {
      json[r'boarding'] = this.boarding;
    } else {
      json[r'boarding'] = null;
    }
      json[r'balanceUsd'] = this.balanceUsd;
    if (this.checkin != null) {
      json[r'checkin'] = this.checkin;
    } else {
      json[r'checkin'] = null;
    }
    if (this.checkinAt != null) {
      json[r'checkinAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.checkinAt!.millisecondsSinceEpoch
        : this.checkinAt!.toUtc().toIso8601String();
    } else {
      json[r'checkinAt'] = null;
    }
    return json;
  }

  /// Returns a new [ManifestPassenger] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManifestPassenger? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ManifestPassenger[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ManifestPassenger[id]" has a null value in JSON.');
        assert(json.containsKey(r'bookingId'), 'Required key "ManifestPassenger[bookingId]" is missing from JSON.');
        assert(json[r'bookingId'] != null, 'Required key "ManifestPassenger[bookingId]" has a null value in JSON.');
        assert(json.containsKey(r'bookingCode'), 'Required key "ManifestPassenger[bookingCode]" is missing from JSON.');
        assert(json[r'bookingCode'] != null, 'Required key "ManifestPassenger[bookingCode]" has a null value in JSON.');
        assert(json.containsKey(r'position'), 'Required key "ManifestPassenger[position]" is missing from JSON.');
        assert(json[r'position'] != null, 'Required key "ManifestPassenger[position]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ManifestPassenger[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ManifestPassenger[type]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ManifestPassenger[name]" is missing from JSON.');
        assert(json.containsKey(r'cedula'), 'Required key "ManifestPassenger[cedula]" is missing from JSON.');
        assert(json.containsKey(r'restrictions'), 'Required key "ManifestPassenger[restrictions]" is missing from JSON.');
        assert(json.containsKey(r'meals'), 'Required key "ManifestPassenger[meals]" is missing from JSON.');
        assert(json[r'meals'] != null, 'Required key "ManifestPassenger[meals]" has a null value in JSON.');
        assert(json.containsKey(r'boarding'), 'Required key "ManifestPassenger[boarding]" is missing from JSON.');
        assert(json.containsKey(r'balanceUsd'), 'Required key "ManifestPassenger[balanceUsd]" is missing from JSON.');
        assert(json[r'balanceUsd'] != null, 'Required key "ManifestPassenger[balanceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'checkin'), 'Required key "ManifestPassenger[checkin]" is missing from JSON.');
        assert(json.containsKey(r'checkinAt'), 'Required key "ManifestPassenger[checkinAt]" is missing from JSON.');
        return true;
      }());

      return ManifestPassenger(
        id: mapValueOfType<String>(json, r'id')!,
        bookingId: mapValueOfType<String>(json, r'bookingId')!,
        bookingCode: mapValueOfType<String>(json, r'bookingCode')!,
        position: mapValueOfType<int>(json, r'position')!,
        type: ManifestPassengerTypeEnum.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name'),
        cedula: mapValueOfType<String>(json, r'cedula'),
        restrictions: mapValueOfType<String>(json, r'restrictions'),
        meals: json[r'meals'] is Iterable
            ? (json[r'meals'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        boarding: mapValueOfType<String>(json, r'boarding'),
        balanceUsd: num.parse('${json[r'balanceUsd']}'),
        checkin: ManifestPassengerCheckinEnum.fromJson(json[r'checkin']),
        checkinAt: mapDateTime(json, r'checkinAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
      );
    }
    return null;
  }

  static List<ManifestPassenger> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManifestPassenger>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManifestPassenger.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManifestPassenger> mapFromJson(dynamic json) {
    final map = <String, ManifestPassenger>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManifestPassenger.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManifestPassenger-objects as value to a dart map
  static Map<String, List<ManifestPassenger>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManifestPassenger>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManifestPassenger.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'bookingId',
    'bookingCode',
    'position',
    'type',
    'name',
    'cedula',
    'restrictions',
    'meals',
    'boarding',
    'balanceUsd',
    'checkin',
    'checkinAt',
  };
}


enum ManifestPassengerTypeEnum {
  adult._(r'adult'),
  child._(r'child'),
  senior._(r'senior'),
  infant._(r'infant'),
  ;

  /// Instantiate a new enum with the provided value.
  const ManifestPassengerTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ManifestPassengerTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ManifestPassengerTypeEnum? fromJson(dynamic value) => ManifestPassengerTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ManifestPassengerTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ManifestPassengerTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManifestPassengerTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManifestPassengerTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ManifestPassengerTypeEnum] to String,
/// and [decode] dynamic data back to [ManifestPassengerTypeEnum].
class ManifestPassengerTypeEnumTypeTransformer {
  factory ManifestPassengerTypeEnumTypeTransformer() => _instance ??= const ManifestPassengerTypeEnumTypeTransformer._();

  const ManifestPassengerTypeEnumTypeTransformer._();

  String encode(ManifestPassengerTypeEnum data) => data._value;

  /// Returns the instance of [ManifestPassengerTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ManifestPassengerTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ManifestPassengerTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'adult': return ManifestPassengerTypeEnum.adult;
        case r'child': return ManifestPassengerTypeEnum.child;
        case r'senior': return ManifestPassengerTypeEnum.senior;
        case r'infant': return ManifestPassengerTypeEnum.infant;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ManifestPassengerTypeEnumTypeTransformer? _instance;
}



enum ManifestPassengerCheckinEnum {
  boarded._(r'boarded'),
  noShow._(r'no_show'),
  ;

  /// Instantiate a new enum with the provided value.
  const ManifestPassengerCheckinEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ManifestPassengerCheckinEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ManifestPassengerCheckinEnum? fromJson(dynamic value) => ManifestPassengerCheckinEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ManifestPassengerCheckinEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ManifestPassengerCheckinEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManifestPassengerCheckinEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManifestPassengerCheckinEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ManifestPassengerCheckinEnum] to String,
/// and [decode] dynamic data back to [ManifestPassengerCheckinEnum].
class ManifestPassengerCheckinEnumTypeTransformer {
  factory ManifestPassengerCheckinEnumTypeTransformer() => _instance ??= const ManifestPassengerCheckinEnumTypeTransformer._();

  const ManifestPassengerCheckinEnumTypeTransformer._();

  String encode(ManifestPassengerCheckinEnum data) => data._value;

  /// Returns the instance of [ManifestPassengerCheckinEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ManifestPassengerCheckinEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ManifestPassengerCheckinEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'boarded': return ManifestPassengerCheckinEnum.boarded;
        case r'no_show': return ManifestPassengerCheckinEnum.noShow;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ManifestPassengerCheckinEnumTypeTransformer? _instance;
}


