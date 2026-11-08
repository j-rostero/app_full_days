//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Booking {
  /// Returns a new [Booking] instance.
  Booking({
    required this.id,
    required this.code,
    required this.status,
    required this.source_,
    required this.departure,
    required this.product,
    required this.provider,
    required this.selection,
    this.lines = const [],
    required this.seats,
    required this.totalUsd,
    required this.depositUsd,
    required this.paidUsd,
    required this.pendingUsd,
    required this.balanceUsd,
    required this.balanceDueDate,
    required this.heldUntil,
    required this.cancelledBy,
    required this.refund,
    required this.canReview,
    required this.contact,
    this.passengers = const [],
    this.mealChoices = const [],
    required this.createdAt,
  });

  String id;

  String code;

  BookingStatus status;

  BookingSource_Enum source_;

  BookingDeparture departure;

  BookingProduct product;

  BookingProvider provider;

  BookingSelection selection;

  List<BookingLinesInner> lines;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int seats;

  num totalUsd;

  num depositUsd;

  num paidUsd;

  num pendingUsd;

  num balanceUsd;

  DateTime balanceDueDate;

  DateTime? heldUntil;

  BookingCancelledByEnum? cancelledBy;

  BookingRefund? refund;

  bool canReview;

  BookingContact? contact;

  List<BookingPassenger> passengers;

  List<MealChoice> mealChoices;

  DateTime createdAt;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Booking &&
    other.id == id &&
    other.code == code &&
    other.status == status &&
    other.source_ == source_ &&
    other.departure == departure &&
    other.product == product &&
    other.provider == provider &&
    other.selection == selection &&
    _deepEquality.equals(other.lines, lines) &&
    other.seats == seats &&
    other.totalUsd == totalUsd &&
    other.depositUsd == depositUsd &&
    other.paidUsd == paidUsd &&
    other.pendingUsd == pendingUsd &&
    other.balanceUsd == balanceUsd &&
    other.balanceDueDate == balanceDueDate &&
    other.heldUntil == heldUntil &&
    other.cancelledBy == cancelledBy &&
    other.refund == refund &&
    other.canReview == canReview &&
    other.contact == contact &&
    _deepEquality.equals(other.passengers, passengers) &&
    _deepEquality.equals(other.mealChoices, mealChoices) &&
    other.createdAt == createdAt;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (code.hashCode) +
    (status.hashCode) +
    (source_.hashCode) +
    (departure.hashCode) +
    (product.hashCode) +
    (provider.hashCode) +
    (selection.hashCode) +
    (lines.hashCode) +
    (seats.hashCode) +
    (totalUsd.hashCode) +
    (depositUsd.hashCode) +
    (paidUsd.hashCode) +
    (pendingUsd.hashCode) +
    (balanceUsd.hashCode) +
    (balanceDueDate.hashCode) +
    (heldUntil == null ? 0 : heldUntil!.hashCode) +
    (cancelledBy == null ? 0 : cancelledBy!.hashCode) +
    (refund == null ? 0 : refund!.hashCode) +
    (canReview.hashCode) +
    (contact == null ? 0 : contact!.hashCode) +
    (passengers.hashCode) +
    (mealChoices.hashCode) +
    (createdAt.hashCode);

  @override
  String toString() => 'Booking[id=$id, code=$code, status=$status, source_=$source_, departure=$departure, product=$product, provider=$provider, selection=$selection, lines=$lines, seats=$seats, totalUsd=$totalUsd, depositUsd=$depositUsd, paidUsd=$paidUsd, pendingUsd=$pendingUsd, balanceUsd=$balanceUsd, balanceDueDate=$balanceDueDate, heldUntil=$heldUntil, cancelledBy=$cancelledBy, refund=$refund, canReview=$canReview, contact=$contact, passengers=$passengers, mealChoices=$mealChoices, createdAt=$createdAt]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'code'] = this.code;
      json[r'status'] = this.status;
      json[r'source'] = this.source_;
      json[r'departure'] = this.departure;
      json[r'product'] = this.product;
      json[r'provider'] = this.provider;
      json[r'selection'] = this.selection;
      json[r'lines'] = this.lines;
      json[r'seats'] = this.seats;
      json[r'totalUsd'] = this.totalUsd;
      json[r'depositUsd'] = this.depositUsd;
      json[r'paidUsd'] = this.paidUsd;
      json[r'pendingUsd'] = this.pendingUsd;
      json[r'balanceUsd'] = this.balanceUsd;
      json[r'balanceDueDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.balanceDueDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.balanceDueDate);
    if (this.heldUntil != null) {
      json[r'heldUntil'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.heldUntil!.millisecondsSinceEpoch
        : this.heldUntil!.toUtc().toIso8601String();
    } else {
      json[r'heldUntil'] = null;
    }
    if (this.cancelledBy != null) {
      json[r'cancelledBy'] = this.cancelledBy;
    } else {
      json[r'cancelledBy'] = null;
    }
    if (this.refund != null) {
      json[r'refund'] = this.refund;
    } else {
      json[r'refund'] = null;
    }
      json[r'canReview'] = this.canReview;
    if (this.contact != null) {
      json[r'contact'] = this.contact;
    } else {
      json[r'contact'] = null;
    }
      json[r'passengers'] = this.passengers;
      json[r'mealChoices'] = this.mealChoices;
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    return json;
  }

  /// Returns a new [Booking] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Booking? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Booking[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Booking[id]" has a null value in JSON.');
        assert(json.containsKey(r'code'), 'Required key "Booking[code]" is missing from JSON.');
        assert(json[r'code'] != null, 'Required key "Booking[code]" has a null value in JSON.');
        assert(json.containsKey(r'status'), 'Required key "Booking[status]" is missing from JSON.');
        assert(json[r'status'] != null, 'Required key "Booking[status]" has a null value in JSON.');
        assert(json.containsKey(r'source'), 'Required key "Booking[source]" is missing from JSON.');
        assert(json[r'source'] != null, 'Required key "Booking[source]" has a null value in JSON.');
        assert(json.containsKey(r'departure'), 'Required key "Booking[departure]" is missing from JSON.');
        assert(json[r'departure'] != null, 'Required key "Booking[departure]" has a null value in JSON.');
        assert(json.containsKey(r'product'), 'Required key "Booking[product]" is missing from JSON.');
        assert(json[r'product'] != null, 'Required key "Booking[product]" has a null value in JSON.');
        assert(json.containsKey(r'provider'), 'Required key "Booking[provider]" is missing from JSON.');
        assert(json[r'provider'] != null, 'Required key "Booking[provider]" has a null value in JSON.');
        assert(json.containsKey(r'selection'), 'Required key "Booking[selection]" is missing from JSON.');
        assert(json[r'selection'] != null, 'Required key "Booking[selection]" has a null value in JSON.');
        assert(json.containsKey(r'lines'), 'Required key "Booking[lines]" is missing from JSON.');
        assert(json[r'lines'] != null, 'Required key "Booking[lines]" has a null value in JSON.');
        assert(json.containsKey(r'seats'), 'Required key "Booking[seats]" is missing from JSON.');
        assert(json[r'seats'] != null, 'Required key "Booking[seats]" has a null value in JSON.');
        assert(json.containsKey(r'totalUsd'), 'Required key "Booking[totalUsd]" is missing from JSON.');
        assert(json[r'totalUsd'] != null, 'Required key "Booking[totalUsd]" has a null value in JSON.');
        assert(json.containsKey(r'depositUsd'), 'Required key "Booking[depositUsd]" is missing from JSON.');
        assert(json[r'depositUsd'] != null, 'Required key "Booking[depositUsd]" has a null value in JSON.');
        assert(json.containsKey(r'paidUsd'), 'Required key "Booking[paidUsd]" is missing from JSON.');
        assert(json[r'paidUsd'] != null, 'Required key "Booking[paidUsd]" has a null value in JSON.');
        assert(json.containsKey(r'pendingUsd'), 'Required key "Booking[pendingUsd]" is missing from JSON.');
        assert(json[r'pendingUsd'] != null, 'Required key "Booking[pendingUsd]" has a null value in JSON.');
        assert(json.containsKey(r'balanceUsd'), 'Required key "Booking[balanceUsd]" is missing from JSON.');
        assert(json[r'balanceUsd'] != null, 'Required key "Booking[balanceUsd]" has a null value in JSON.');
        assert(json.containsKey(r'balanceDueDate'), 'Required key "Booking[balanceDueDate]" is missing from JSON.');
        assert(json[r'balanceDueDate'] != null, 'Required key "Booking[balanceDueDate]" has a null value in JSON.');
        assert(json.containsKey(r'heldUntil'), 'Required key "Booking[heldUntil]" is missing from JSON.');
        assert(json.containsKey(r'cancelledBy'), 'Required key "Booking[cancelledBy]" is missing from JSON.');
        assert(json.containsKey(r'refund'), 'Required key "Booking[refund]" is missing from JSON.');
        assert(json.containsKey(r'canReview'), 'Required key "Booking[canReview]" is missing from JSON.');
        assert(json[r'canReview'] != null, 'Required key "Booking[canReview]" has a null value in JSON.');
        assert(json.containsKey(r'contact'), 'Required key "Booking[contact]" is missing from JSON.');
        assert(json.containsKey(r'passengers'), 'Required key "Booking[passengers]" is missing from JSON.');
        assert(json[r'passengers'] != null, 'Required key "Booking[passengers]" has a null value in JSON.');
        assert(json.containsKey(r'mealChoices'), 'Required key "Booking[mealChoices]" is missing from JSON.');
        assert(json[r'mealChoices'] != null, 'Required key "Booking[mealChoices]" has a null value in JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Booking[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Booking[createdAt]" has a null value in JSON.');
        return true;
      }());

      return Booking(
        id: mapValueOfType<String>(json, r'id')!,
        code: mapValueOfType<String>(json, r'code')!,
        status: BookingStatus.fromJson(json[r'status'])!,
        source_: BookingSource_Enum.fromJson(json[r'source'])!,
        departure: BookingDeparture.fromJson(json[r'departure'])!,
        product: BookingProduct.fromJson(json[r'product'])!,
        provider: BookingProvider.fromJson(json[r'provider'])!,
        selection: BookingSelection.fromJson(json[r'selection'])!,
        lines: BookingLinesInner.listFromJson(json[r'lines']),
        seats: mapValueOfType<int>(json, r'seats')!,
        totalUsd: num.parse('${json[r'totalUsd']}'),
        depositUsd: num.parse('${json[r'depositUsd']}'),
        paidUsd: num.parse('${json[r'paidUsd']}'),
        pendingUsd: num.parse('${json[r'pendingUsd']}'),
        balanceUsd: num.parse('${json[r'balanceUsd']}'),
        balanceDueDate: mapDateTime(json, r'balanceDueDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        heldUntil: mapDateTime(json, r'heldUntil', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
        cancelledBy: BookingCancelledByEnum.fromJson(json[r'cancelledBy']),
        refund: BookingRefund.fromJson(json[r'refund']),
        canReview: mapValueOfType<bool>(json, r'canReview')!,
        contact: BookingContact.fromJson(json[r'contact']),
        passengers: BookingPassenger.listFromJson(json[r'passengers']),
        mealChoices: MealChoice.listFromJson(json[r'mealChoices']),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
      );
    }
    return null;
  }

  static List<Booking> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Booking>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Booking.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Booking> mapFromJson(dynamic json) {
    final map = <String, Booking>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Booking.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Booking-objects as value to a dart map
  static Map<String, List<Booking>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Booking>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Booking.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'code',
    'status',
    'source',
    'departure',
    'product',
    'provider',
    'selection',
    'lines',
    'seats',
    'totalUsd',
    'depositUsd',
    'paidUsd',
    'pendingUsd',
    'balanceUsd',
    'balanceDueDate',
    'heldUntil',
    'cancelledBy',
    'refund',
    'canReview',
    'contact',
    'passengers',
    'mealChoices',
    'createdAt',
  };
}


