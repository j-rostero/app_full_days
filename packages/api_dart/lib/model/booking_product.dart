//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class BookingProduct {
  /// Returns a new [BookingProduct] instance.
  BookingProduct({
    required this.id,
    required this.type,
    required this.title,
    required this.cover,
  });

  String id;

  ProductType type;

  String title;

  ImageUrls? cover;

  @override
  bool operator ==(Object other) => identical(this, other) || other is BookingProduct &&
    other.id == id &&
    other.type == type &&
    other.title == title &&
    other.cover == cover;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (title.hashCode) +
    (cover == null ? 0 : cover!.hashCode);

  @override
  String toString() => 'BookingProduct[id=$id, type=$type, title=$title, cover=$cover]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'title'] = this.title;
    if (this.cover != null) {
      json[r'cover'] = this.cover;
    } else {
      json[r'cover'] = null;
    }
    return json;
  }

  /// Returns a new [BookingProduct] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static BookingProduct? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "BookingProduct[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "BookingProduct[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "BookingProduct[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "BookingProduct[type]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "BookingProduct[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "BookingProduct[title]" has a null value in JSON.');
        assert(json.containsKey(r'cover'), 'Required key "BookingProduct[cover]" is missing from JSON.');
        return true;
      }());

      return BookingProduct(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductType.fromJson(json[r'type'])!,
        title: mapValueOfType<String>(json, r'title')!,
        cover: ImageUrls.fromJson(json[r'cover']),
      );
    }
    return null;
  }

  static List<BookingProduct> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingProduct>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingProduct.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, BookingProduct> mapFromJson(dynamic json) {
    final map = <String, BookingProduct>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = BookingProduct.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of BookingProduct-objects as value to a dart map
  static Map<String, List<BookingProduct>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<BookingProduct>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = BookingProduct.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'title',
    'cover',
  };
}

