//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Company {
  /// Returns a new [Company] instance.
  Company({
    required this.id,
    required this.kind,
    required this.name,
    required this.legalName,
    required this.rif,
    required this.rtn,
    required this.baseCity,
    required this.phone,
    required this.instagram,
    required this.paymentInstructions,
    required this.status,
    required this.statusReason,
    required this.badge,
    required this.commissionPercent,
    this.missingDocuments = const [],
  });

  String id;

  CompanyKindEnum kind;

  String name;

  String legalName;

  String rif;

  String? rtn;

  String baseCity;

  String phone;

  String? instagram;

  String? paymentInstructions;

  ProviderStatus status;

  String? statusReason;

  CompanyBadgeEnum? badge;

  num? commissionPercent;

  List<ProviderDocumentType> missingDocuments;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Company &&
    other.id == id &&
    other.kind == kind &&
    other.name == name &&
    other.legalName == legalName &&
    other.rif == rif &&
    other.rtn == rtn &&
    other.baseCity == baseCity &&
    other.phone == phone &&
    other.instagram == instagram &&
    other.paymentInstructions == paymentInstructions &&
    other.status == status &&
    other.statusReason == statusReason &&
    other.badge == badge &&
    other.commissionPercent == commissionPercent &&
    _deepEquality.equals(other.missingDocuments, missingDocuments);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (kind.hashCode) +
    (name.hashCode) +
    (legalName.hashCode) +
    (rif.hashCode) +
    (rtn == null ? 0 : rtn!.hashCode) +
    (baseCity.hashCode) +
    (phone.hashCode) +
    (instagram == null ? 0 : instagram!.hashCode) +
    (paymentInstructions == null ? 0 : paymentInstructions!.hashCode) +
    (status.hashCode) +
    (statusReason == null ? 0 : statusReason!.hashCode) +
    (badge == null ? 0 : badge!.hashCode) +
    (commissionPercent == null ? 0 : commissionPercent!.hashCode) +
    (missingDocuments.hashCode);

  @override
  String toString() => 'Company[id=$id, kind=$kind, name=$name, legalName=$legalName, rif=$rif, rtn=$rtn, baseCity=$baseCity, phone=$phone, instagram=$instagram, paymentInstructions=$paymentInstructions, status=$status, statusReason=$statusReason, badge=$badge, commissionPercent=$commissionPercent, missingDocuments=$missingDocuments]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'kind'] = this.kind;
      json[r'name'] = this.name;
      json[r'legalName'] = this.legalName;
      json[r'rif'] = this.rif;
    if (this.rtn != null) {
      json[r'rtn'] = this.rtn;
    } else {
      json[r'rtn'] = null;
    }
      json[r'baseCity'] = this.baseCity;
      json[r'phone'] = this.phone;
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
      json[r'status'] = this.status;
    if (this.statusReason != null) {
      json[r'statusReason'] = this.statusReason;
    } else {
      json[r'statusReason'] = null;
    }
    if (this.badge != null) {
      json[r'badge'] = this.badge;
    } else {
      json[r'badge'] = null;
    }
    if (this.commissionPercent != null) {
      json[r'commissionPercent'] = this.commissionPercent;
    } else {
      json[r'commissionPercent'] = null;
    }
      json[r'missingDocuments'] = this.missingDocuments;
    return json;
  }

  /// Returns a new [Company] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Company? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Company[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Company[id]" has a null value in JSON.');
        assert(json.containsKey(r'kind'), 'Required key "Company[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "Company[kind]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "Company[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "Company[name]" has a null value in JSON.');
        assert(json.containsKey(r'legalName'), 'Required key "Company[legalName]" is missing from JSON.');
        assert(json[r'legalName'] != null, 'Required key "Company[legalName]" has a null value in JSON.');
        assert(json.containsKey(r'rif'), 'Required key "Company[rif]" is missing from JSON.');
        assert(json[r'rif'] != null, 'Required key "Company[rif]" has a null value in JSON.');
        assert(json.containsKey(r'rtn'), 'Required key "Company[rtn]" is missing from JSON.');
        assert(json.containsKey(r'baseCity'), 'Required key "Company[baseCity]" is missing from JSON.');
        assert(json[r'baseCity'] != null, 'Required key "Company[baseCity]" has a null value in JSON.');
        assert(json.containsKey(r'phone'), 'Required key "Company[phone]" is missing from JSON.');
        assert(json[r'phone'] != null, 'Required key "Company[phone]" has a null value in JSON.');
        assert(json.containsKey(r'instagram'), 'Required key "Company[instagram]" is missing from JSON.');
        assert(json.containsKey(r'paymentInstructions'), 'Required key "Company[paymentInstructions]" is missing from JSON.');
        assert(json.containsKey(r'status'), 'Required key "Company[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Company[status]" has a null value in JSON.');
        assert(json.containsKey(r'statusReason'), 'Required key "Company[statusReason]" is missing from JSON.');
        assert(json.containsKey(r'badge'), 'Required key "Company[badge]" is missing from JSON.');
        assert(json.containsKey(r'commissionPercent'), 'Required key "Company[commissionPercent]" is missing from JSON.');
        assert(json.containsKey(r'missingDocuments'), 'Required key "Company[missingDocuments]" is missing from JSON.');
        assert(json[r'missingDocuments'] != null, 'Required key "Company[missingDocuments]" has a null value in JSON.');
        return true;
      }());

      return Company(
        id: mapValueOfType<String>(json, r'id')!,
        kind: CompanyKindEnum.fromJson(json[r'kind'])!,
        name: mapValueOfType<String>(json, r'name')!,
        legalName: mapValueOfType<String>(json, r'legalName')!,
        rif: mapValueOfType<String>(json, r'rif')!,
        rtn: mapValueOfType<String>(json, r'rtn'),
        baseCity: mapValueOfType<String>(json, r'baseCity')!,
        phone: mapValueOfType<String>(json, r'phone')!,
        instagram: mapValueOfType<String>(json, r'instagram'),
        paymentInstructions: mapValueOfType<String>(json, r'paymentInstructions'),
        status: ProviderStatus.fromJson(json[r'status'])!,
        statusReason: mapValueOfType<String>(json, r'statusReason'),
        badge: CompanyBadgeEnum.fromJson(json[r'badge']),
        commissionPercent: json[r'commissionPercent'] == null
            ? null
            : num.parse('${json[r'commissionPercent']}'),
        missingDocuments: ProviderDocumentType.listFromJson(json[r'missingDocuments']),
      );
    }
    return null;
  }

  static List<Company> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Company>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Company.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Company> mapFromJson(dynamic json) {
    final map = <String, Company>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Company.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Company-objects as value to a dart map
  static Map<String, List<Company>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Company>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Company.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'kind',
    'name',
    'legalName',
    'rif',
    'rtn',
    'baseCity',
    'phone',
    'instagram',
    'paymentInstructions',
    'status',
    'statusReason',
    'badge',
    'commissionPercent',
    'missingDocuments',
  };
}


