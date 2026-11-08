//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DestinationFee {
  /// Returns a new [DestinationFee] instance.
  DestinationFee({
    required this.id,
    required this.name,
    required this.amountUsd,
    required this.payment,
  });

  String id;

  String name;

  num amountUsd;

  String payment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DestinationFee &&
    other.id == id &&
    other.name == name &&
    other.amountUsd == amountUsd &&
    other.payment == payment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (name.hashCode) +
    (amountUsd.hashCode) +
    (payment.hashCode);

  @override
  String toString() => 'DestinationFee[id=$id, name=$name, amountUsd=$amountUsd, payment=$payment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'name'] = this.name;
      json[r'amountUsd'] = this.amountUsd;
      json[r'payment'] = this.payment;
    return json;
  }

  /// Returns a new [DestinationFee] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DestinationFee? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "DestinationFee[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "DestinationFee[id]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "DestinationFee[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "DestinationFee[name]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "DestinationFee[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "DestinationFee[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'payment'), 'Required key "DestinationFee[payment]" is missing from JSON.');
        assert(json[r'payment'] != null, 'Required key "DestinationFee[payment]" has a null value in JSON.');
        return true;
      }());

      return DestinationFee(
        id: mapValueOfType<String>(json, r'id')!,
        name: mapValueOfType<String>(json, r'name')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        payment: mapValueOfType<String>(json, r'payment')!,
      );
    }
    return null;
  }

  static List<DestinationFee> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DestinationFee>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DestinationFee.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DestinationFee> mapFromJson(dynamic json) {
    final map = <String, DestinationFee>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DestinationFee.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DestinationFee-objects as value to a dart map
  static Map<String, List<DestinationFee>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DestinationFee>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DestinationFee.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'name',
    'amountUsd',
    'payment',
  };
}

