//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class CompletenessBlocksInner {
  /// Returns a new [CompletenessBlocksInner] instance.
  CompletenessBlocksInner({
    required this.block,
    required this.label,
    required this.percent,
    this.missing = const [],
  });

  CompletenessBlocksInnerBlockEnum block;

  String label;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int percent;

  List<String> missing;

  @override
  bool operator ==(Object other) => identical(this, other) || other is CompletenessBlocksInner &&
    other.block == block &&
    other.label == label &&
    other.percent == percent &&
    _deepEquality.equals(other.missing, missing);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (block.hashCode) +
    (label.hashCode) +
    (percent.hashCode) +
    (missing.hashCode);

  @override
  String toString() => 'CompletenessBlocksInner[block=$block, label=$label, percent=$percent, missing=$missing]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'block'] = this.block;
      json[r'label'] = this.label;
      json[r'percent'] = this.percent;
      json[r'missing'] = this.missing;
    return json;
  }

  /// Returns a new [CompletenessBlocksInner] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static CompletenessBlocksInner? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'block'), 'Required key "CompletenessBlocksInner[block]" is missing from JSON.');
        assert(json[r'block'] != null, 'Required key "CompletenessBlocksInner[block]" has a null value in JSON.');
        assert(json.containsKey(r'label'), 'Required key "CompletenessBlocksInner[label]" is missing from JSON.');
        assert(json[r'label'] != null, 'Required key "CompletenessBlocksInner[label]" has a null value in JSON.');
        assert(json.containsKey(r'percent'), 'Required key "CompletenessBlocksInner[percent]" is missing from JSON.');
        assert(json[r'percent'] != null, 'Required key "CompletenessBlocksInner[percent]" has a null value in JSON.');
        assert(json.containsKey(r'missing'), 'Required key "CompletenessBlocksInner[missing]" is missing from JSON.');
        assert(json[r'missing'] != null, 'Required key "CompletenessBlocksInner[missing]" has a null value in JSON.');
        return true;
      }());

      return CompletenessBlocksInner(
        block: CompletenessBlocksInnerBlockEnum.fromJson(json[r'block'])!,
        label: mapValueOfType<String>(json, r'label')!,
        percent: mapValueOfType<int>(json, r'percent')!,
        missing: json[r'missing'] is Iterable
            ? (json[r'missing'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<CompletenessBlocksInner> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CompletenessBlocksInner>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CompletenessBlocksInner.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, CompletenessBlocksInner> mapFromJson(dynamic json) {
    final map = <String, CompletenessBlocksInner>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = CompletenessBlocksInner.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of CompletenessBlocksInner-objects as value to a dart map
  static Map<String, List<CompletenessBlocksInner>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<CompletenessBlocksInner>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = CompletenessBlocksInner.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'block',
    'label',
    'percent',
    'missing',
  };
}


enum CompletenessBlocksInnerBlockEnum {
  general._(r'general'),
  itinerary._(r'itinerary'),
  transfer._(r'transfer'),
  meals._(r'meals'),
  essentials._(r'essentials'),
  lodging._(r'lodging'),
  access._(r'access'),
  whatToBring._(r'whatToBring'),
  pricing._(r'pricing'),
  ;

  /// Instantiate a new enum with the provided value.
  const CompletenessBlocksInnerBlockEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [CompletenessBlocksInnerBlockEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static CompletenessBlocksInnerBlockEnum? fromJson(dynamic value) => CompletenessBlocksInnerBlockEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [CompletenessBlocksInnerBlockEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<CompletenessBlocksInnerBlockEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <CompletenessBlocksInnerBlockEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = CompletenessBlocksInnerBlockEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [CompletenessBlocksInnerBlockEnum] to String,
/// and [decode] dynamic data back to [CompletenessBlocksInnerBlockEnum].
class CompletenessBlocksInnerBlockEnumTypeTransformer {
  factory CompletenessBlocksInnerBlockEnumTypeTransformer() => _instance ??= const CompletenessBlocksInnerBlockEnumTypeTransformer._();

  const CompletenessBlocksInnerBlockEnumTypeTransformer._();

  String encode(CompletenessBlocksInnerBlockEnum data) => data._value;

  /// Returns the instance of [CompletenessBlocksInnerBlockEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  CompletenessBlocksInnerBlockEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is CompletenessBlocksInnerBlockEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'general': return CompletenessBlocksInnerBlockEnum.general;
        case r'itinerary': return CompletenessBlocksInnerBlockEnum.itinerary;
        case r'transfer': return CompletenessBlocksInnerBlockEnum.transfer;
        case r'meals': return CompletenessBlocksInnerBlockEnum.meals;
        case r'essentials': return CompletenessBlocksInnerBlockEnum.essentials;
        case r'lodging': return CompletenessBlocksInnerBlockEnum.lodging;
        case r'access': return CompletenessBlocksInnerBlockEnum.access;
        case r'whatToBring': return CompletenessBlocksInnerBlockEnum.whatToBring;
        case r'pricing': return CompletenessBlocksInnerBlockEnum.pricing;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static CompletenessBlocksInnerBlockEnumTypeTransformer? _instance;
}


