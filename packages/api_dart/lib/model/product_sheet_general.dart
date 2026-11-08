//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSheetGeneral {
  /// Returns a new [ProductSheetGeneral] instance.
  ProductSheetGeneral({
    this.title = '',
    this.summary = '',
    this.description = '',
    required this.category,
    required this.destinationId,
    this.photoIds = const [],
    this.tags = const [],
    this.minAge = 0,
    this.childrenAllowed = true,
    this.petsAllowed = false,
  });

  String title;

  String summary;

  String description;

  ProductSheetGeneralCategoryEnum? category;

  String? destinationId;

  List<String> photoIds;

  List<ProductSheetGeneralTagsEnum> tags;

  /// Minimum value: 0
  /// Maximum value: 99
  int minAge;

  bool childrenAllowed;

  bool petsAllowed;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSheetGeneral &&
    other.title == title &&
    other.summary == summary &&
    other.description == description &&
    other.category == category &&
    other.destinationId == destinationId &&
    _deepEquality.equals(other.photoIds, photoIds) &&
    _deepEquality.equals(other.tags, tags) &&
    other.minAge == minAge &&
    other.childrenAllowed == childrenAllowed &&
    other.petsAllowed == petsAllowed;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (title.hashCode) +
    (summary.hashCode) +
    (description.hashCode) +
    (category == null ? 0 : category!.hashCode) +
    (destinationId == null ? 0 : destinationId!.hashCode) +
    (photoIds.hashCode) +
    (tags.hashCode) +
    (minAge.hashCode) +
    (childrenAllowed.hashCode) +
    (petsAllowed.hashCode);

  @override
  String toString() => 'ProductSheetGeneral[title=$title, summary=$summary, description=$description, category=$category, destinationId=$destinationId, photoIds=$photoIds, tags=$tags, minAge=$minAge, childrenAllowed=$childrenAllowed, petsAllowed=$petsAllowed]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'title'] = this.title;
      json[r'summary'] = this.summary;
      json[r'description'] = this.description;
    if (this.category != null) {
      json[r'category'] = this.category;
    } else {
      json[r'category'] = null;
    }
    if (this.destinationId != null) {
      json[r'destinationId'] = this.destinationId;
    } else {
      json[r'destinationId'] = null;
    }
      json[r'photoIds'] = this.photoIds;
      json[r'tags'] = this.tags;
      json[r'minAge'] = this.minAge;
      json[r'childrenAllowed'] = this.childrenAllowed;
      json[r'petsAllowed'] = this.petsAllowed;
    return json;
  }

  /// Returns a new [ProductSheetGeneral] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSheetGeneral? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'title'), 'Required key "ProductSheetGeneral[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "ProductSheetGeneral[title]" has a null value in JSON.');
        assert(json.containsKey(r'summary'), 'Required key "ProductSheetGeneral[summary]" is missing from JSON.');
        assert(json[r'summary'] != null, 'Required key "ProductSheetGeneral[summary]" has a null value in JSON.');
        assert(json.containsKey(r'description'), 'Required key "ProductSheetGeneral[description]" is missing from JSON.');
        assert(json[r'description'] != null, 'Required key "ProductSheetGeneral[description]" has a null value in JSON.');
        assert(json.containsKey(r'category'), 'Required key "ProductSheetGeneral[category]" is missing from JSON.');
        assert(json.containsKey(r'destinationId'), 'Required key "ProductSheetGeneral[destinationId]" is missing from JSON.');
        assert(json.containsKey(r'photoIds'), 'Required key "ProductSheetGeneral[photoIds]" is missing from JSON.');
        assert(json[r'photoIds'] != null, 'Required key "ProductSheetGeneral[photoIds]" has a null value in JSON.');
        assert(json.containsKey(r'tags'), 'Required key "ProductSheetGeneral[tags]" is missing from JSON.');
        assert(json[r'tags'] != null, 'Required key "ProductSheetGeneral[tags]" has a null value in JSON.');
        assert(json.containsKey(r'minAge'), 'Required key "ProductSheetGeneral[minAge]" is missing from JSON.');
        assert(json[r'minAge'] != null, 'Required key "ProductSheetGeneral[minAge]" has a null value in JSON.');
        assert(json.containsKey(r'childrenAllowed'), 'Required key "ProductSheetGeneral[childrenAllowed]" is missing from JSON.');
        assert(json[r'childrenAllowed'] != null, 'Required key "ProductSheetGeneral[childrenAllowed]" has a null value in JSON.');
        assert(json.containsKey(r'petsAllowed'), 'Required key "ProductSheetGeneral[petsAllowed]" is missing from JSON.');
        assert(json[r'petsAllowed'] != null, 'Required key "ProductSheetGeneral[petsAllowed]" has a null value in JSON.');
        return true;
      }());

      return ProductSheetGeneral(
        title: mapValueOfType<String>(json, r'title')!,
        summary: mapValueOfType<String>(json, r'summary')!,
        description: mapValueOfType<String>(json, r'description')!,
        category: ProductSheetGeneralCategoryEnum.fromJson(json[r'category']),
        destinationId: mapValueOfType<String>(json, r'destinationId'),
        photoIds: json[r'photoIds'] is Iterable
            ? (json[r'photoIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
        tags: ProductSheetGeneralTagsEnum.listFromJson(json[r'tags']),
        minAge: mapValueOfType<int>(json, r'minAge')!,
        childrenAllowed: mapValueOfType<bool>(json, r'childrenAllowed')!,
        petsAllowed: mapValueOfType<bool>(json, r'petsAllowed')!,
      );
    }
    return null;
  }

  static List<ProductSheetGeneral> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetGeneral>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetGeneral.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSheetGeneral> mapFromJson(dynamic json) {
    final map = <String, ProductSheetGeneral>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSheetGeneral.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSheetGeneral-objects as value to a dart map
  static Map<String, List<ProductSheetGeneral>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSheetGeneral>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSheetGeneral.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'title',
    'summary',
    'description',
    'category',
    'destinationId',
    'photoIds',
    'tags',
    'minAge',
    'childrenAllowed',
    'petsAllowed',
  };
}


