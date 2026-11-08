//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheet {
  /// Returns a new [ProductSheet] instance.
  ProductSheet({
    required this.general,
    required this.duration,
    this.itinerary = const [],
    required this.transfer,
    this.meals = const [],
    this.items = const [],
    this.noAccessFees = false,
    required this.lodging,
    this.whatToBring = const [],
    required this.pricing,
  });

  ProductSheetGeneral general;

  ProductSheetDuration duration;

  List<ProductSheetItineraryInner> itinerary;

  ProductSheetTransfer transfer;

  List<ProductSheetMealsInner> meals;

  List<ProductSheetItemsInner> items;

  bool noAccessFees;

  ProductSheetLodging? lodging;

  List<String> whatToBring;

  ProductSheetPricing pricing;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheet &&
    other.general == general &&
    other.duration == duration &&
    _deepEquality.equals(other.itinerary, itinerary) &&
    other.transfer == transfer &&
    _deepEquality.equals(other.meals, meals) &&
    _deepEquality.equals(other.items, items) &&
    other.noAccessFees == noAccessFees &&
    other.lodging == lodging &&
    _deepEquality.equals(other.whatToBring, whatToBring) &&
    other.pricing == pricing;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (general.hashCode) +
    (duration.hashCode) +
    (itinerary.hashCode) +
    (transfer.hashCode) +
    (meals.hashCode) +
    (items.hashCode) +
    (noAccessFees.hashCode) +
    (lodging == null ? 0 : lodging!.hashCode) +
    (whatToBring.hashCode) +
    (pricing.hashCode);

  @override
  String toString() => 'ProductSheet[general=$general, duration=$duration, itinerary=$itinerary, transfer=$transfer, meals=$meals, items=$items, noAccessFees=$noAccessFees, lodging=$lodging, whatToBring=$whatToBring, pricing=$pricing]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'general'] = this.general;
      json[r'duration'] = this.duration;
      json[r'itinerary'] = this.itinerary;
      json[r'transfer'] = this.transfer;
      json[r'meals'] = this.meals;
      json[r'items'] = this.items;
      json[r'noAccessFees'] = this.noAccessFees;
    if (this.lodging != null) {
      json[r'lodging'] = this.lodging;
    } else {
      json[r'lodging'] = null;
    }
      json[r'whatToBring'] = this.whatToBring;
      json[r'pricing'] = this.pricing;
    return json;
  }

  /// Returns a new [ProductSheet] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheet? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'general'), 'Required key "ProductSheet[general]" is missing from JSON.');
        assert(json[r'general'] != null, 'Required key "ProductSheet[general]" has a null value in JSON.');
        assert(json.containsKey(r'duration'), 'Required key "ProductSheet[duration]" is missing from JSON.');
        assert(json[r'duration'] != null, 'Required key "ProductSheet[duration]" has a null value in JSON.');
        assert(json.containsKey(r'itinerary'), 'Required key "ProductSheet[itinerary]" is missing from JSON.');
        assert(json[r'itinerary'] != null, 'Required key "ProductSheet[itinerary]" has a null value in JSON.');
        assert(json.containsKey(r'transfer'), 'Required key "ProductSheet[transfer]" is missing from JSON.');
        assert(json[r'transfer'] != null, 'Required key "ProductSheet[transfer]" has a null value in JSON.');
        assert(json.containsKey(r'meals'), 'Required key "ProductSheet[meals]" is missing from JSON.');
        assert(json[r'meals'] != null, 'Required key "ProductSheet[meals]" has a null value in JSON.');
        assert(json.containsKey(r'items'), 'Required key "ProductSheet[items]" is missing from JSON.');
        assert(json[r'items'] != null, 'Required key "ProductSheet[items]" has a null value in JSON.');
        assert(json.containsKey(r'noAccessFees'), 'Required key "ProductSheet[noAccessFees]" is missing from JSON.');
        assert(json[r'noAccessFees'] != null, 'Required key "ProductSheet[noAccessFees]" has a null value in JSON.');
        assert(json.containsKey(r'lodging'), 'Required key "ProductSheet[lodging]" is missing from JSON.');
        assert(json.containsKey(r'whatToBring'), 'Required key "ProductSheet[whatToBring]" is missing from JSON.');
        assert(json[r'whatToBring'] != null, 'Required key "ProductSheet[whatToBring]" has a null value in JSON.');
        assert(json.containsKey(r'pricing'), 'Required key "ProductSheet[pricing]" is missing from JSON.');
        assert(json[r'pricing'] != null, 'Required key "ProductSheet[pricing]" has a null value in JSON.');
        return true;
      }());

      return ProductSheet(
        general: ProductSheetGeneral.fromJson(json[r'general'])!,
        duration: ProductSheetDuration.fromJson(json[r'duration'])!,
        itinerary: ProductSheetItineraryInner.listFromJson(json[r'itinerary']),
        transfer: ProductSheetTransfer.fromJson(json[r'transfer'])!,
        meals: ProductSheetMealsInner.listFromJson(json[r'meals']),
        items: ProductSheetItemsInner.listFromJson(json[r'items']),
        noAccessFees: mapValueOfType<bool>(json, r'noAccessFees')!,
        lodging: ProductSheetLodging.fromJson(json[r'lodging']),
        whatToBring: json[r'whatToBring'] is Iterable
            ? (json[r'whatToBring'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        pricing: ProductSheetPricing.fromJson(json[r'pricing'])!,
      );
    }
    return null;
  }

  static List<ProductSheet> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheet>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheet.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheet> mapFromJson(dynamic json) {
    final map = <String, ProductSheet>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheet.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheet-objects as value to a dart map
  static Map<String, List<ProductSheet>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheet>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheet.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'general',
    'duration',
    'itinerary',
    'transfer',
    'meals',
    'items',
    'noAccessFees',
    'lodging',
    'whatToBring',
    'pricing',
  };
}

