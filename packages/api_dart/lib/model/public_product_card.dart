//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class PublicProductCard {
  /// Returns a new [PublicProductCard] instance.
  PublicProductCard({
    required this.id,
    required this.type,
    required this.title,
    required this.summary,
    required this.cover,
    required this.priceUsd,
    required this.nextDate,
  });

  String id;

  ProductType type;

  String title;

  String summary;

  ImageUrls? cover;

  num priceUsd;

  DateTime? nextDate;

  @override
  bool operator ==(Object other) => identical(this, other) || other is PublicProductCard &&
    other.id == id &&
    other.type == type &&
    other.title == title &&
    other.summary == summary &&
    other.cover == cover &&
    other.priceUsd == priceUsd &&
    other.nextDate == nextDate;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (type.hashCode) +
    (title.hashCode) +
    (summary.hashCode) +
    (cover == null ? 0 : cover!.hashCode) +
    (priceUsd.hashCode) +
    (nextDate == null ? 0 : nextDate!.hashCode);

  @override
  String toString() => 'PublicProductCard[id=$id, type=$type, title=$title, summary=$summary, cover=$cover, priceUsd=$priceUsd, nextDate=$nextDate]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'type'] = this.type;
      json[r'title'] = this.title;
      json[r'summary'] = this.summary;
    if (this.cover != null) {
      json[r'cover'] = this.cover;
    } else {
      json[r'cover'] = null;
    }
      json[r'priceUsd'] = this.priceUsd;
    if (this.nextDate != null) {
      json[r'nextDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.nextDate!.millisecondsSinceEpoch
        : _dateFormatter.format(this.nextDate!);
    } else {
      json[r'nextDate'] = null;
    }
    return json;
  }

  /// Returns a new [PublicProductCard] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static PublicProductCard? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "PublicProductCard[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "PublicProductCard[id]" has a null value in JSON.');
        assert(json.containsKey(r'type'), 'Required key "PublicProductCard[type]" is missing from JSON.');
        assert(json[r'type'] != null, 'Required key "PublicProductCard[type]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "PublicProductCard[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "PublicProductCard[title]" has a null value in JSON.');
        assert(json.containsKey(r'summary'), 'Required key "PublicProductCard[summary]" is missing from JSON.');
        assert(json[r'summary'] != null, 'Required key "PublicProductCard[summary]" has a null value in JSON.');
        assert(json.containsKey(r'cover'), 'Required key "PublicProductCard[cover]" is missing from JSON.');
        assert(json.containsKey(r'priceUsd'), 'Required key "PublicProductCard[priceUsd]" is missing from JSON.');
        assert(json[r'priceUsd'] != null, 'Required key "PublicProductCard[priceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'nextDate'), 'Required key "PublicProductCard[nextDate]" is missing from JSON.');
        return true;
      }());

      return PublicProductCard(
        id: mapValueOfType<String>(json, r'id')!,
        type: ProductType.fromJson(json[r'type'])!,
        title: mapValueOfType<String>(json, r'title')!,
        summary: mapValueOfType<String>(json, r'summary')!,
        cover: ImageUrls.fromJson(json[r'cover']),
        priceUsd: num.parse('${json[r'priceUsd']}'),
        nextDate: mapDateTime(json, r'nextDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/'),
      );
    }
    return null;
  }

  static List<PublicProductCard> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <PublicProductCard>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = PublicProductCard.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, PublicProductCard> mapFromJson(dynamic json) {
    final map = <String, PublicProductCard>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = PublicProductCard.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of PublicProductCard-objects as value to a dart map
  static Map<String, List<PublicProductCard>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<PublicProductCard>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = PublicProductCard.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'type',
    'title',
    'summary',
    'cover',
    'priceUsd',
    'nextDate',
  };
}

