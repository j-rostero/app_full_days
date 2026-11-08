//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class ProviderReview {
  /// Returns a new [ProviderReview] instance.
  ProviderReview({
    required this.company,
    this.documents = const [],
    this.owners = const [],
  });

  Company company;

  List<ProviderDocument> documents;

  List<AuditEntryActor> owners;

  @override
  bool operator ==(Object other) => identical(this, other) || other is ProviderReview &&
    other.company == company &&
    _deepEquality.equals(other.documents, documents) &&
    _deepEquality.equals(other.owners, owners);

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (company.hashCode) +
    (documents.hashCode) +
    (owners.hashCode);

  @override
  String toString() => 'ProviderReview[company=$company, documents=$documents, owners=$owners]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'company'] = this.company;
      json[r'documents'] = this.documents;
      json[r'owners'] = this.owners;
    return json;
  }

  /// Returns a new [ProviderReview] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static ProviderReview? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'company'), 'Required key "ProviderReview[company]" is missing from JSON.');
        assert(json[r'company'] != null, 'Required key "ProviderReview[company]" has a null value in JSON.');
        assert(json.containsKey(r'documents'), 'Required key "ProviderReview[documents]" is missing from JSON.');
        assert(json[r'documents'] != null, 'Required key "ProviderReview[documents]" has a null value in JSON.');
        assert(json.containsKey(r'owners'), 'Required key "ProviderReview[owners]" is missing from JSON.');
        assert(json[r'owners'] != null, 'Required key "ProviderReview[owners]" has a null value in JSON.');
        return true;
      }());

      return ProviderReview(
        company: Company.fromJson(json[r'company'])!,
        documents: ProviderDocument.listFromJson(json[r'documents']),
        owners: AuditEntryActor.listFromJson(json[r'owners']),
      );
    }
    return null;
  }

  static List<ProviderReview> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <ProviderReview>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = ProviderReview.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, ProviderReview> mapFromJson(dynamic json) {
    final map = <String, ProviderReview>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = ProviderReview.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of ProviderReview-objects as value to a dart map
  static Map<String, List<ProviderReview>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<ProviderReview>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = ProviderReview.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'company',
    'documents',
    'owners',
  };
}

