//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CommissionInput {
  /// Returns a new [CommissionInput] instance.
  CommissionInput({
    required this.commissionPercent,
  });

  /// Minimum value: 0
  /// Maximum value: 50
  num? commissionPercent;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CommissionInput &&
    other.commissionPercent == commissionPercent;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (commissionPercent == null ? 0 : commissionPercent!.hashCode);

  @override
  String toString() => 'CommissionInput[commissionPercent=$commissionPercent]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.commissionPercent != null) {
      json[r'commissionPercent'] = this.commissionPercent;
    } else {
      json[r'commissionPercent'] = null;
    }
    return json;
  }

  /// Returns a new [CommissionInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CommissionInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'commissionPercent'), 'Required key "CommissionInput[commissionPercent]" is missing from JSON.');
        return true;
      }());

      return CommissionInput(
        commissionPercent: json[r'commissionPercent'] == null
            ? null
            : num.parse('${json[r'commissionPercent']}'),
      );
    }
    return null;
  }

  static List<CommissionInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CommissionInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CommissionInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CommissionInput> mapFromJson(dynamic json) {
    final map = <String, CommissionInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CommissionInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CommissionInput-objects as value to a dart map
  static Map<String, List<CommissionInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CommissionInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CommissionInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'commissionPercent',
  };
}

