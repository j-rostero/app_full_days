//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class Review {
  /// Returns a new [Review] instance.
  Review({
    required this.id,
    required this.productId,
    required this.title,
    required this.rating,
    required this.aspects,
    required this.asDescribed,
    required this.comment,
    required this.author,
    required this.tripDate,
    required this.reply,
    required this.repliedAt,
    required this.createdAt,
    required this.moderation,
  });

  String id;

  String productId;

  String title;

  /// Minimum value: -9007199254740991
  /// Maximum value: 9007199254740991
  int rating;

  ReviewAspects aspects;

  bool asDescribed;

  String comment;

  String author;

  DateTime tripDate;

  String? reply;

  DateTime? repliedAt;

  DateTime createdAt;

  ReviewModeration? moderation;

  @override
  bool operator ==(Object other) => identical(this, other) || other is Review &&
    other.id == id &&
    other.productId == productId &&
    other.title == title &&
    other.rating == rating &&
    other.aspects == aspects &&
    other.asDescribed == asDescribed &&
    other.comment == comment &&
    other.author == author &&
    other.tripDate == tripDate &&
    other.reply == reply &&
    other.repliedAt == repliedAt &&
    other.createdAt == createdAt &&
    other.moderation == moderation;

  @override
  int get hashCode =>
    // ignore: unnecessary_parenthesis
    (id.hashCode) +
    (productId.hashCode) +
    (title.hashCode) +
    (rating.hashCode) +
    (aspects.hashCode) +
    (asDescribed.hashCode) +
    (comment.hashCode) +
    (author.hashCode) +
    (tripDate.hashCode) +
    (reply == null ? 0 : reply!.hashCode) +
    (repliedAt == null ? 0 : repliedAt!.hashCode) +
    (createdAt.hashCode) +
    (moderation == null ? 0 : moderation!.hashCode);

  @override
  String toString() => 'Review[id=$id, productId=$productId, title=$title, rating=$rating, aspects=$aspects, asDescribed=$asDescribed, comment=$comment, author=$author, tripDate=$tripDate, reply=$reply, repliedAt=$repliedAt, createdAt=$createdAt, moderation=$moderation]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
      json[r'id'] = this.id;
      json[r'productId'] = this.productId;
      json[r'title'] = this.title;
      json[r'rating'] = this.rating;
      json[r'aspects'] = this.aspects;
      json[r'asDescribed'] = this.asDescribed;
      json[r'comment'] = this.comment;
      json[r'author'] = this.author;
      json[r'tripDate'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')
        ? this.tripDate.millisecondsSinceEpoch
        : _dateFormatter.format(this.tripDate);
    if (this.reply != null) {
      json[r'reply'] = this.reply;
    } else {
      json[r'reply'] = null;
    }
    if (this.repliedAt != null) {
      json[r'repliedAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.repliedAt!.millisecondsSinceEpoch
        : this.repliedAt!.toUtc().toIso8601String();
    } else {
      json[r'repliedAt'] = null;
    }
      json[r'createdAt'] = _isEpochMarker(r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')
        ? this.createdAt.millisecondsSinceEpoch
        : this.createdAt.toUtc().toIso8601String();
    if (this.moderation != null) {
      json[r'moderation'] = this.moderation;
    } else {
      json[r'moderation'] = null;
    }
    return json;
  }

  /// Returns a new [Review] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static Review? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        assert(json.containsKey(r'id'), 'Required key "Review[id]" is missing from JSON.');
        assert(json[r'id'] != null, 'Required key "Review[id]" has a null value in JSON.');
        assert(json.containsKey(r'productId'), 'Required key "Review[productId]" is missing from JSON.');
        assert(json[r'productId'] != null, 'Required key "Review[productId]" has a null value in JSON.');
        assert(json.containsKey(r'title'), 'Required key "Review[title]" is missing from JSON.');
        assert(json[r'title'] != null, 'Required key "Review[title]" has a null value in JSON.');
        assert(json.containsKey(r'rating'), 'Required key "Review[rating]" is missing from JSON.');
        assert(json[r'rating'] != null, 'Required key "Review[rating]" has a null value in JSON.');
        assert(json.containsKey(r'aspects'), 'Required key "Review[aspects]" is missing from JSON.');
        assert(json[r'aspects'] != null, 'Required key "Review[aspects]" has a null value in JSON.');
        assert(json.containsKey(r'asDescribed'), 'Required key "Review[asDescribed]" is missing from JSON.');
        assert(json[r'asDescribed'] != null, 'Required key "Review[asDescribed]" has a null value in JSON.');
        assert(json.containsKey(r'comment'), 'Required key "Review[comment]" is missing from JSON.');
        assert(json[r'comment'] != null, 'Required key "Review[comment]" has a null value in JSON.');
        assert(json.containsKey(r'author'), 'Required key "Review[author]" is missing from JSON.');
        assert(json[r'author'] != null, 'Required key "Review[author]" has a null value in JSON.');
        assert(json.containsKey(r'tripDate'), 'Required key "Review[tripDate]" is missing from JSON.');
        assert(json[r'tripDate'] != null, 'Required key "Review[tripDate]" has a null value in JSON.');
        assert(json.containsKey(r'reply'), 'Required key "Review[reply]" is missing from JSON.');
        assert(json.containsKey(r'repliedAt'), 'Required key "Review[repliedAt]" is missing from JSON.');
        assert(json.containsKey(r'createdAt'), 'Required key "Review[createdAt]" is missing from JSON.');
        assert(json[r'createdAt'] != null, 'Required key "Review[createdAt]" has a null value in JSON.');
        assert(json.containsKey(r'moderation'), 'Required key "Review[moderation]" is missing from JSON.');
        return true;
      }());

      return Review(
        id: mapValueOfType<String>(json, r'id')!,
        productId: mapValueOfType<String>(json, r'productId')!,
        title: mapValueOfType<String>(json, r'title')!,
        rating: mapValueOfType<int>(json, r'rating')!,
        aspects: ReviewAspects.fromJson(json[r'aspects'])!,
        asDescribed: mapValueOfType<bool>(json, r'asDescribed')!,
        comment: mapValueOfType<String>(json, r'comment')!,
        author: mapValueOfType<String>(json, r'author')!,
        tripDate: mapDateTime(json, r'tripDate', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))$/')!,
        reply: mapValueOfType<String>(json, r'reply'),
        repliedAt: mapDateTime(json, r'repliedAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/'),
        createdAt: mapDateTime(json, r'createdAt', r'/^(?:(?:\\d\\d[2468][048]|\\d\\d[13579][26]|\\d\\d0[48]|[02468][048]00|[13579][26]00)-02-29|\\d{4}-(?:(?:0[13578]|1[02])-(?:0[1-9]|[12]\\d|3[01])|(?:0[469]|11)-(?:0[1-9]|[12]\\d|30)|(?:02)-(?:0[1-9]|1\\d|2[0-8])))T(?:(?:[01]\\d|2[0-3]):[0-5]\\d:[0-5]\\d(?:\\.\\d+)?(?:Z))$/')!,
        moderation: ReviewModeration.fromJson(json[r'moderation']),
      );
    }
    return null;
  }

  static List<Review> listFromJson(dynamic json, {bool growable = false,}) {
    final result = <Review>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = Review.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, Review> mapFromJson(dynamic json) {
    final map = <String, Review>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = Review.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of Review-objects as value to a dart map
  static Map<String, List<Review>> mapListFromJson(dynamic json, {bool growable = false,}) {
    final map = <String, List<Review>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = Review.listFromJson(entry.value, growable: growable,);
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{
    'id',
    'productId',
    'title',
    'rating',
    'aspects',
    'asDescribed',
    'comment',
    'author',
    'tripDate',
    'reply',
    'repliedAt',
    'createdAt',
    'moderation',
  };
}

