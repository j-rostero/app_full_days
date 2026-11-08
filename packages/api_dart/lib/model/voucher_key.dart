//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class VoucherKey {
  /// Returns a new [VoucherKey] instance.
  VoucherKey({
    required this.id,
    required this.publicKey,
    required this.retired,
  });

  String id;

  String publicKey;

  bool retired;

  @override
  bool operator ==(Object other) => identical(this, other) || other is VoucherKey &&
    other.id == id &&
    other.publicKey == publicKey &&
    other.retired == retired;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (publicKey.hashCode) +
    (retired.hashCode);

  @override
  String toString() => 'VoucherKey[id=$id, publicKey=$publicKey, retired=$retired]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'publicKey'] = this.publicKey;
      json[r'retired'] = this.retired;
    return json;
  }

  /// Returns a new [VoucherKey] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static VoucherKey? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "VoucherKey[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "VoucherKey[id]" has a null value in JSON.');
        assert(json.containsKey(r'publicKey'), 'Required key "VoucherKey[publicKey]" is missing from JSON.');
        assert(json[r'publicKey'] != null, 'Required key "VoucherKey[publicKey]" has a null value in JSON.');
        assert(json.containsKey(r'retired'), 'Required key "VoucherKey[retired]" is missing from JSON.');
        assert(json[r'retired'] != null, 'Required key "VoucherKey[retired]" has a null value in JSON.');
        return true;
      }());

      return VoucherKey(
        id: mapValueOfType<String>(json, r'id')!,
        publicKey: mapValueOfType<String>(json, r'publicKey')!,
        retired: mapValueOfType<bool>(json, r'retired')!,
      );
    }
    return null;
  }

  static List<VoucherKey> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <VoucherKey>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = VoucherKey.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, VoucherKey> mapFromJson(dynamic json) {
    final map = <String, VoucherKey>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = VoucherKey.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of VoucherKey-objects as value to a dart map
  static Map<String, List<VoucherKey>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<VoucherKey>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = VoucherKey.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'publicKey',
    'retired',
  };
}

