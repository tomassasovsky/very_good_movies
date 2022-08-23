part of 'models.dart';

/// {@template movie}
/// A class that represents a movie.
/// {@endtemplate}
class Movie {
  /// {@macro movie}
  const Movie({
    this.posterPath,
    this.adult = false,
    this.overview,
    this.releaseDate,
    this.genreIds,
    this.id,
    this.originalTitle,
    this.originalLanguage,
    this.title,
    this.backdropPath,
    this.popularity,
    this.voteCount,
    this.video = false,
    this.voteAverage,
  });

  /// Returns a new [Movie] with the given [Map<String, dynamic>].
  factory Movie.fromJson(Map<String, dynamic> json) {
    final releaseDate = json['release_date'] as String?;

    return Movie(
      posterPath: json['poster_path'] as String?,
      adult: json['adult'] as bool? ?? false,
      overview: json['overview'] as String?,
      releaseDate: releaseDate == null ? null : DateTime.tryParse(releaseDate),
      genreIds: (json['genre_ids'] as List<dynamic>?)?.cast<int>(),
      id: json['id'] as int?,
      originalTitle: json['original_title'] as String?,
      originalLanguage: json['original_language'] as String?,
      title: json['title'] as String?,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num?)?.toDouble(),
      voteCount: json['vote_count'] as int?,
      video: json['video'] as bool? ?? false,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
    );
  }

  /// The path to the poster of the movie.
  final String? posterPath;

  /// Whether the movie is for adults or not.
  final bool adult;

  /// The overview of the movie.
  final String? overview;

  /// The release date of the movie.
  final DateTime? releaseDate;

  /// The genre ids of the movie.
  final List<int>? genreIds;

  /// The id of the movie.
  final int? id;

  /// The original title of the movie.
  final String? originalTitle;

  /// The original language of the movie.
  final String? originalLanguage;

  /// The title of the movie.
  final String? title;

  /// The backdrop path of the movie.
  final String? backdropPath;

  /// The popularity of the movie.
  final num? popularity;

  /// The vote count of the movie.
  final int? voteCount;

  /// Whether the movie has a video or not.
  final bool video;

  /// The vote average of the movie.
  final num? voteAverage;
}
