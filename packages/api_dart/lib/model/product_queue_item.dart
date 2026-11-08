//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProductQueueItem {
  /// Returns a new [ProductQueueItem] instance.
  ProductQueueItem({
    required this.id,
    required this.type,
    required this.status,
    required this.title,
    required this.providerId,
    required this.providerName,
    required this.statusAt,
  });

  String id;

  ProductType type;

  ProductStatus status;

  String title;

  String providerId;

  String providerName;

  DateTime statusAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProductQueueItem &&
    other.id == id &&
    other.type == type &&
    other.status == status &&
    other.title == title &&
    other.providerId == providerId &&
    other.providerName == providerName &&
    other.statusAt == statusAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (status.hashCode) +
    (title.hashCode) +
    (providerId.hashCode) +
    (providerName.hashCode) +
    (statusAt.hashCode);

  @override
  String toString() => 'ProductQueueItem[id=$id, type=$type, status=$status, title=$title, providerId=$providerId, providerName=$providerName, statusAt=$statusAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'status'] = this.status;
      json[r'title'] = this.title;
      json[r'providerId'] = this.providerId;
      json[r'providerName'] = this.providerName;
      json[r'statusAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.statusAt.millisecondsSinceEpoch
        : this.statusAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [ProductQueueItem] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProductQueueItem? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "ProductQueueItem[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "ProductQueueItem[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "ProductQueueItem[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "ProductQueueItem[type]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "ProductQueueItem[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "ProductQueueItem[status]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "ProductQueueItem[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "ProductQueueItem[title]" has a null value in JSON.');
        assert(json.containsKey(r'providerId'), 'Required key "ProductQueueItem[providerId]" is missing from JSON.');
        assert(json[r'providerId'] != null, 'Required key "ProductQueueItem[providerId]" has a null value in JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "ProductQueueItem[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "ProductQueueItem[providerName]" has a null value in JSON.');
        assert(json.containsKey(r'statusAt'), 'Required key "ProductQueueItem[statusAt]" is missing from JSON.');
        assert(json[r'statusAt'] != null, 'Required key "ProductQueueItem[statusAt]" has a null value in JSON.');
        return true;
      }());

      return ProductQueueItem(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductType.fromJson(json[r'type'])!,
        status: ProductStatus.fromJson(json[r'status'])!,
        title: mapValueOfType<String>(json, r'title')!,
        providerId: mapValueOfType<String>(json, r'providerId')!,
        providerName: mapValueOfType<String>(json, r'providerName')!,
        statusAt: mapDateTime(json, r'statusAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<ProductQueueItem> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProductQueueItem>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProductQueueItem.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProductQueueItem> mapFromJson(dynamic json) {
    final map = <String, ProductQueueItem>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProductQueueItem.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProductQueueItem-objects as value to a dart map
  static Map<String, List<ProductQueueItem>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProductQueueItem>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProductQueueItem.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'status',
    'title',
    'providerId',
    'providerName',
    'statusAt',
  };
}

