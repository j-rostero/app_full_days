//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeclareFileInput {
  /// Returns a new [DeclareFileInput] instance.
  DeclareFileInput({
    required this.kind,
    required this.contentType,
    required this.size,
  });

  DeclareFileInputKindEnum kind;

  String contentType;

  /// Minimum value: 1
  /// Maximum value: 10485760
  int size;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeclareFileInput &&
    other.kind == kind &&
    other.contentType == contentType &&
    other.size == size;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (kind.hashCode) +
    (contentType.hashCode) +
    (size.hashCode);

  @override
  String toString() => 'DeclareFileInput[kind=$kind, contentType=$contentType, size=$size]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'kind'] = this.kind;
      json[r'contentType'] = this.contentType;
      json[r'size'] = this.size;
    return json;
  }

  /// Returns a new [DeclareFileInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeclareFileInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'kind'), 'Required key "DeclareFileInput[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "DeclareFileInput[kind]" has a null value in JSON.');
        assert(json.containsKey(r'contentType'), 'Required key "DeclareFileInput[contentType]" is missing from JSON.');
        assert(json[r'contentType'] != null, 'Required key "DeclareFileInput[contentType]" has a null value in JSON.');
        assert(json.containsKey(r'size'), 'Required key "DeclareFileInput[size]" is missing from JSON.');
        assert(json[r'size'] != null, 'Required key "DeclareFileInput[size]" has a null value in JSON.');
        return true;
      }());

      return DeclareFileInput(
        kind: DeclareFileInputKindEnum.fromJson(json[r'kind'])!,
        contentType: mapValueOfType<String>(json, r'contentType')!,
        size: mapValueOfType<int>(json, r'size')!,
      );
    }
    return null;
  }

  static List<DeclareFileInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeclareFileInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeclareFileInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeclareFileInput> mapFromJson(dynamic json) {
    final map = <String, DeclareFileInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeclareFileInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeclareFileInput-objects as value to a dart map
  static Map<String, List<DeclareFileInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeclareFileInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeclareFileInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'kind',
    'contentType',
    'size',
  };
}


enum DeclareFileInputKindEnum {
  image._(r'image'),
  document._(r'document'),
  ;

  /// Instantiate a new enum with the provided value.
  const DeclareFileInputKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DeclareFileInputKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DeclareFileInputKindEnum? fromJson(dynamic value) => DeclareFileInputKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DeclareFileInputKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DeclareFileInputKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeclareFileInputKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeclareFileInputKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DeclareFileInputKindEnum] to String,
/// and [decode] dynamic data back to [DeclareFileInputKindEnum].
class DeclareFileInputKindEnumTypeTransformer {
  factory DeclareFileInputKindEnumTypeTransformer() => _instance ??= const DeclareFileInputKindEnumTypeTransformer._();

  const DeclareFileInputKindEnumTypeTransformer._();

  String encode(DeclareFileInputKindEnum data) => data._value;

  /// Returns the instance of [DeclareFileInputKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DeclareFileInputKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DeclareFileInputKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'image': return DeclareFileInputKindEnum.image;
        case r'document': return DeclareFileInputKindEnum.document;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DeclareFileInputKindEnumTypeTransformer? _instance;
}