enum BookingSource_Enum {
  app._(r'app'),
  agency._(r'agency'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingSource_Enum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingSource_Enum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingSource_Enum? fromJson(dynamic value) => BookingSource_EnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingSource_Enum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingSource_Enum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingSource_Enum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingSource_Enum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingSource_Enum] to String,
/// and [decode] dynamic data back to [BookingSource_Enum].
class BookingSource_EnumTypeTransformer {
  factory BookingSource_EnumTypeTransformer() => _instance ??= const BookingSource_EnumTypeTransformer._();

  const BookingSource_EnumTypeTransformer._();

  String encode(BookingSource_Enum data) => data._value;

  /// Returns the instance of [BookingSource_Enum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingSource_Enum? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingSource_Enum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'app': return BookingSource_Enum.app;
        case r'agency': return BookingSource_Enum.agency;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingSource_EnumTypeTransformer? _instance;
}



enum BookingCancelledByEnum {
  traveler._(r'traveler'),
  agency._(r'agency'),
  system._(r'system'),
  ;

  /// Instantiate a new enum with the provided value.
  const BookingCancelledByEnum._(this._value);

  /// The underlying value of this enum member.
  final String _value;

  @override
  String toString() => _value;

  /// Encodes this enum as a value suitable for JSON.
  String toJson() => _value;

