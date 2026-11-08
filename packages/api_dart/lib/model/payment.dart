//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Payment {
  /// Returns a new [Payment] instance.
  Payment({
    required this.id,
    required this.bookingId,
    required this.bookingCode,
    required this.departureDate,
    required this.title,
    required this.method,
    required this.reference,
    required this.amountUsd,
    required this.bsPerUsd,
    required this.amountBs,
    required this.status,
    required this.reason,
    required this.proofUrl,
    required this.createdAt,
    required this.reviewedAt,
  });

  String id;

  String bookingId;

  String bookingCode;

  DateTime departureDate;

  String title;

  PaymentMethod method;

  String reference;

  num amountUsd;

  num? bsPerUsd;

  num? amountBs;

  PaymentStatus status;

  String? reason;

  String? proofUrl;

  DateTime createdAt;

  DateTime? reviewedAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Payment &&
    other.id == id &&
    other.bookingId == bookingId &&
    other.bookingCode == bookingCode &&
    other.departureDate == departureDate &&
    other.title == title &&
    other.method == method &&
    other.reference == reference &&
    other.amountUsd == amountUsd &&
    other.bsPerUsd == bsPerUsd &&
    other.amountBs == amountBs &&
    other.status == status &&
    other.reason == reason &&
    other.proofUrl == proofUrl &&
    other.createdAt == createdAt &&
    other.reviewedAt == reviewedAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (bookingId.hashCode) +
    (bookingCode.hashCode) +
    (departureDate.hashCode) +
    (title.hashCode) +
    (method.hashCode) +
    (reference.hashCode) +
    (amountUsd.hashCode) +
    (bsPerUsd == null ? 0 : bsPerUsd!.hashCode) +
    (amountBs == null ? 0 : amountBs!.hashCode) +
    (status.hashCode) +
    (reason == null ? 0 : reason!.hashCode) +
    (proofUrl == null ? 0 : proofUrl!.hashCode) +
    (createdAt.hashCode) +
    (reviewedAt == null ? 0 : reviewedAt!.hashCode);

  @override
  String toString() => 'Payment[id=$id, bookingId=$bookingId, bookingCode=$bookingCode, departureDate=$departureDate, title=$title, method=$method, reference=$reference, amountUsd=$amountUsd, bsPerUsd=$bsPerUsd, amountBs=$amountBs, status=$status, reason=$reason, proofUrl=$proofUrl, createdAt=$createdAt, reviewedAt=$reviewedAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'bookingId'] = this.bookingId;
      json[r'bookingCode'] = this.bookingCode;
      json[r'departureDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.departureDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.departureDate);
      json[r'title'] = this.title;
      json[r'method'] = this.method;
      json[r'reference'] = this.reference;
      json[r'amountUsd'] = this.amountUsd;
    if (this.bsPerUsd != null) {
      json[r'bsPerUsd'] = this.bsPerUsd;
    } else {
      json[r'bsPerUsd'] = null;
    }
    if (this.amountBs != null) {
      json[r'amountBs'] = this.amountBs;
    } else {
      json[r'amountBs'] = null;
    }
      json[r'status'] = this.status;
    if (this.reason != null) {
      json[r'reason'] = this.reason;
    } else {
      json[r'reason'] = null;
    }
    if (this.proofUrl != null) {
      json[r'proofUrl'] = this.proofUrl;
    } else {
      json[r'proofUrl'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    if (this.reviewedAt != null) {
      json[r'reviewedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.reviewedAt!.millisecondsSinceEpoch
        : this.reviewedAt!.toUtc().toIso8601String();
    } else {
      json[r'reviewedAt'] = null;
    }
    return json;
  }

  /// Returns a new [Payment] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Payment? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Payment[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Payment[id]" has a null value in JSON.');
        assert(json.containsKey(r'bookingId'), 'Required key "Payment[bookingId]" is missing from JSON.');
        assert(json[r'bookingId'] != null, 'Required key "Payment[bookingId]" has a null value in JSON.');
        assert(json.containsKey(r'bookingCode'), 'Required key "Payment[bookingCode]" is missing from JSON.');
        assert(json[r'bookingCode'] != null, 'Required key "Payment[bookingCode]" has a null value in JSON.');
        assert(json.containsKey(r'departureDate'), 'Required key "Payment[departureDate]" is missing from JSON.');
        assert(json[r'departureDate'] != null, 'Required key "Payment[departureDate]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Payment[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Payment[title]" has a null value in JSON.');
        assert(json.containsKey(r'method'), 'Required key "Payment[method]" is missing from JSON.');
        assert(json[r'method'] != null, 'Required key "Payment[method]" has a null value in JSON.');
        assert(json.containsKey(r'reference'), 'Required key "Payment[reference]" is missing from JSON.');
        assert(json[r'reference'] != null, 'Required key "Payment[reference]" has a null value in JSON.');
        assert(json.containsKey(r'amountUsd'), 'Required key "Payment[amountUsd]" is missing from JSON.');
        assert(json[r'amountUsd'] != null, 'Required key "Payment[amountUsd]" has a null value in JSON.');
        assert(json.containsKey(r'bsPerUsd'), 'Required key "Payment[bsPerUsd]" is missing from JSON.');
        assert(json.containsKey(r'amountBs'), 'Required key "Payment[amountBs]" is missing from JSON.');
        assert(json.containsKey(r'status'), 'Required key "Payment[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Payment[status]" has a null value in JSON.');
        assert(json.containsKey(r'reason'), 'Required key "Payment[reason]" is missing from JSON.');
        assert(json.containsKey(r'proofUrl'), 'Required key "Payment[proofUrl]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Payment[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Payment[createdAt]" has a null value in JSON.');
        assert(json.containsKey(r'reviewedAt'), 'Required key "Payment[reviewedAt]" is missing from JSON.');
        return true;
      }());

      return Payment(
        id: mapValueOfType<String>(json, r'id')!,
        bookingId: mapValueOfType<String>(json, r'bookingId')!,
        bookingCode: mapValueOfType<String>(json, r'bookingCode')!,
        departureDate: mapDateTime(json, r'departureDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        title: mapValueOfType<String>(json, r'title')!,
        method: PaymentMethod.fromJson(json[r'method'])!,
        reference: mapValueOfType<String>(json, r'reference')!,
        amountUsd: num.parse('${json[r'amountUsd']}'),
        bsPerUsd: json[r'bsPerUsd'] == null
            ? null
            : num.parse('${json[r'bsPerUsd']}'),
        amountBs: json[r'amountBs'] == null
            ? null
            : num.parse('${json[r'amountBs']}'),
        status: PaymentStatus.fromJson(json[r'status'])!,
        reason: mapValueOfType<String>(json, r'reason'),
        proofUrl: mapValueOfType<String>(json, r'proofUrl'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        reviewedAt: mapDateTime(json, r'reviewedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
      );
    }
    return null;
  }

  static List<Payment> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Payment>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Payment.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Payment> mapFromJson(dynamic json) {
    final map = <String, Payment>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Payment.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Payment-objects as value to a dart map
  static Map<String, List<Payment>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Payment>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Payment.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'bookingId',
    'bookingCode',
    'departureDate',
    'title',
    'method',
    'reference',
    'amountUsd',
    'bsPerUsd',
    'amountBs',
    'status',
    'reason',
    'proofUrl',
    'createdAt',
    'reviewedAt',
  };
}

