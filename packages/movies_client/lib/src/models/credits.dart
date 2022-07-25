part of 'models.dart';

/// {@template credit}
/// A class that represents a credit element.
/// {@endtemplate}
class Credit {
  /// {@macro credit}
  Credit({
    this.id,
    required this.cast,
    required this.crew,
  });

  /// Returns a new [Credit] with the given [Map<String, dynamic>].
  factory Credit.fromJson(Map<String, dynamic> json) {
    // make sure we're dealing with a JSON map
    json = json.cast<String, dynamic>();

    // extract the results from the map
    late final List<Map<String, dynamic>> castItems;
    late final List<Map<String, dynamic>> crewItems;

    final cast = json['cast'];
    final crew = json['crew'];

    if (cast is List) {
      castItems = cast.cast<Map<dynamic, dynamic>>().map((Map<dynamic, dynamic> item) => item.cast<String, dynamic>()).toList();
    }
    if (crew is List) {
      crewItems = crew.cast<Map<dynamic, dynamic>>().map((Map<dynamic, dynamic> item) => item.cast<String, dynamic>()).toList();
    }

    // parse the results into a list of objects
    final parsedCast = castItems.map(CastCrew.fromJson).toList();
    final parsedCrew = crewItems.map(CastCrew.fromJson).toList();

    return Credit(
      id: json['id'] as int?,
      cast: parsedCast,
      crew: parsedCrew,
    );
  }

  /// The id of the credit.
  final int? id;

  /// The cast of the credit.
  final List<CastCrew> cast;

  /// The crew of the credit.
  final List<CastCrew> crew;
}

/// {@template cast}
/// A class that represents a cast element.
/// {@endtemplate}
class CastCrew {
  /// {@macro cast}
  CastCrew({
    this.adult = false,
    this.gender,
    this.id,
    this.knownForDepartment,
    this.name,
    this.originalName,
    this.popularity,
    this.profilePath,
    this.castId,
    this.character,
    this.creditId,
    this.order,
    this.department,
    this.job,
  });

  /// Returns a new [CastCrew] with the given [Map<String, dynamic>].
  factory CastCrew.fromJson(Map<String, dynamic> json) {
    return CastCrew(
      adult: json['adult'] as bool? ?? false,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num?)?.toInt(),
      knownForDepartment: json['known_for_department'] as String?,
      name: json['name'] as String?,
      originalName: json['original_name'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      profilePath: json['profile_path'] as String?,
      castId: (json['cast_id'] as num?)?.toInt(),
      character: json['character'] as String?,
      creditId: json['credit_id'] as String?,
      order: (json['order'] as num?)?.toInt(),
      department: json['department'] as String?,
      job: json['job'] as String?,
    );
  }

  /// Whether the cast is for adults or not.
  bool adult;

  /// The gender of the movie.
  int? gender;

  /// The ID of the movie.
  int? id;

  /// The known for department (?.
  String? knownForDepartment;

  /// The name of the movie.
  String? name;

  /// The original name of the movie.
  String? originalName;

  /// The popularity of the movie.
  double? popularity;

  /// The path to the profile of the movie.
  String? profilePath;

  /// The cast ID of the movie.
  int? castId;

  /// The character of the movie.
  String? character;

  /// The credit ID of the movie.
  String? creditId;

  /// The order of the movie.
  int? order;

  /// The department of the movie.
  String? department;

  /// The job of the movie.
  String? job;
}
