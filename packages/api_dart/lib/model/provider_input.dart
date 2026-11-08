//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderInput {
  /// Returns a new [ProviderInput] instance.
  ProviderInput({
    required this.kind,
    required this.name,
    required this.legalName,
    required this.rtn,
    required this.baseCity,
    required this.phone,
    required this.instagram,
    required this.paymentInstructions,
    required this.rif,
  });

  ProviderInputKindEnum kind;

  String name;

  String legalName;

  String? rtn;

  String baseCity;

  Object? phone;

  String? instagram;

  String? paymentInstructions;

  Object? rif;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderInput &&
    other.kind == kind &&
    other.name == name &&
    other.legalName == legalName &&
    other.rtn == rtn &&
    other.baseCity == baseCity &&
    other.phone == phone &&
    other.instagram == instagram &&
    other.paymentInstructions == paymentInstructions &&
    other.rif == rif;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (kind.hashCode) +
    (name.hashCode) +
    (legalName.hashCode) +
    (rtn == null ? 0 : rtn!.hashCode) +
    (baseCity.hashCode) +
    (phone == null ? 0 : phone!.hashCode) +
    (instagram == null ? 0 : instagram!.hashCode) +
    (paymentInstructions == null ? 0 : paymentInstructions!.hashCode) +
    (rif == null ? 0 : rif!.hashCode);

  @override
  String toString() => 'ProviderInput[kind=$kind, name=$name, legalName=$legalName, rtn=$rtn, baseCity=$baseCity, phone=$phone, instagram=$instagram, paymentInstructions=$paymentInstructions, rif=$rif]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'kind'] = this.kind;
      json[r'name'] = this.name;
      json[r'legalName'] = this.legalName;
    if (this.rtn != null) {
      json[r'rtn'] = this.rtn;
    } else {
      json[r'rtn'] = null;
    }
      json[r'baseCity'] = this.baseCity;
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
    if (this.rif != null) {
      json[r'rif'] = this.rif;
    } else {
      json[r'rif'] = null;
    }
    return json;
  }

  /// Returns a new [ProviderInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'kind'), 'Required key "ProviderInput[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "ProviderInput[kind]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProviderInput[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProviderInput[name]" has a null value in JSON.');
        assert(json.containsKey(r'legalName'), 'Required key "ProviderInput[legalName]" is missing from JSON.');
        assert(json[r'legalName'] != null, 'Required key "ProviderInput[legalName]" has a null value in JSON.');
        assert(json.containsKey(r'rtn'), 'Required key "ProviderInput[rtn]" is missing from JSON.');
        assert(json.containsKey(r'baseCity'), 'Required key "ProviderInput[baseCity]" is missing from JSON.');
        assert(json[r'baseCity'] != null, 'Required key "ProviderInput[baseCity]" has a null value in JSON.');
        assert(json.containsKey(r'phone'), 'Required key "ProviderInput[phone]" is missing from JSON.');
        assert(json.containsKey(r'instagram'), 'Required key "ProviderInput[instagram]" is missing from JSON.');
        assert(json.containsKey(r'paymentInstructions'), 'Required key "ProviderInput[paymentInstructions]" is missing from JSON.');
        assert(json.containsKey(r'rif'), 'Required key "ProviderInput[rif]" is missing from JSON.');
        return true;
      }());

      return ProviderInput(
        kind: ProviderInputKindEnum.fromJson(json[r'kind'])!,
        name: mapValueOfType<String>(json, r'name')!,
        legalName: mapValueOfType<String>(json, r'legalName')!,
        rtn: mapValueOfType<String>(json, r'rtn'),
        baseCity: mapValueOfType<String>(json, r'baseCity')!,
        phone: mapValueOfType<Object>(json, r'phone'),
        instagram: mapValueOfType<String>(json, r'instagram'),
        paymentInstructions: mapValueOfType<String>(json, r'paymentInstructions'),
        rif: mapValueOfType<Object>(json, r'rif'),
      );
    }
    return null;
  }

  static List<ProviderInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderInput> mapFromJson(dynamic json) {
    final map = <String, ProviderInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderInput-objects as value to a dart map
  static Map<String, List<ProviderInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'kind',
    'name',
    'legalName',
    'rtn',
    'baseCity',
    'phone',
    'instagram',
    'paymentInstructions',
    'rif',
  };
}


enum ProviderInputKindEnum {
  person._(r'person'),
  company._(r'company'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProviderInputKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProviderInputKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProviderInputKindEnum? fromJson(dynamic value) => ProviderInputKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProviderInputKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProviderInputKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderInputKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderInputKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProviderInputKindEnum] to String,
/// and [decode] dynamic data back to [ProviderInputKindEnum].
class ProviderInputKindEnumTypeTransformer {
  factory ProviderInputKindEnumTypeTransformer() => _instance ??= const ProviderInputKindEnumTypeTransformer._();

  const ProviderInputKindEnumTypeTransformer._();

  String encode(ProviderInputKindEnum data) => data._value;

  /// Returns the instance of [ProviderInputKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProviderInputKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProviderInputKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'person': return ProviderInputKindEnum.person;
        case r'company': return ProviderInputKindEnum.company;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProviderInputKindEnumTypeTransformer? _instance;
}


