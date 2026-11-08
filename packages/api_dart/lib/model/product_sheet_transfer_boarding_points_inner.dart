//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetTransferBoardingPointsInner {
  /// Returns a new [ProductSheetTransferBoardingPointsInner] instance.
  ProductSheetTransferBoardingPointsInner({
    required this.id,
    required this.boardingPointId,
    this.name = '',
    this.address = '',
    this.city = '',
    required this.departureTime,
    required this.returnTime,
    this.priceDeltaUsd = 0,
  });

  String id;

  String? boardingPointId;

  String name;

  String address;

  String city;

  String? departureTime;

  String? returnTime;

  /// Minimum value: -1000
  /// Maximum value: 1000
  num priceDeltaUsd;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetTransferBoardingPointsInner &&
    other.id == id &&
    other.boardingPointId == boardingPointId &&
    other.name == name &&
    other.address == address &&
    other.city == city &&
    other.departureTime == departureTime &&
    other.returnTime == returnTime &&
    other.priceDeltaUsd == priceDeltaUsd;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (boardingPointId == null ? 0 : boardingPointId!.hashCode) +
    (name.hashCode) +
    (address.hashCode) +
    (city.hashCode) +
    (departureTime == null ? 0 : departureTime!.hashCode) +
    (returnTime == null ? 0 : returnTime!.hashCode) +
    (priceDeltaUsd.hashCode);

  @override
  String toString() => 'ProductSheetTransferBoardingPointsInner[id=$id, boardingPointId=$boardingPointId, name=$name, address=$address, city=$city, departureTime=$departureTime, returnTime=$returnTime, priceDeltaUsd=$priceDeltaUsd]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
    if (this.boardingPointId != null) {
      json[r'boardingPointId'] = this.boardingPointId;
    } else {
      json[r'boardingPointId'] = null;
    }
      json[r'name'] = this.name;
      json[r'address'] = this.address;
      json[r'city'] = this.city;
    if (this.departureTime != null) {
      json[r'departureTime'] = this.departureTime;
    } else {
      json[r'departureTime'] = null;
    }
    if (this.returnTime != null) {
      json[r'returnTime'] = this.returnTime;
    } else {
      json[r'returnTime'] = null;
    }
      json[r'priceDeltaUsd'] = this.priceDeltaUsd;
    return json;
  }

  /// Returns a new [ProductSheetTransferBoardingPointsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetTransferBoardingPointsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSheetTransferBoardingPointsInner[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSheetTransferBoardingPointsInner[id]" has a null value in JSON.');
        assert(json.containsKey(r'boardingPointId'), 'Required key "ProductSheetTransferBoardingPointsInner[boardingPointId]" is missing from JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProductSheetTransferBoardingPointsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductSheetTransferBoardingPointsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'address'), 'Required key "ProductSheetTransferBoardingPointsInner[address]" is missing from JSON.');
        assert(json[r'address'] != null, 'Required key "ProductSheetTransferBoardingPointsInner[address]" has a null value in JSON.');
        assert(json.containsKey(r'city'), 'Required key "ProductSheetTransferBoardingPointsInner[city]" is missing from JSON.');
        assert(json[r'city'] != null, 'Required key "ProductSheetTransferBoardingPointsInner[city]" has a null value in JSON.');
        assert(json.containsKey(r'departureTime'), 'Required key "ProductSheetTransferBoardingPointsInner[departureTime]" is missing from JSON.');
        assert(json.containsKey(r'returnTime'), 'Required key "ProductSheetTransferBoardingPointsInner[returnTime]" is missing from JSON.');
        assert(json.containsKey(r'priceDeltaUsd'), 'Required key "ProductSheetTransferBoardingPointsInner[priceDeltaUsd]" is missing from JSON.');
        assert(json[r'priceDeltaUsd'] != null, 'Required key "ProductSheetTransferBoardingPointsInner[priceDeltaUsd]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetTransferBoardingPointsInner(
        id: mapValueOfType<String>(json, r'id')!,
        boardingPointId: mapValueOfType<String>(json, r'boardingPointId'),
        name: mapValueOfType<String>(json, r'name')!,
        address: mapValueOfType<String>(json, r'address')!,
        city: mapValueOfType<String>(json, r'city')!,
        departureTime: mapValueOfType<String>(json, r'departureTime'),
        returnTime: mapValueOfType<String>(json, r'returnTime'),
        priceDeltaUsd: num.parse('${json[r'priceDeltaUsd']}'),
      );
    }
    return null;
  }

  static List<ProductSheetTransferBoardingPointsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetTransferBoardingPointsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetTransferBoardingPointsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetTransferBoardingPointsInner> mapFromJson(dynamic json) {
    final map = <String, ProductSheetTransferBoardingPointsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetTransferBoardingPointsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetTransferBoardingPointsInner-objects as value to a dart map
  static Map<String, List<ProductSheetTransferBoardingPointsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetTransferBoardingPointsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetTransferBoardingPointsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'boardingPointId',
    'name',
    'address',
    'city',
    'departureTime',
    'returnTime',
    'priceDeltaUsd',
  };
}

