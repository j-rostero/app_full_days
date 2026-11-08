//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AuditEntry {
  /// Returns a new [AuditEntry] instance.
  AuditEntry({
    required this.id,
    required this.actor,
    required this.scope,
    required this.providerId,
    required this.action,
    required this.params,
    required this.input,
    required this.before,
    required this.after,
    required this.createdAt,
  });

  String id;

  AuditEntryActor actor;

  AuditEntryScopeEnum scope;

  String? providerId;

  String action;

  Object? params;

  Object? input;

  Object? before;

  Object? after;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AuditEntry &&
    other.id == id &&
    other.actor == actor &&
    other.scope == scope &&
    other.providerId == providerId &&
    other.action == action &&
    other.params == params &&
    other.input == input &&
    other.before == before &&
    other.after == after &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (actor.hashCode) +
    (scope.hashCode) +
    (providerId == null ? 0 : providerId!.hashCode) +
    (action.hashCode) +
    (params == null ? 0 : params!.hashCode) +
    (input == null ? 0 : input!.hashCode) +
    (before == null ? 0 : before!.hashCode) +
    (after == null ? 0 : after!.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'AuditEntry[id=$id, actor=$actor, scope=$scope, providerId=$providerId, action=$action, params=$params, input=$input, before=$before, after=$after, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'actor'] = this.actor;
      json[r'scope'] = this.scope;
    if (this.providerId != null) {
      json[r'providerId'] = this.providerId;
    } else {
      json[r'providerId'] = null;
    }
      json[r'action'] = this.action;
    if (this.params != null) {
      json[r'params'] = this.params;
    } else {
      json[r'params'] = null;
    }
    if (this.input != null) {
      json[r'input'] = this.input;
    } else {
      json[r'input'] = null;
    }
    if (this.before != null) {
      json[r'before'] = this.before;
    } else {
      json[r'before'] = null;
    }
    if (this.after != null) {
      json[r'after'] = this.after;
    } else {
      json[r'after'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [AuditEntry] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AuditEntry? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "AuditEntry[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "AuditEntry[id]" has a null value in JSON.');
        assert(json.containsKey(r'actor'), 'Required key "AuditEntry[actor]" is missing from JSON.');
        assert(json[r'actor'] != null, 'Required key "AuditEntry[actor]" has a null value in JSON.');
        assert(json.containsKey(r'scope'), 'Required key "AuditEntry[scope]" is missing from JSON.');
        assert(json[r'scope'] != null, 'Required key "AuditEntry[scope]" has a null value in JSON.');
        assert(json.containsKey(r'providerId'), 'Required key "AuditEntry[providerId]" is missing from JSON.');
        assert(json.containsKey(r'action'), 'Required key "AuditEntry[action]" is missing from JSON.');
        assert(json[r'action'] != null, 'Required key "AuditEntry[action]" has a null value in JSON.');
        assert(json.containsKey(r'params'), 'Required key "AuditEntry[params]" is missing from JSON.');
        assert(json.containsKey(r'input'), 'Required key "AuditEntry[input]" is missing from JSON.');
        assert(json.containsKey(r'before'), 'Required key "AuditEntry[before]" is missing from JSON.');
        assert(json.containsKey(r'after'), 'Required key "AuditEntry[after]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "AuditEntry[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "AuditEntry[createdAt]" has a null value in JSON.');
        return true;
      }());

      return AuditEntry(
        id: mapValueOfType<String>(json, r'id')!,
        actor: AuditEntryActor.fromJson(json[r'actor'])!,
        scope: AuditEntryScopeEnum.fromJson(json[r'scope'])!,
        providerId: mapValueOfType<String>(json, r'providerId'),
        action: mapValueOfType<String>(json, r'action')!,
        params: mapValueOfType<Object>(json, r'params'),
        input: mapValueOfType<Object>(json, r'input'),
        before: mapValueOfType<Object>(json, r'before'),
        after: mapValueOfType<Object>(json, r'after'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<AuditEntry> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuditEntry>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuditEntry.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AuditEntry> mapFromJson(dynamic json) {
    final map = <String, AuditEntry>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AuditEntry.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AuditEntry-objects as value to a dart map
  static Map<String, List<AuditEntry>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AuditEntry>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AuditEntry.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'actor',
    'scope',
    'providerId',
    'action',
    'params',
    'input',
    'before',
    'after',
    'createdAt',
  };
}


enum AuditEntryScopeEnum {
  provider._(r'provider'),
  central._(r'central'),
  ;

  /// Instantiate a new enum with the provided value.
  const AuditEntryScopeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AuditEntryScopeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AuditEntryScopeEnum? fromJson(dynamic value) => AuditEntryScopeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AuditEntryScopeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AuditEntryScopeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AuditEntryScopeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AuditEntryScopeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AuditEntryScopeEnum] to String,
/// and [decode] dynamic data back to [AuditEntryScopeEnum].
class AuditEntryScopeEnumTypeTransformer {
  factory AuditEntryScopeEnumTypeTransformer() => _instance ??= const AuditEntryScopeEnumTypeTransformer._();

  const AuditEntryScopeEnumTypeTransformer._();

  String encode(AuditEntryScopeEnum data) => data._value;

  /// Returns the instance of [AuditEntryScopeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AuditEntryScopeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AuditEntryScopeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'provider': return AuditEntryScopeEnum.provider;
        case r'central': return AuditEntryScopeEnum.central;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AuditEntryScopeEnumTypeTransformer? _instance;
}


