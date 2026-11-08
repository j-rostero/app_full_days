//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderDocument {
  /// Returns a new [ProviderDocument] instance.
  ProviderDocument({
    required this.id,
    required this.type,
    required this.fileId,
    required this.contentType,
    required this.downloadUrl,
    required this.createdAt,
  });

  String id;

  ProviderDocumentType type;

  String fileId;

  String contentType;

  String downloadUrl;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderDocument &&
    other.id == id &&
    other.type == type &&
    other.fileId == fileId &&
    other.contentType == contentType &&
    other.downloadUrl == downloadUrl &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (fileId.hashCode) +
    (contentType.hashCode) +
    (downloadUrl.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'ProviderDocument[id=$id, type=$type, fileId=$fileId, contentType=$contentType, downloadUrl=$downloadUrl, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'fileId'] = this.fileId;
      json[r'contentType'] = this.contentType;
      json[r'downloadUrl'] = this.downloadUrl;
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ProviderDocument] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderDocument? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProviderDocument[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProviderDocument[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProviderDocument[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProviderDocument[type]" has a null value in JSON.');
        assert(json.containsKey(r'fileId'), 'Required key "ProviderDocument[fileId]" is missing from JSON.');
        assert(json[r'fileId'] != null, 'Required key "ProviderDocument[fileId]" has a null value in JSON.');
        assert(json.containsKey(r'contentType'), 'Required key "ProviderDocument[contentType]" is missing from JSON.');
        assert(json[r'contentType'] != null, 'Required key "ProviderDocument[contentType]" has a null value in JSON.');
        assert(json.containsKey(r'downloadUrl'), 'Required key "ProviderDocument[downloadUrl]" is missing from JSON.');
        assert(json[r'downloadUrl'] != null, 'Required key "ProviderDocument[downloadUrl]" has a null value in JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "ProviderDocument[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "ProviderDocument[createdAt]" has a null value in JSON.');
        return true;
      }());

      return ProviderDocument(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProviderDocumentType.fromJson(json[r'type'])!,
        fileId: mapValueOfType<String>(json, r'fileId')!,
        contentType: mapValueOfType<String>(json, r'contentType')!,
        downloadUrl: mapValueOfType<String>(json, r'downloadUrl')!,
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<ProviderDocument> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderDocument>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderDocument.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderDocument> mapFromJson(dynamic json) {
    final map = <String, ProviderDocument>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderDocument.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderDocument-objects as value to a dart map
  static Map<String, List<ProviderDocument>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderDocument>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderDocument.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'fileId',
    'contentType',
    'downloadUrl',
    'createdAt',
  };
}

