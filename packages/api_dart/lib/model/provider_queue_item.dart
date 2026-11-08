//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderQueueItem {
  /// Returns a new [ProviderQueueItem] instance.
  ProviderQueueItem({
    required this.id,
    required this.name,
    required this.kind,
    required this.rif,
    required this.baseCity,
    required this.status,
    required this.hasRtn,
    required this.submittedAt,
  });

  String id;

  String name;

  ProviderQueueItemKindEnum kind;

  String rif;

  String baseCity;

  ProviderStatus status;

  bool hasRtn;

  DateTime? submittedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderQueueItem &&
    other.id == id &&
    other.name == name &&
    other.kind == kind &&
    other.rif == rif &&
    other.baseCity == baseCity &&
    other.status == status &&
    other.hasRtn == hasRtn &&
    other.submittedAt == submittedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (kind.hashCode) +
    (rif.hashCode) +
    (baseCity.hashCode) +
    (status.hashCode) +
    (hasRtn.hashCode) +
    (submittedAt == null ? 0 : submittedAt!.hashCode);

  @override
  String toString() => 'ProviderQueueItem[id=$id, name=$name, kind=$kind, rif=$rif, baseCity=$baseCity, status=$status, hasRtn=$hasRtn, submittedAt=$submittedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'kind'] = this.kind;
      json[r'rif'] = this.rif;
      json[r'baseCity'] = this.baseCity;
      json[r'status'] = this.status;
      json[r'hasRtn'] = this.hasRtn;
    if (this.submittedAt != null) {
      json[r'submittedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.submittedAt!.millisecondsSinceEpoch
        : this.submittedAt!.toUtc().toIso8601String();
    } else {
      json[r'submittedAt'] = null;
    }
    return json;
  }

  /// Returns a new [ProviderQueueItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderQueueItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProviderQueueItem[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProviderQueueItem[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProviderQueueItem[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProviderQueueItem[name]" has a null value in JSON.');
        assert(json.containsKey(r'kind'), 'Required key "ProviderQueueItem[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "ProviderQueueItem[kind]" has a null value in JSON.');
        assert(json.containsKey(r'rif'), 'Required key "ProviderQueueItem[rif]" is missing from JSON.');
        assert(json[r'rif'] != null, 'Required key "ProviderQueueItem[rif]" has a null value in JSON.');
        assert(json.containsKey(r'baseCity'), 'Required key "ProviderQueueItem[baseCity]" is missing from JSON.');
        assert(json[r'baseCity'] != null, 'Required key "ProviderQueueItem[baseCity]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "ProviderQueueItem[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "ProviderQueueItem[status]" has a null value in JSON.');
        assert(json.containsKey(r'hasRtn'), 'Required key "ProviderQueueItem[hasRtn]" is missing from JSON.');
        assert(json[r'hasRtn'] != null, 'Required key "ProviderQueueItem[hasRtn]" has a null value in JSON.');
        assert(json.containsKey(r'submittedAt'), 'Required key "ProviderQueueItem[submittedAt]" is missing from JSON.');
        return true;
      }());

      return ProviderQueueItem(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        kind: ProviderQueueItemKindEnum.fromJson(json[r'kind'])!,
        rif: mapValueOfType<String>(json, r'rif')!,
        baseCity: mapValueOfType<String>(json, r'baseCity')!,
        status: ProviderStatus.fromJson(json[r'status'])!,
        hasRtn: mapValueOfType<bool>(json, r'hasRtn')!,
        submittedAt: mapDateTime(json, r'submittedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
      );
    }
    return null;
  }

  static List<ProviderQueueItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderQueueItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderQueueItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderQueueItem> mapFromJson(dynamic json) {
    final map = <String, ProviderQueueItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderQueueItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderQueueItem-objects as value to a dart map
  static Map<String, List<ProviderQueueItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderQueueItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderQueueItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'kind',
    'rif',
    'baseCity',
    'status',
    'hasRtn',
    'submittedAt',
  };
}


enum ProviderQueueItemKindEnum {
  person._(r'person'),
  company._(r'company'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProviderQueueItemKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProviderQueueItemKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProviderQueueItemKindEnum? fromJson(dynamic value) => ProviderQueueItemKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProviderQueueItemKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProviderQueueItemKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderQueueItemKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderQueueItemKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProviderQueueItemKindEnum] to String,
/// and [decode] dynamic data back to [ProviderQueueItemKindEnum].
class ProviderQueueItemKindEnumTypeTransformer {
  factory ProviderQueueItemKindEnumTypeTransformer() => _instance ??= const ProviderQueueItemKindEnumTypeTransformer._();

  const ProviderQueueItemKindEnumTypeTransformer._();

  String encode(ProviderQueueItemKindEnum data) => data._value;

  /// Returns the instance of [ProviderQueueItemKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProviderQueueItemKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProviderQueueItemKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'person': return ProviderQueueItemKindEnum.person;
        case r'company': return ProviderQueueItemKindEnum.company;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProviderQueueItemKindEnumTypeTransformer? _instance;
}


