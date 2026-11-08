//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class File {
  /// Returns a new [File] instance.
  File({
    required this.id,
    required this.kind,
    required this.contentType,
    required this.size,
    required this.status,
    required this.image,
    required this.downloadUrl,
  });

  String id;

  FileKindEnum kind;

  String contentType;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int size;

  FileStatusEnum status;

  ImageUrls? image;

  String? downloadUrl;

  @override
  bool operator ==(Object other) => identical(this, other) || other is File &&
    other.id == id &&
    other.kind == kind &&
    other.contentType == contentType &&
    other.size == size &&
    other.status == status &&
    other.image == image &&
    other.downloadUrl == downloadUrl;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (kind.hashCode) +
    (contentType.hashCode) +
    (size.hashCode) +
    (status.hashCode) +
    (image == null ? 0 : image!.hashCode) +
    (downloadUrl == null ? 0 : downloadUrl!.hashCode);

  @override
  String toString() => 'File[id=$id, kind=$kind, contentType=$contentType, size=$size, status=$status, image=$image, downloadUrl=$downloadUrl]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'kind'] = this.kind;
      json[r'contentType'] = this.contentType;
      json[r'size'] = this.size;
      json[r'status'] = this.status;
    if (this.image != null) {
      json[r'image'] = this.image;
    } else {
      json[r'image'] = null;
    }
    if (this.downloadUrl != null) {
      json[r'downloadUrl'] = this.downloadUrl;
    } else {
      json[r'downloadUrl'] = null;
    }
    return json;
  }

  /// Returns a new [File] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static File? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "File[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "File[id]" has a null value in JSON.');
        assert(json.containsKey(r'kind'), 'Required key "File[kind]" is missing from JSON.');
        assert(json[r'kind'] != null, 'Required key "File[kind]" has a null value in JSON.');
        assert(json.containsKey(r'contentType'), 'Required key "File[contentType]" is missing from JSON.');
        assert(json[r'contentType'] != null, 'Required key "File[contentType]" has a null value in JSON.');
        assert(json.containsKey(r'size'), 'Required key "File[size]" is missing from JSON.');
        assert(json[r'size'] != null, 'Required key "File[size]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "File[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "File[status]" has a null value in JSON.');
        assert(json.containsKey(r'image'), 'Required key "File[image]" is missing from JSON.');
        assert(json.containsKey(r'downloadUrl'), 'Required key "File[downloadUrl]" is missing from JSON.');
        return true;
      }());

      return File(
        id: mapValueOfType<String>(json, r'id')!,
        kind: FileKindEnum.fromJson(json[r'kind'])!,
        contentType: mapValueOfType<String>(json, r'contentType')!,
        size: mapValueOfType<int>(json, r'size')!,
        status: FileStatusEnum.fromJson(json[r'status'])!,
        image: ImageUrls.fromJson(json[r'image']),
        downloadUrl: mapValueOfType<String>(json, r'downloadUrl'),
      );
    }
    return null;
  }

  static List<File> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <File>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = File.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, File> mapFromJson(dynamic json) {
    final map = <String, File>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = File.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of File-objects as value to a dart map
  static Map<String, List<File>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<File>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = File.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'kind',
    'contentType',
    'size',
    'status',
    'image',
    'downloadUrl',
  };
}


enum FileKindEnum {
  image._(r'image'),
  document._(r'document'),
  ;

  /// Instantiate a new enum with the provided value.
  const FileKindEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [FileKindEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static FileKindEnum? fromJson(dynamic value) => FileKindEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [FileKindEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<FileKindEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileKindEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileKindEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FileKindEnum] to String,
/// and [decode] dynamic data back to [FileKindEnum].
class FileKindEnumTypeTransformer {
  factory FileKindEnumTypeTransformer() => _instance ??= const FileKindEnumTypeTransformer._();

  const FileKindEnumTypeTransformer._();

  String encode(FileKindEnum data) => data._value;

  /// Returns the instance of [FileKindEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FileKindEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is FileKindEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'image': return FileKindEnum.image;
        case r'document': return FileKindEnum.document;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static FileKindEnumTypeTransformer? _instance;
}



enum FileStatusEnum {
  pending._(r'pending'),
  ready._(r'ready'),
  ;

  /// Instantiate a new enum with the provided value.
  const FileStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [FileStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static FileStatusEnum? fromJson(dynamic value) => FileStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [FileStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<FileStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <FileStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = FileStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [FileStatusEnum] to String,
/// and [decode] dynamic data back to [FileStatusEnum].
class FileStatusEnumTypeTransformer {
  factory FileStatusEnumTypeTransformer() => _instance ??= const FileStatusEnumTypeTransformer._();

  const FileStatusEnumTypeTransformer._();

  String encode(FileStatusEnum data) => data._value;

  /// Returns the instance of [FileStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  FileStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is FileStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'pending': return FileStatusEnum.pending;
        case r'ready': return FileStatusEnum.ready;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static FileStatusEnumTypeTransformer? _instance;
}


