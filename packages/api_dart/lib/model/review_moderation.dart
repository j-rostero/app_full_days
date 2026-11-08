//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ReviewModeration {
  /// Returns a new [ReviewModeration] instance.
  ReviewModeration({
    required this.status,
    required this.reported,
    required this.reportReason,
    required this.hiddenReason,
    required this.providerName,
  });

  ReviewModerationStatusEnum status;

  bool reported;

  String? reportReason;

  String? hiddenReason;

  String providerName;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ReviewModeration &&
    other.status == status &&
    other.reported == reported &&
    other.reportReason == reportReason &&
    other.hiddenReason == hiddenReason &&
    other.providerName == providerName;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (status.hashCode) +
    (reported.hashCode) +
    (reportReason == null ? 0 : reportReason!.hashCode) +
    (hiddenReason == null ? 0 : hiddenReason!.hashCode) +
    (providerName.hashCode);

  @override
  String toString() => 'ReviewModeration[status=$status, reported=$reported, reportReason=$reportReason, hiddenReason=$hiddenReason, providerName=$providerName]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'status'] = this.status;
      json[r'reported'] = this.reported;
    if (this.reportReason != null) {
      json[r'reportReason'] = this.reportReason;
    } else {
      json[r'reportReason'] = null;
    }
    if (this.hiddenReason != null) {
      json[r'hiddenReason'] = this.hiddenReason;
    } else {
      json[r'hiddenReason'] = null;
    }
      json[r'providerName'] = this.providerName;
    return json;
  }

  /// Returns a new [ReviewModeration] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ReviewModeration? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'status'), 'Required key "ReviewModeration[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "ReviewModeration[status]" has a null value in JSON.');
        assert(json.containsKey(r'reported'), 'Required key "ReviewModeration[reported]" is missing from JSON.');
        assert(json[r'reported'] != null, 'Required key "ReviewModeration[reported]" has a null value in JSON.');
        assert(json.containsKey(r'reportReason'), 'Required key "ReviewModeration[reportReason]" is missing from JSON.');
        assert(json.containsKey(r'hiddenReason'), 'Required key "ReviewModeration[hiddenReason]" is missing from JSON.');
        assert(json.containsKey(r'providerName'), 'Required key "ReviewModeration[providerName]" is missing from JSON.');
        assert(json[r'providerName'] != null, 'Required key "ReviewModeration[providerName]" has a null value in JSON.');
        return true;
      }());

      return ReviewModeration(
        status: ReviewModerationStatusEnum.fromJson(json[r'status'])!,
        reported: mapValueOfType<bool>(json, r'reported')!,
        reportReason: mapValueOfType<String>(json, r'reportReason'),
        hiddenReason: mapValueOfType<String>(json, r'hiddenReason'),
        providerName: mapValueOfType<String>(json, r'providerName')!,
      );
    }
    return null;
  }

  static List<ReviewModeration> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewModeration>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewModeration.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ReviewModeration> mapFromJson(dynamic json) {
    final map = <String, ReviewModeration>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ReviewModeration.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ReviewModeration-objects as value to a dart map
  static Map<String, List<ReviewModeration>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ReviewModeration>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ReviewModeration.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'status',
    'reported',
    'reportReason',
    'hiddenReason',
    'providerName',
  };
}


enum ReviewModerationStatusEnum {
  visible._(r'visible'),
  hidden._(r'hidden'),
  ;

  /// Instantiate a new enum with the provided value.
  const ReviewModerationStatusEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [ReviewModerationStatusEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static ReviewModerationStatusEnum? fromJson(dynamic value) => ReviewModerationStatusEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [ReviewModerationStatusEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<ReviewModerationStatusEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ReviewModerationStatusEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ReviewModerationStatusEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [ReviewModerationStatusEnum] to String,
/// and [decode] dynamic data back to [ReviewModerationStatusEnum].
class ReviewModerationStatusEnumTypeTransformer {
  factory ReviewModerationStatusEnumTypeTransformer() => _instance ??= const ReviewModerationStatusEnumTypeTransformer._();

  const ReviewModerationStatusEnumTypeTransformer._();

  String encode(ReviewModerationStatusEnum data) => data._value;

  /// Returns the instance of [ReviewModerationStatusEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  ReviewModerationStatusEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is ReviewModerationStatusEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'visible': return ReviewModerationStatusEnum.visible;
        case r'hidden': return ReviewModerationStatusEnum.hidden;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static ReviewModerationStatusEnumTypeTransformer? _instance;
}


