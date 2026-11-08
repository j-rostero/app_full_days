//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DeclaredFile {
  /// Returns a new [DeclaredFile] instance.
  DeclaredFile({
    required this.file,
    required this.upload,
  });

  File file;

  DeclaredFileUpload upload;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DeclaredFile &&
    other.file == file &&
    other.upload == upload;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (file.hashCode) +
    (upload.hashCode);

  @override
  String toString() => 'DeclaredFile[file=$file, upload=$upload]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'file'] = this.file;
      json[r'upload'] = this.upload;
    return json;
  }

  /// Returns a new [DeclaredFile] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DeclaredFile? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'file'), 'Required key "DeclaredFile[file]" is missing from JSON.');
        assert(json[r'file'] != null, 'Required key "DeclaredFile[file]" has a null value in JSON.');
        assert(json.containsKey(r'upload'), 'Required key "DeclaredFile[upload]" is missing from JSON.');
        assert(json[r'upload'] != null, 'Required key "DeclaredFile[upload]" has a null value in JSON.');
        return true;
      }());

      return DeclaredFile(
        file: File.fromJson(json[r'file'])!,
        upload: DeclaredFileUpload.fromJson(json[r'upload'])!,
      );
    }
    return null;
  }

  static List<DeclaredFile> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DeclaredFile>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DeclaredFile.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DeclaredFile> mapFromJson(dynamic json) {
    final map = <String, DeclaredFile>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DeclaredFile.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DeclaredFile-objects as value to a dart map
  static Map<String, List<DeclaredFile>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DeclaredFile>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DeclaredFile.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'file',
    'upload',
  };
}

