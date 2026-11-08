//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PayRefundInput {
  /// Returns a new [PayRefundInput] instance.
  PayRefundInput({
    required this.reference,
  });

  String? reference;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PayRefundInput &&
    other.reference == reference;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (reference == null ? 0 : reference!.hashCode);

  @override
  String toString() => 'PayRefundInput[reference=$reference]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.reference != null) {
      json[r'reference'] = this.reference;
    } else {
      json[r'reference'] = null;
    }
    return json;
  }

  /// Returns a new [PayRefundInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PayRefundInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'reference'), 'Required key "PayRefundInput[reference]" is missing from JSON.');
        return true;
      }());

      return PayRefundInput(
        reference: mapValueOfType<String>(json, r'reference'),
      );
    }
    return null;
  }

  static List<PayRefundInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PayRefundInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PayRefundInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PayRefundInput> mapFromJson(dynamic json) {
    final map = <String, PayRefundInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PayRefundInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PayRefundInput-objects as value to a dart map
  static Map<String, List<PayRefundInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PayRefundInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PayRefundInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'reference',
  };
}