enum CompanyKindEnum {
  person._(r'person'),
  company._(r'company'),
  ;

  /// Instantiate a new enum with the provided value.
  const CompanyKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CompanyKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CompanyKindEnum? fromJson(dynamic value) => CompanyKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CompanyKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CompanyKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CompanyKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CompanyKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CompanyKindEnum] to String,
/// and [decode] dynamic data back to [CompanyKindEnum].
class CompanyKindEnumTypeTransformer {
  factory CompanyKindEnumTypeTransformer() => _instance ??= const CompanyKindEnumTypeTransformer._();

  const CompanyKindEnumTypeTransformer._();

  String encode(CompanyKindEnum data) => data._value;

  /// Returns the instance of [CompanyKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CompanyKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is CompanyKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'person': return CompanyKindEnum.person;
        case r'company': return CompanyKindEnum.company;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CompanyKindEnumTypeTransformer? _instance;
}



enum CompanyBadgeEnum {
  verified._(r'verified'),
  new_._(r'new'),
  ;

  /// Instantiate a new enum with the provided value.
  const CompanyBadgeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CompanyBadgeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CompanyBadgeEnum? fromJson(dynamic value) => CompanyBadgeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CompanyBadgeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CompanyBadgeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CompanyBadgeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CompanyBadgeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CompanyBadgeEnum] to String,
/// and [decode] dynamic data back to [CompanyBadgeEnum].
class CompanyBadgeEnumTypeTransformer {
  factory CompanyBadgeEnumTypeTransformer() => _instance ??= const CompanyBadgeEnumTypeTransformer._();

  const CompanyBadgeEnumTypeTransformer._();

  String encode(CompanyBadgeEnum data) => data._value;

  /// Returns the instance of [CompanyBadgeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CompanyBadgeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is CompanyBadgeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'verified': return CompanyBadgeEnum.verified;
        case r'new': return CompanyBadgeEnum.new_;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CompanyBadgeEnumTypeTransformer? _instance;
}


