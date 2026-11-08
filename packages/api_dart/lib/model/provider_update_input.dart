//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderUpdateInput {
  /// Returns a new [ProviderUpdateInput] instance.
  ProviderUpdateInput({
    this.kind,
    this.name,
    this.legalName,
    this.rtn,
    this.baseCity,
    this.phone,
    this.instagram,
    this.paymentInstructions,
  });

  ProviderUpdateInputKindEnum? kind;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? name;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? legalName;

  String? rtn;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? baseCity;

  Object? phone;

  String? instagram;

  String? paymentInstructions;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderUpdateInput &&
    other.kind == kind &&
    other.name == name &&
    other.legalName == legalName &&
    other.rtn == rtn &&
    other.baseCity == baseCity &&
    other.phone == phone &&
    other.instagram == instagram &&
    other.paymentInstructions == paymentInstructions;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (kind == null ? 0 : kind!.hashCode) +
    (name == null ? 0 : name!.hashCode) +
    (legalName == null ? 0 : legalName!.hashCode) +
    (rtn == null ? 0 : rtn!.hashCode) +
    (baseCity == null ? 0 : baseCity!.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (instagram == null ? 0 : instagram!.hashCode) +
    (paymentInstructions == null ? 0 : paymentInstructions!.hashCode);

  @override
  String toString() => 'ProviderUpdateInput[kind=$kind, name=$name, legalName=$legalName, rtn=$rtn, baseCity=$baseCity, phone=$phone, instagram=$instagram, paymentInstructions=$paymentInstructions]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.kind != null) {
      json[r'kind'] = this.kind;
    } else {
      json[r'kind'] = null;
    }
    if (this.name != null) {
      json[r'name'] = this.name;
    } else {
      json[r'name'] = null;
    }
    if (this.legalName != null) {
      json[r'legalName'] = this.legalName;
    } else {
      json[r'legalName'] = null;
    }
    if (this.rtn != null) {
      json[r'rtn'] = this.rtn;
    } else {
      json[r'rtn'] = null;
    }
    if (this.baseCity != null) {
      json[r'baseCity'] = this.baseCity;
    } else {
      json[r'baseCity'] = null;
    }
    if (this.phone != null) {
      json[r'phone'] = this.phone;
    } else {
      json[r'phone'] = null;
    }
    if (this.instagram != null) {
      json[r'instagram'] = this.instagram;
    } else {
      json[r'instagram'] = null;
    }
    if (this.paymentInstructions != null) {
      json[r'paymentInstructions'] = this.paymentInstructions;
    } else {
      json[r'paymentInstructions'] = null;
    }
    return json;
  }

  /// Returns a new [ProviderUpdateInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderUpdateInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return ProviderUpdateInput(
        kind: ProviderUpdateInputKindEnum.fromJson(json[r'kind']),
        name: mapValueOfType<String>(json, r'name'),
        legalName: mapValueOfType<String>(json, r'legalName'),
        rtn: mapValueOfType<String>(json, r'rtn'),
        baseCity: mapValueOfType<String>(json, r'baseCity'),
        phone: mapValueOfType<Object>(json, r'phone'),
        instagram: mapValueOfType<String>(json, r'instagram'),
        paymentInstructions: mapValueOfType<String>(json, r'paymentInstructions'),
      );
    }
    return null;
  }

  static List<ProviderUpdateInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderUpdateInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderUpdateInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderUpdateInput> mapFromJson(dynamic json) {
    final map = <String, ProviderUpdateInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderUpdateInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderUpdateInput-objects as value to a dart map
  static Map<String, List<ProviderUpdateInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderUpdateInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderUpdateInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum ProviderUpdateInputKindEnum {
  person._(r'person'),
  company._(r'company'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProviderUpdateInputKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProviderUpdateInputKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProviderUpdateInputKindEnum? fromJson(dynamic value) => ProviderUpdateInputKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProviderUpdateInputKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProviderUpdateInputKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderUpdateInputKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderUpdateInputKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProviderUpdateInputKindEnum] to String,
/// and [decode] dynamic data back to [ProviderUpdateInputKindEnum].
class ProviderUpdateInputKindEnumTypeTransformer {
  factory ProviderUpdateInputKindEnumTypeTransformer() => _instance ??= const ProviderUpdateInputKindEnumTypeTransformer._();

  const ProviderUpdateInputKindEnumTypeTransformer._();

  String encode(ProviderUpdateInputKindEnum data) => data._value;

  /// Returns the instance of [ProviderUpdateInputKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProviderUpdateInputKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProviderUpdateInputKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'person': return ProviderUpdateInputKindEnum.person;
        case r'company': return ProviderUpdateInputKindEnum.company;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProviderUpdateInputKindEnumTypeTransformer? _instance;
}


