//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class DepartureUpdateInput {
  /// Returns a new [DepartureUpdateInput] instance.
  DepartureUpdateInput({
    this.capacity,
    this.minCapacity,
    this.adultPriceUsd,
    this.status,
    this.guideIds = const [],
  });

  /// Minimum value: 1
  /// Maximum value: 1000
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? capacity;

  /// Minimum value: 1
  /// Maximum value: 1000
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  int? minCapacity;

  /// Minimum value: 0.01
  /// Maximum value: 100000
  num? adultPriceUsd;

  DepartureUpdateInputStatusEnum? status;

  List<String> guideIds;

  @override
  bool operator ==(Object other) => identical(this, other) || other is DepartureUpdateInput &&
    other.capacity == capacity &&
    other.minCapacity == minCapacity &&
    other.adultPriceUsd == adultPriceUsd &&
    other.status == status &&
    _deepEquality.equals(other.guideIds, guideIds);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (capacity == null ? 0 : capacity!.hashCode) +
    (minCapacity == null ? 0 : minCapacity!.hashCode) +
    (adultPriceUsd == null ? 0 : adultPriceUsd!.hashCode) +
    (status == null ? 0 : status!.hashCode) +
    (guideIds.hashCode);

  @override
  String toString() => 'DepartureUpdateInput[capacity=$capacity, minCapacity=$minCapacity, adultPriceUsd=$adultPriceUsd, status=$status, guideIds=$guideIds]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.capacity != null) {
      json[r'capacity'] = this.capacity;
    } else {
      json[r'capacity'] = null;
    }
    if (this.minCapacity != null) {
      json[r'minCapacity'] = this.minCapacity;
    } else {
      json[r'minCapacity'] = null;
    }
    if (this.adultPriceUsd != null) {
      json[r'adultPriceUsd'] = this.adultPriceUsd;
    } else {
      json[r'adultPriceUsd'] = null;
    }
    if (this.status != null) {
      json[r'status'] = this.status;
    } else {
      json[r'status'] = null;
    }
      json[r'guideIds'] = this.guideIds;
    return json;
  }

  /// Returns a new [DepartureUpdateInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static DepartureUpdateInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        return true;
      }());

      return DepartureUpdateInput(
        capacity: mapValueOfType<int>(json, r'capacity'),
        minCapacity: mapValueOfType<int>(json, r'minCapacity'),
        adultPriceUsd: json[r'adultPriceUsd'] == null
            ? null
            : num.parse('${json[r'adultPriceUsd']}'),
        status: DepartureUpdateInputStatusEnum.fromJson(json[r'status']),
        guideIds: json[r'guideIds'] is Iterable
            ? (json[r'guideIds'] as Iterable).cast<String>().toList(growable: false)
            : const [],
      );
    }
    return null;
  }

  static List<DepartureUpdateInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureUpdateInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureUpdateInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, DepartureUpdateInput> mapFromJson(dynamic json) {
    final map = <String, DepartureUpdateInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = DepartureUpdateInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of DepartureUpdateInput-objects as value to a dart map
  static Map<String, List<DepartureUpdateInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<DepartureUpdateInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = DepartureUpdateInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
  };
}


enum DepartureUpdateInputStatusEnum {
  open._(r'open'),
  paused._(r'paused'),
  closed._(r'closed'),
  inProgress._(r'in_progress'),
  finished._(r'finished'),
  cancelled._(r'cancelled'),
  ;

  /// Instantiate a new enum with the provided value.
  const DepartureUpdateInputStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [DepartureUpdateInputStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static DepartureUpdateInputStatusEnum? fromJson(dynamic value) => DepartureUpdateInputStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [DepartureUpdateInputStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<DepartureUpdateInputStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <DepartureUpdateInputStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = DepartureUpdateInputStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [DepartureUpdateInputStatusEnum] to String,
/// and [decode] dynamic data back to [DepartureUpdateInputStatusEnum].
class DepartureUpdateInputStatusEnumTypeTransformer {
  factory DepartureUpdateInputStatusEnumTypeTransformer() => _instance ??= const DepartureUpdateInputStatusEnumTypeTransformer._();

  const DepartureUpdateInputStatusEnumTypeTransformer._();

  String encode(DepartureUpdateInputStatusEnum data) => data._value;

  /// Returns the instance of [DepartureUpdateInputStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  DepartureUpdateInputStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is DepartureUpdateInputStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'open': return DepartureUpdateInputStatusEnum.open;
        case r'paused': return DepartureUpdateInputStatusEnum.paused;
        case r'closed': return DepartureUpdateInputStatusEnum.closed;
        case r'in_progress': return DepartureUpdateInputStatusEnum.inProgress;
        case r'finished': return DepartureUpdateInputStatusEnum.finished;
        case r'cancelled': return DepartureUpdateInputStatusEnum.cancelled;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static DepartureUpdateInputStatusEnumTypeTransformer? _instance;
}


