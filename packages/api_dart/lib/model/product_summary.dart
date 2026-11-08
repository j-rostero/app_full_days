//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductSummary {
  /// Returns a new [ProductSummary] instance.
  ProductSummary({
    required this.id,
    required this.type,
    required this.status,
    required this.statusReason,
    required this.title,
    required this.percent,
    required this.cover,
    required this.updatedAt,
  });

  String id;

  ProductType type;

  ProductStatus status;

  String? statusReason;

  String title;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int percent;

  ImageUrls? cover;

  DateTime updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductSummary &&
    other.id == id &&
    other.type == type &&
    other.status == status &&
    other.statusReason == statusReason &&
    other.title == title &&
    other.percent == percent &&
    other.cover == cover &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (statusReason == null ? 0 : statusReason!.hashCode) +
    (title.hashCode) +
    (percent.hashCode) +
    (cover == null ? 0 : cover!.hashCode) +
    (updatedAt.hashCode);

  @override
  String toString() => 'ProductSummary[id=$id, type=$type, status=$status, statusReason=$statusReason, title=$title, percent=$percent, cover=$cover, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'status'] = this.status;
    if (this.statusReason != null) {
      json[r'statusReason'] = this.statusReason;
    } else {
      json[r'statusReason'] = null;
    }
      json[r'title'] = this.title;
      json[r'percent'] = this.percent;
    if (this.cover != null) {
      json[r'cover'] = this.cover;
    } else {
      json[r'cover'] = null;
    }
      json[r'updatedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.updatedAt.millisecondsSinceEpoch
        : this.updatedAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ProductSummary] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductSummary? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductSummary[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductSummary[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProductSummary[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductSummary[type]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "ProductSummary[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "ProductSummary[status]" has a null value in JSON.');
        assert(json.containsKey(r'statusReason'), 'Required key "ProductSummary[statusReason]" is missing from JSON.');
        assert(json.containsKey(r'title'), 'Required key "ProductSummary[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "ProductSummary[title]" has a null value in JSON.');
        assert(json.containsKey(r'percent'), 'Required key "ProductSummary[percent]" is missing from JSON.');
        assert(json[r'percent'] != null, 'Required key "ProductSummary[percent]" has a null value in JSON.');
        assert(json.containsKey(r'cover'), 'Required key "ProductSummary[cover]" is missing from JSON.');
        assert(json.containsKey(r'updatedAt'), 'Required key "ProductSummary[updatedAt]" is missing from JSON.');
        assert(json[r'updatedAt'] != null, 'Required key "ProductSummary[updatedAt]" has a null value in JSON.');
        return true;
      }());

      return ProductSummary(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductType.fromJson(json[r'type'])!,
        status: ProductStatus.fromJson(json[r'status'])!,
        statusReason: mapValueOfType<String>(json, r'statusReason'),
        title: mapValueOfType<String>(json, r'title')!,
        percent: mapValueOfType<int>(json, r'percent')!,
        cover: ImageUrls.fromJson(json[r'cover']),
        updatedAt: mapDateTime(json, r'updatedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<ProductSummary> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductSummary>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductSummary.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductSummary> mapFromJson(dynamic json) {
    final map = <String, ProductSummary>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductSummary.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductSummary-objects as value to a dart map
  static Map<String, List<ProductSummary>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductSummary>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductSummary.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'status',
    'statusReason',
    'title',
    'percent',
    'cover',
    'updatedAt',
  };
}

