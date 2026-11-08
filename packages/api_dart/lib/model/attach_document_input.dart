//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AttachDocumentInput {
  /// Returns a new [AttachDocumentInput] instance.
  AttachDocumentInput({
    required this.type,
    required this.fileId,
  });

  AttachDocumentInputTypeEnum type;

  String fileId;

  @override
  bool operator ==(Object other) => identical(this, other) || other is AttachDocumentInput &&
    other.type == type &&
    other.fileId == fileId;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (type.hashCode) +
    (fileId.hashCode);

  @override
  String toString() => 'AttachDocumentInput[type=$type, fileId=$fileId]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'type'] = this.type;
      json[r'fileId'] = this.fileId;
    return json;
  }

  /// Returns a new [AttachDocumentInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AttachDocumentInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'type'), 'Required key "AttachDocumentInput[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "AttachDocumentInput[type]" has a null value in JSON.');
        assert(json.containsKey(r'fileId'), 'Required key "AttachDocumentInput[fileId]" is missing from JSON.');
        assert(json[r'fileId'] != null, 'Required key "AttachDocumentInput[fileId]" has a null value in JSON.');
        return true;
      }());

      return AttachDocumentInput(
        type: AttachDocumentInputTypeEnum.fromJson(json[r'type'])!,
        fileId: mapValueOfType<String>(json, r'fileId')!,
      );
    }
    return null;
  }

  static List<AttachDocumentInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttachDocumentInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttachDocumentInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AttachDocumentInput> mapFromJson(dynamic json) {
    final map = <String, AttachDocumentInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AttachDocumentInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AttachDocumentInput-objects as value to a dart map
  static Map<String, List<AttachDocumentInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<AttachDocumentInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AttachDocumentInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'type',
    'fileId',
  };
}


enum AttachDocumentInputTypeEnum {
  rif._(r'rif'),
  representativeId._(r'representative_id'),
  rtn._(r'rtn'),
  commercialRegistry._(r'commercial_registry'),
  other._(r'other'),
  ;

  /// Instantiate a new enum with the provided value.
  const AttachDocumentInputTypeEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [AttachDocumentInputTypeEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static AttachDocumentInputTypeEnum? fromJson(dynamic value) => AttachDocumentInputTypeEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [AttachDocumentInputTypeEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<AttachDocumentInputTypeEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <AttachDocumentInputTypeEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AttachDocumentInputTypeEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [AttachDocumentInputTypeEnum] to String,
/// and [decode] dynamic data back to [AttachDocumentInputTypeEnum].
class AttachDocumentInputTypeEnumTypeTransformer {
  factory AttachDocumentInputTypeEnumTypeTransformer() => _instance ??= const AttachDocumentInputTypeEnumTypeTransformer._();

  const AttachDocumentInputTypeEnumTypeTransformer._();

  String encode(AttachDocumentInputTypeEnum data) => data._value;

  /// Returns the instance of [AttachDocumentInputTypeEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  AttachDocumentInputTypeEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is AttachDocumentInputTypeEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'rif': return AttachDocumentInputTypeEnum.rif;
        case r'representative_id': return AttachDocumentInputTypeEnum.representativeId;
        case r'rtn': return AttachDocumentInputTypeEnum.rtn;
        case r'commercial_registry': return AttachDocumentInputTypeEnum.commercialRegistry;
        case r'other': return AttachDocumentInputTypeEnum.other;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static AttachDocumentInputTypeEnumTypeTransformer? _instance;
}


