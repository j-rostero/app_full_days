//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingPassenger {
  /// Returns a new [BookingPassenger] instance.
  BookingPassenger({
    required this.id,
    required this.position,
    required this.type,
    required this.name,
    required this.cedula,
    required this.birthDate,
    required this.restrictions,
  });

  String id;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int position;

  BookingPassengerTypeEnum type;

  String? name;

  String? cedula;

  DateTime? birthDate;

  String? restrictions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingPassenger &&
    other.id == id &&
    other.position == position &&
    other.type == type &&
    other.name == name &&
    other.cedula == cedula &&
    other.birthDate == birthDate &&
    other.restrictions == restrictions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (position.hashCode) +
    (type.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (cedula == null ? 0 : cedula!.hashCode) +
    (birthDate == null ? 0 : birthDate!.hashCode) +
    (restrictions == null ? 0 : restrictions!.hashCode);

  @override
  String toString() => 'BookingPassenger[id=$id, position=$position, type=$type, name=$name, cedula=$cedula, birthDate=$birthDate, restrictions=$restrictions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
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
    if (this.birthDate != null) {
      json[r'birthDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.birthDate!.millisecondsSinceEpoch
        : _dateFormatter.format(this.birthDate!);
    } else {
      json[r'birthDate'] = null;
    }
    if (this.restrictions != null) {
      json[r'restrictions'] = this.restrictions;
    } else {
      json[r'restrictions'] = null;
    }
    return json;
  }

  /// Returns a new [BookingPassenger] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingPassenger? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "BookingPassenger[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "BookingPassenger[id]" has a null value in JSON.');
        assert(json.containsKey(r'position'), 'Required key "BookingPassenger[position]" is missing from JSON.');
        assert(json[r'position'] != null, 'Required key "BookingPassenger[position]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "BookingPassenger[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "BookingPassenger[type]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "BookingPassenger[name]" is missing from JSON.');
        assert(json.containsKey(r'cedula'), 'Required key "BookingPassenger[cedula]" is missing from JSON.');
        assert(json.containsKey(r'birthDate'), 'Required key "BookingPassenger[birthDate]" is missing from JSON.');
        assert(json.containsKey(r'restrictions'), 'Required key "BookingPassenger[restrictions]" is missing from JSON.');
        return true;
      }());

      return BookingPassenger(
        id: mapValueOfType<String>(json, r'id')!,
        position: mapValueOfType<int>(json, r'position')!,
        type: BookingPassengerTypeEnum.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name'),
        cedula: mapValueOfType<String>(json, r'cedula'),
        birthDate: mapDateTime(json, r'birthDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/'),
        restrictions: mapValueOfType<String>(json, r'restrictions'),
      );
    }
    return null;
  }

  static List<BookingPassenger> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingPassenger>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingPassenger.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingPassenger> mapFromJson(dynamic json) {
    final map = <String, BookingPassenger>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingPassenger.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingPassenger-objects as value to a dart map
  static Map<String, List<BookingPassenger>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingPassenger>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingPassenger.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'position',
    'type',
    'name',
    'cedula',
    'birthDate',
    'restrictions',
  };
}


enum BookingPassengerTypeEnum {
  adult._(r'adult'),
  child._(r'child'),
  senior._(r'senior'),
  infant._(r'infant'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingPassengerTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingPassengerTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingPassengerTypeEnum? fromJson(dynamic value) => BookingPassengerTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingPassengerTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingPassengerTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingPassengerTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingPassengerTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingPassengerTypeEnum] to String,
/// and [decode] dynamic data back to [BookingPassengerTypeEnum].
class BookingPassengerTypeEnumTypeTransformer {
  factory BookingPassengerTypeEnumTypeTransformer() => _instance ??= const BookingPassengerTypeEnumTypeTransformer._();

  const BookingPassengerTypeEnumTypeTransformer._();

  String encode(BookingPassengerTypeEnum data) => data._value;

  /// Returns the instance of [BookingPassengerTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingPassengerTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingPassengerTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'adult': return BookingPassengerTypeEnum.adult;
        case r'child': return BookingPassengerTypeEnum.child;
        case r'senior': return BookingPassengerTypeEnum.senior;
        case r'infant': return BookingPassengerTypeEnum.infant;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingPassengerTypeEnumTypeTransformer? _instance;
}


