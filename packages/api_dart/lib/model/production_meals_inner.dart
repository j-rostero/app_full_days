//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductionMealsInner {
  /// Returns a new [ProductionMealsInner] instance.
  ProductionMealsInner({
    required this.mealId,
    required this.name,
    required this.mode,
    required this.description,
    required this.servings,
    this.options = const [],
    required this.pending,
  });

  String mealId;

  String name;

  String mode;

  String description;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int servings;

  List<ProductionMealsInnerOptionsInner> options;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int pending;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductionMealsInner &&
    other.mealId == mealId &&
    other.name == name &&
    other.mode == mode &&
    other.description == description &&
    other.servings == servings &&
    _deepEquality.equals(other.options, options) &&
    other.pending == pending;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (mealId.hashCode) +
    (name.hashCode) +
    (mode.hashCode) +
    (description.hashCode) +
    (servings.hashCode) +
    (options.hashCode) +
    (pending.hashCode);

  @override
  String toString() => 'ProductionMealsInner[mealId=$mealId, name=$name, mode=$mode, description=$description, servings=$servings, options=$options, pending=$pending]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'mealId'] = this.mealId;
      json[r'name'] = this.name;
      json[r'mode'] = this.mode;
      json[r'description'] = this.description;
      json[r'servings'] = this.servings;
      json[r'options'] = this.options;
      json[r'pending'] = this.pending;
    return json;
  }

  /// Returns a new [ProductionMealsInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductionMealsInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'mealId'), 'Required key "ProductionMealsInner[mealId]" is missing from JSON.');
        assert(json[r'mealId'] != null, 'Required key "ProductionMealsInner[mealId]" has a null value in JSON.');
        assert(json.containsKey(r'name'), 'Required key "ProductionMealsInner[name]" is missing from JSON.');
        assert(json[r'name'] != null, 'Required key "ProductionMealsInner[name]" has a null value in JSON.');
        assert(json.containsKey(r'mode'), 'Required key "ProductionMealsInner[mode]" is missing from JSON.');
        assert(json[r'mode'] != null, 'Required key "ProductionMealsInner[mode]" has a null value in JSON.');
        assert(json.containsKey(r'description'), 'Required key "ProductionMealsInner[description]" is missing from JSON.');
        assert(json[r'description'] != null, 'Required key "ProductionMealsInner[description]" has a null value in JSON.');
        assert(json.containsKey(r'servings'), 'Required key "ProductionMealsInner[servings]" is missing from JSON.');
        assert(json[r'servings'] != null, 'Required key "ProductionMealsInner[servings]" has a null value in JSON.');
        assert(json.containsKey(r'options'), 'Required key "ProductionMealsInner[options]" is missing from JSON.');
        assert(json[r'options'] != null, 'Required key "ProductionMealsInner[options]" has a null value in JSON.');
        assert(json.containsKey(r'pending'), 'Required key "ProductionMealsInner[pending]" is missing from JSON.');
        assert(json[r'pending'] != null, 'Required key "ProductionMealsInner[pending]" has a null value in JSON.');
        return true;
      }());

      return ProductionMealsInner(
        mealId: mapValueOfType<String>(json, r'mealId')!,
        name: mapValueOfType<String>(json, r'name')!,
        mode: mapValueOfType<String>(json, r'mode')!,
        description: mapValueOfType<String>(json, r'description')!,
        servings: mapValueOfType<int>(json, r'servings')!,
        options: ProductionMealsInnerOptionsInner.listFromJson(json[r'options']),
        pending: mapValueOfType<int>(json, r'pending')!,
      );
    }
    return null;
  }

  static List<ProductionMealsInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductionMealsInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductionMealsInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductionMealsInner> mapFromJson(dynamic json) {
    final map = <String, ProductionMealsInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductionMealsInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductionMealsInner-objects as value to a dart map
  static Map<String, List<ProductionMealsInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductionMealsInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductionMealsInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'mealId',
    'name',
    'mode',
    'description',
    'servings',
    'options',
    'pending',
  };
}

