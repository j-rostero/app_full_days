//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetPricing {
  /// Returns a new [ProductSheetPricing] instance.
  ProductSheetPricing({
    required this.fares,
    required this.deposit,
    required this.balanceDueDaysBefore,
    required this.cancellation,
  });

  ProductSheetPricingFares fares;

  ProductSheetPricingDeposit? deposit;

  /// Minimum value: 0
  /// Maximum value: 60
  int? balanceDueDaysBefore;

  ProductSheetPricingCancellation cancellation;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetPricing &&
    other.fares == fares &&
    other.deposit == deposit &&
    other.balanceDueDaysBefore == balanceDueDaysBefore &&
    other.cancellation == cancellation;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (fares.hashCode) +
    (deposit == null ? 0 : deposit!.hashCode) +
    (balanceDueDaysBefore == null ? 0 : balanceDueDaysBefore!.hashCode) +
    (cancellation.hashCode);

  @override
  String toString() => 'ProductSheetPricing[fares=$fares, deposit=$deposit, balanceDueDaysBefore=$balanceDueDaysBefore, cancellation=$cancellation]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'fares'] = this.fares;
    if (this.deposit != null) {
      json[r'deposit'] = this.deposit;
    } else {
      json[r'deposit'] = null;
    }
    if (this.balanceDueDaysBefore != null) {
      json[r'balanceDueDaysBefore'] = this.balanceDueDaysBefore;
    } else {
      json[r'balanceDueDaysBefore'] = null;
    }
      json[r'cancellation'] = this.cancellation;
    return json;
  }

  /// Returns a new [ProductSheetPricing] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetPricing? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'fares'), 'Required key "ProductSheetPricing[fares]" is missing from JSON.');
        assert(json[r'fares'] != null, 'Required key "ProductSheetPricing[fares]" has a null value in JSON.');
        assert(json.containsKey(r'deposit'), 'Required key "ProductSheetPricing[deposit]" is missing from JSON.');
        assert(json.containsKey(r'balanceDueDaysBefore'), 'Required key "ProductSheetPricing[balanceDueDaysBefore]" is missing from JSON.');
        assert(json.containsKey(r'cancellation'), 'Required key "ProductSheetPricing[cancellation]" is missing from JSON.');
        assert(json[r'cancellation'] != null, 'Required key "ProductSheetPricing[cancellation]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetPricing(
        fares: ProductSheetPricingFares.fromJson(json[r'fares'])!,
        deposit: ProductSheetPricingDeposit.fromJson(json[r'deposit']),
        balanceDueDaysBefore: mapValueOfType<int>(json, r'balanceDueDaysBefore'),
        cancellation: ProductSheetPricingCancellation.fromJson(json[r'cancellation'])!,
      );
    }
    return null;
  }

  static List<ProductSheetPricing> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetPricing>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetPricing.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetPricing> mapFromJson(dynamic json) {
    final map = <String, ProductSheetPricing>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetPricing.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetPricing-objects as value to a dart map
  static Map<String, List<ProductSheetPricing>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetPricing>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetPricing.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'fares',
    'deposit',
    'balanceDueDaysBefore',
    'cancellation',
  };
}

