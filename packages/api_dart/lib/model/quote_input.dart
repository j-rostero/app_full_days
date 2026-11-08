//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class QuoteInput {
  /// Returns a new [QuoteInput] instance.
  QuoteInput({
    required this.departureId,
    required this.selection,
  });

  String departureId;

  BookingSelection selection;

  @override
  bool operator ==(Object other) => identical(this, other) || other is QuoteInput &&
    other.departureId == departureId &&
    other.selection == selection;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departureId.hashCode) +
    (selection.hashCode);

  @override
  String toString() => 'QuoteInput[departureId=$departureId, selection=$selection]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departureId'] = this.departureId;
      json[r'selection'] = this.selection;
    return json;
  }

  /// Returns a new [QuoteInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static QuoteInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departureId'), 'Required key "QuoteInput[departureId]" is missing from JSON.');
        assert(json[r'departureId'] != null, 'Required key "QuoteInput[departureId]" has a null value in JSON.');
        assert(json.containsKey(r'selection'), 'Required key "QuoteInput[selection]" is missing from JSON.');
        assert(json[r'selection'] != null, 'Required key "QuoteInput[selection]" has a null value in JSON.');
        return true;
      }());

      return QuoteInput(
        departureId: mapValueOfType<String>(json, r'departureId')!,
        selection: BookingSelection.fromJson(json[r'selection'])!,
      );
    }
    return null;
  }

  static List<QuoteInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <QuoteInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = QuoteInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, QuoteInput> mapFromJson(dynamic json) {
    final map = <String, QuoteInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = QuoteInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of QuoteInput-objects as value to a dart map
  static Map<String, List<QuoteInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<QuoteInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = QuoteInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departureId',
    'selection',
  };
}