  /// Returns the instance of [BookingCancelledByEnum] that was successfully decoded
  /// from the passed [value] on success, null otherwise.
  static BookingCancelledByEnum? fromJson(dynamic value) => BookingCancelledByEnumTypeTransformer().decode(value);

  /// Returns a [List] containing instances of [BookingCancelledByEnum]
  /// that were successfully decoded from the passed [JSON][json].
  static List<BookingCancelledByEnum> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <BookingCancelledByEnum>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = BookingCancelledByEnum.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }
}

/// Transformation class that can [encode] an instance of [BookingCancelledByEnum] to String,
/// and [decode] dynamic data back to [BookingCancelledByEnum].
class BookingCancelledByEnumTypeTransformer {
  factory BookingCancelledByEnumTypeTransformer() => _instance ??= const BookingCancelledByEnumTypeTransformer._();

  const BookingCancelledByEnumTypeTransformer._();

  String encode(BookingCancelledByEnum data) => data._value;

  /// Returns the instance of [BookingCancelledByEnum] that was successfully decoded
  /// from the passed [data] value on success, null otherwise.
  ///
  /// If [allowNull] is true and the [dynamic value][data] cannot be decoded successfully,
  /// then null is returned. However, if [allowNull] is false and the [dynamic value][data]
  /// cannot be decoded successfully, then an [UnimplementedError] is thrown.
  ///
  /// The [allowNull] is very handy when an API changes and a new enum value is added or removed,
  /// and users are still using an old app with the old code.
  BookingCancelledByEnum? decode(dynamic data, {bool allowNull = true}) {
    if (data is BookingCancelledByEnum) {
      return data;
    }
    if (data != null) {
      switch (data) {
        case r'traveler': return BookingCancelledByEnum.traveler;
        case r'agency': return BookingCancelledByEnum.agency;
        case r'system': return BookingCancelledByEnum.system;
        default:
          if (!allowNull) {
            throw ArgumentError('Unknown enum value to decode: $data');
          }
      }
    }
    return null;
  }

  /// The singleton instance of this transformer.
  static BookingCancelledByEnumTypeTransformer? _instance;
}


