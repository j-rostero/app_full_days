//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ManualBookingInput {
  /// Returns a new [ManualBookingInput] instance.
  ManualBookingInput({
    required this.departureId,
    required this.selection,
    required this.contact,
    required this.payment,
  });

  String departureId;

  BookingSelection selection;

  ManualBookingInputContact contact;

  ManualBookingInputPayment? payment;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ManualBookingInput &&
    other.departureId == departureId &&
    other.selection == selection &&
    other.contact == contact &&
    other.payment == payment;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (departureId.hashCode) +
    (selection.hashCode) +
    (contact.hashCode) +
    (payment == null ? 0 : payment!.hashCode);

  @override
  String toString() => 'ManualBookingInput[departureId=$departureId, selection=$selection, contact=$contact, payment=$payment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'departureId'] = this.departureId;
      json[r'selection'] = this.selection;
      json[r'contact'] = this.contact;
    if (this.payment != null) {
      json[r'payment'] = this.payment;
    } else {
      json[r'payment'] = null;
    }
    return json;
  }

  /// Returns a new [ManualBookingInput] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ManualBookingInput? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'departureId'), 'Required key "ManualBookingInput[departureId]" is missing from JSON.');
        assert(json[r'departureId'] != null, 'Required key "ManualBookingInput[departureId]" has a null value in JSON.');
        assert(json.containsKey(r'selection'), 'Required key "ManualBookingInput[selection]" is missing from JSON.');
        assert(json[r'selection'] != null, 'Required key "ManualBookingInput[selection]" has a null value in JSON.');
        assert(json.containsKey(r'contact'), 'Required key "ManualBookingInput[contact]" is missing from JSON.');
        assert(json[r'contact'] != null, 'Required key "ManualBookingInput[contact]" has a null value in JSON.');
        assert(json.containsKey(r'payment'), 'Required key "ManualBookingInput[payment]" is missing from JSON.');
        return true;
      }());

      return ManualBookingInput(
        departureId: mapValueOfType<String>(json, r'departureId')!,
        selection: BookingSelection.fromJson(json[r'selection'])!,
        contact: ManualBookingInputContact.fromJson(json[r'contact'])!,
        payment: ManualBookingInputPayment.fromJson(json[r'payment']),
      );
    }
    return null;
  }

  static List<ManualBookingInput> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ManualBookingInput>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ManualBookingInput.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ManualBookingInput> mapFromJson(dynamic json) {
    final map = <String, ManualBookingInput>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ManualBookingInput.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ManualBookingInput-objects as value to a dart map
  static Map<String, List<ManualBookingInput>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ManualBookingInput>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ManualBookingInput.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'departureId',
    'selection',
    'contact',
    'payment',
  };
}

