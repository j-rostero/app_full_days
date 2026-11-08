//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Voucher {
  /// Returns a new [Voucher] instance.
  Voucher({
    required this.passengerId,
    required this.position,
    required this.type,
    required this.name,
    required this.qr,
  });

  String passengerId;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int position;

  VoucherTypeEnum type;

  String? name;

  String qr;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Voucher &&
    other.passengerId == passengerId &&
    other.position == position &&
    other.type == type &&
    other.name == name &&
    other.qr == qr;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (passengerId.hashCode) +
    (position.hashCode) +
    (type.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (qr.hashCode);

  @override
  String toString() => 'Voucher[passengerId=$passengerId, position=$position, type=$type, name=$name, qr=$qr]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'passengerId'] = this.passengerId;
      json[r'position'] = this.position;
      json[r'type'] = this.type;
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
      json[r'qr'] = this.qr;
    return json;
  }

  /// Returns a new [Voucher] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Voucher? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'passengerId'), 'Required key "Voucher[passengerId]" is missing from JSON.');
        assert(json[r'passengerId'] != null, 'Required key "Voucher[passengerId]" has a null value in JSON.');
        assert(json.containsKey(r'position'), 'Required key "Voucher[position]" is missing from JSON.');
        assert(json[r'position'] != null, 'Required key "Voucher[position]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "Voucher[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "Voucher[type]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "Voucher[name]" is missing from JSON.');
        assert(json.containsKey(r'qr'), 'Required key "Voucher[qr]" is missing from JSON.');
        assert(json[r'qr'] != null, 'Required key "Voucher[qr]" has a null value in JSON.');
        return true;
      }());

      return Voucher(
        passengerId: mapValueOfType<String>(json, r'passengerId')!,
        position: mapValueOfType<int>(json, r'position')!,
        type: VoucherTypeEnum.fromJson(json[r'type'])!,
        name: mapValueOfType<String>(json, r'name'),
        qr: mapValueOfType<String>(json, r'qr')!,
      );
    }
    return null;
  }

  static List<Voucher> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Voucher>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Voucher.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Voucher> mapFromJson(dynamic json) {
    final map = <String, Voucher>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Voucher.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Voucher-objects as value to a dart map
  static Map<String, List<Voucher>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Voucher>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Voucher.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'passengerId',
    'position',
    'type',
    'name',
    'qr',
  };
}


enum VoucherTypeEnum {
  adult._(r'adult'),
  child._(r'child'),
  senior._(r'senior'),
  infant._(r'infant'),
  ;

  /// Instantiate a new enum with the provided value.
  const VoucherTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [VoucherTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static VoucherTypeEnum? fromJson(dynamic value) => VoucherTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [VoucherTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<VoucherTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VoucherTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VoucherTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [VoucherTypeEnum] to String,
/// and [decode] dynamic data back to [VoucherTypeEnum].
class VoucherTypeEnumTypeTransformer {
  factory VoucherTypeEnumTypeTransformer() => _instance ??= const VoucherTypeEnumTypeTransformer._();

  const VoucherTypeEnumTypeTransformer._();

  String encode(VoucherTypeEnum data) => data._value;

  /// Returns the instance of [VoucherTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  VoucherTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is VoucherTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'adult': return VoucherTypeEnum.adult;
        case r'child': return VoucherTypeEnum.child;
        case r'senior': return VoucherTypeEnum.senior;
        case r'infant': return VoucherTypeEnum.infant;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static VoucherTypeEnumTypeTransformer? _instance;
}


