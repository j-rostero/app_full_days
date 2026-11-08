//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CentralSettlementsItemsInner {
  /// Returns a new [CentralSettlementsItemsInner] instance.
  CentralSettlementsItemsInner({
    required this.providerId,
    required this.providerName,
    required this.paymentsUsd,
    required this.refundsUsd,
    required this.commissionUsd,
    required this.netUsd,
  });

  String providerId;

  String providerName;

  num paymentsUsd;

  num refundsUsd;

  num commissionUsd;

  num netUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CentralSettlementsItemsInner &&
    other.providerId == providerId &&
    other.providerName == providerName &&
    other.paymentsUsd == paymentsUsd &&
    other.refundsUsd == refundsUsd &&
    other.commissionUsd == commissionUsd &&
    other.netUsd == netUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (providerId.hashCode) +
    (providerName.hashCode) +
    (paymentsUsd.hashCode) +
    (refundsUsd.hashCode) +
    (commissionUsd.hashCode) +
    (netUsd.hashCode);

  @override
  String toString() => 'CentralSettlementsItemsInner[providerId=$providerId, providerName=$providerName, paymentsUsd=$paymentsUsd, refundsUsd=$refundsUsd, commissionUsd=$commissionUsd, netUsd=$netUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'providerId'] = this.providerId;
      json[r'providerName'] = this.providerName;
      json[r'paymentsUsd'] = this.paymentsUsd;
      json[r'refundsUsd'] = this.refundsUsd;
      json[r'commissionUsd'] = this.commissionUsd;
      json[r'netUsd'] = this.netUsd;
    return json;
  }

  /// Returns a new [CentralSettlementsItemsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CentralSettlementsItemsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'providerId'), 'Required key "CentralSettlementsItemsInner[providerId]" is missing from JSON.');
        assert(json[r'providerId'] != null, 'Required key "CentralSettlementsItemsInner[providerId]" has a null value in JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "CentralSettlementsItemsInner[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "CentralSettlementsItemsInner[providerName]" has a null value in JSON.');
        assert(json.containsKey(r'paymentsUsd'), 'Required key "CentralSettlementsItemsInner[paymentsUsd]" is missing from JSON.');
        assert(json[r'paymentsUsd'] != null, 'Required key "CentralSettlementsItemsInner[paymentsUsd]" has a null value in JSON.');
        assert(json.containsKey(r'refundsUsd'), 'Required key "CentralSettlementsItemsInner[refundsUsd]" is missing from JSON.');
        assert(json[r'refundsUsd'] != null, 'Required key "CentralSettlementsItemsInner[refundsUsd]" has a null value in JSON.');
        assert(json.containsKey(r'commissionUsd'), 'Required key "CentralSettlementsItemsInner[commissionUsd]" is missing from JSON.');
        assert(json[r'commissionUsd'] != null, 'Required key "CentralSettlementsItemsInner[commissionUsd]" has a null value in JSON.');
        assert(json.containsKey(r'netUsd'), 'Required key "CentralSettlementsItemsInner[netUsd]" is missing from JSON.');
        assert(json[r'netUsd'] != null, 'Required key "CentralSettlementsItemsInner[netUsd]" has a null value in JSON.');
        return true;
      }());

      return CentralSettlementsItemsInner(
        providerId: mapValueOfType<String>(json, r'providerId')!,
        providerName: mapValueOfType<String>(json, r'providerName')!,
        paymentsUsd: num.parse('${json[r'paymentsUsd']}'),
        refundsUsd: num.parse('${json[r'refundsUsd']}'),
        commissionUsd: num.parse('${json[r'commissionUsd']}'),
        netUsd: num.parse('${json[r'netUsd']}'),
      );
    }
    return null;
  }

  static List<CentralSettlementsItemsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CentralSettlementsItemsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CentralSettlementsItemsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CentralSettlementsItemsInner> mapFromJson(dynamic json) {
    final map = <String, CentralSettlementsItemsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CentralSettlementsItemsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CentralSettlementsItemsInner-objects as value to a dart map
  static Map<String, List<CentralSettlementsItemsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CentralSettlementsItemsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CentralSettlementsItemsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'providerId',
    'providerName',
    'paymentsUsd',
    'refundsUsd',
    'commissionUsd',
    'netUsd',
  };
}