enum ProductSheetGeneralCategoryEnum {
  beach._(r'beach'),
  island._(r'island'),
  mountain._(r'mountain'),
  nature._(r'nature'),
  river._(r'river'),
  adventure._(r'adventure'),
  culture._(r'culture'),
  gastronomy._(r'gastronomy'),
  city._(r'city'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetGeneralCategoryEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetGeneralCategoryEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetGeneralCategoryEnum? fromJson(dynamic value) => ProductSheetGeneralCategoryEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetGeneralCategoryEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetGeneralCategoryEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetGeneralCategoryEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetGeneralCategoryEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetGeneralCategoryEnum] to String,
/// and [decode] dynamic data back to [ProductSheetGeneralCategoryEnum].
class ProductSheetGeneralCategoryEnumTypeTransformer {
  factory ProductSheetGeneralCategoryEnumTypeTransformer() => _instance ??= const ProductSheetGeneralCategoryEnumTypeTransformer._();

  const ProductSheetGeneralCategoryEnumTypeTransformer._();

  String encode(ProductSheetGeneralCategoryEnum data) => data._value;

  /// Returns the instance of [ProductSheetGeneralCategoryEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetGeneralCategoryEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetGeneralCategoryEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'beach': return ProductSheetGeneralCategoryEnum.beach;
        case r'island': return ProductSheetGeneralCategoryEnum.island;
        case r'mountain': return ProductSheetGeneralCategoryEnum.mountain;
        case r'nature': return ProductSheetGeneralCategoryEnum.nature;
        case r'river': return ProductSheetGeneralCategoryEnum.river;
        case r'adventure': return ProductSheetGeneralCategoryEnum.adventure;
        case r'culture': return ProductSheetGeneralCategoryEnum.culture;
        case r'gastronomy': return ProductSheetGeneralCategoryEnum.gastronomy;
        case r'city': return ProductSheetGeneralCategoryEnum.city;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetGeneralCategoryEnumTypeTransformer? _instance;
}



enum ProductSheetGeneralTagsEnum {
  family._(r'family'),
  couples._(r'couples'),
  friends._(r'friends'),
  kids._(r'kids'),
  pets._(r'pets'),
  accessible._(r'accessible'),
  hiking._(r'hiking'),
  snorkel._(r'snorkel'),
  camping._(r'camping'),
  photography._(r'photography'),
  ;

  /// Instantiate a new enum with the provided value.
  const ProductSheetGeneralTagsEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ProductSheetGeneralTagsEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ProductSheetGeneralTagsEnum? fromJson(dynamic value) => ProductSheetGeneralTagsEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ProductSheetGeneralTagsEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ProductSheetGeneralTagsEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSheetGeneralTagsEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSheetGeneralTagsEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ProductSheetGeneralTagsEnum] to String,
/// and [decode] dynamic data back to [ProductSheetGeneralTagsEnum].
class ProductSheetGeneralTagsEnumTypeTransformer {
  factory ProductSheetGeneralTagsEnumTypeTransformer() => _instance ??= const ProductSheetGeneralTagsEnumTypeTransformer._();

  const ProductSheetGeneralTagsEnumTypeTransformer._();

  String encode(ProductSheetGeneralTagsEnum data) => data._value;

  /// Returns the instance of [ProductSheetGeneralTagsEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ProductSheetGeneralTagsEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ProductSheetGeneralTagsEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'family': return ProductSheetGeneralTagsEnum.family;
        case r'couples': return ProductSheetGeneralTagsEnum.couples;
        case r'friends': return ProductSheetGeneralTagsEnum.friends;
        case r'kids': return ProductSheetGeneralTagsEnum.kids;
        case r'pets': return ProductSheetGeneralTagsEnum.pets;
        case r'accessible': return ProductSheetGeneralTagsEnum.accessible;
        case r'hiking': return ProductSheetGeneralTagsEnum.hiking;
        case r'snorkel': return ProductSheetGeneralTagsEnum.snorkel;
        case r'camping': return ProductSheetGeneralTagsEnum.camping;
        case r'photography': return ProductSheetGeneralTagsEnum.photography;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ProductSheetGeneralTagsEnumTypeTransformer? _instance;
}


