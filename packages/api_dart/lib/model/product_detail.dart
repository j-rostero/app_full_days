//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductDetail {
  /// Returns a new [ProductDetail] instance.
  ProductDetail({
    required this.id,
    required this.providerId,
    required this.type,
    required this.status,
    required this.statusReason,
    required this.version,
    required this.sheet,
    required this.completeness,
    required this.cashAtDestinationUsd,
    this.photos = const [],
    required this.updatedAt,
  });

  String id;

  String providerId;

  ProductType type;

  ProductStatus status;

  String? statusReason;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int version;

  ProductSheet sheet;

  Completeness completeness;

  num cashAtDestinationUsd;

  List<Photo> photos;

  DateTime updatedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductDetail &&
    other.id == id &&
    other.providerId == providerId &&
    other.type == type &&
    other.status == status &&
    other.statusReason == statusReason &&
    other.version == version &&
    other.sheet == sheet &&
    other.completeness == completeness &&
    other.cashAtDestinationUsd == cashAtDestinationUsd &&
    _deepEquality.equals(other.photos, photos) &&
    other.updatedAt == updatedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (providerId.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (statusReason == null ? 0 : statusReason!.hashCode) +
    (version.hashCode) +
    (sheet.hashCode) +
    (completeness.hashCode) +
    (cashAtDestinationUsd.hashCode) +
    (photos.hashCode) +
    (updatedAt.hashCode);

  @override
  String toString() => 'ProductDetail[id=$id, providerId=$providerId, type=$type, status=$status, statusReason=$statusReason, version=$version, sheet=$sheet, completeness=$completeness, cashAtDestinationUsd=$cashAtDestinationUsd, photos=$photos, updatedAt=$updatedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'providerId'] = this.providerId;
      json[r'type'] = this.type;
      json[r'status'] = this.status;
    if (this.statusReason != null) {
      json[r'statusReason'] = this.statusReason;
    } else {
      json[r'statusReason'] = null;
    }
      json[r'version'] = this.version;
      json[r'sheet'] = this.sheet;
      json[r'completeness'] = this.completeness;
      json[r'cashAtDestinationUsd'] = this.cashAtDestinationUsd;
      json[r'photos'] = this.photos;
      json[r'updatedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.updatedAt.millisecondsSinceEpoch
        : this.updatedAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ProductDetail] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductDetail? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductDetail[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductDetail[id]" has a null value in JSON.');
        assert(json.containsKey(r'providerId'), 'Required key "ProductDetail[providerId]" is missing from JSON.');
        assert(json[r'providerId'] != null, 'Required key "ProductDetail[providerId]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProductDetail[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductDetail[type]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "ProductDetail[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "ProductDetail[status]" has a null value in JSON.');
        assert(json.containsKey(r'statusReason'), 'Required key "ProductDetail[statusReason]" is missing from JSON.');
        assert(json.containsKey(r'version'), 'Required key "ProductDetail[version]" is missing from JSON.');
        assert(json[r'version'] != null, 'Required key "ProductDetail[version]" has a null value in JSON.');
        assert(json.containsKey(r'sheet'), 'Required key "ProductDetail[sheet]" is missing from JSON.');
        assert(json[r'sheet'] != null, 'Required key "ProductDetail[sheet]" has a null value in JSON.');
        assert(json.containsKey(r'completeness'), 'Required key "ProductDetail[completeness]" is missing from JSON.');
        assert(json[r'completeness'] != null, 'Required key "ProductDetail[completeness]" has a null value in JSON.');
        assert(json.containsKey(r'cashAtDestinationUsd'), 'Required key "ProductDetail[cashAtDestinationUsd]" is missing from JSON.');
        assert(json[r'cashAtDestinationUsd'] != null, 'Required key "ProductDetail[cashAtDestinationUsd]" has a null value in JSON.');
        assert(json.containsKey(r'photos'), 'Required key "ProductDetail[photos]" is missing from JSON.');
        assert(json[r'photos'] != null, 'Required key "ProductDetail[photos]" has a null value in JSON.');
        assert(json.containsKey(r'updatedAt'), 'Required key "ProductDetail[updatedAt]" is missing from JSON.');
        assert(json[r'updatedAt'] != null, 'Required key "ProductDetail[updatedAt]" has a null value in JSON.');
        return true;
      }());

      return ProductDetail(
        id: mapValueOfType<String>(json, r'id')!,
        providerId: mapValueOfType<String>(json, r'providerId')!,
        type: ProductType.fromJson(json[r'type'])!,
        status: ProductStatus.fromJson(json[r'status'])!,
        statusReason: mapValueOfType<String>(json, r'statusReason'),
        version: mapValueOfType<int>(json, r'version')!,
        sheet: ProductSheet.fromJson(json[r'sheet'])!,
        completeness: Completeness.fromJson(json[r'completeness'])!,
        cashAtDestinationUsd: num.parse('${json[r'cashAtDestinationUsd']}'),
        photos: Photo.listFromJson(json[r'photos']),
        updatedAt: mapDateTime(json, r'updatedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<ProductDetail> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductDetail>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductDetail.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductDetail> mapFromJson(dynamic json) {
    final map = <String, ProductDetail>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductDetail.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductDetail-objects as value to a dart map
  static Map<String, List<ProductDetail>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductDetail>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductDetail.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'providerId',
    'type',
    'status',
    'statusReason',
    'version',
    'sheet',
    'completeness',
    'cashAtDestinationUsd',
    'photos',
    'updatedAt',
  };
}

