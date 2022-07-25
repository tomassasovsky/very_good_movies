part of 'models.dart';

/// {@template movies_dates}
/// A class that contains the dates of the movies.
/// {@endtemplate}
class MoviesDates {
  /// {@macro movies_dates}
  const MoviesDates({
    this.maximum,
    this.minimum,
  });

  /// Returns a new [MoviesDates] with the given [Map<String, dynamic>].
  factory MoviesDates.fromJson(Map<String, dynamic> json) {
    return MoviesDates(
      maximum: DateTime.tryParse(json['maximum'] as String? ?? ''),
      minimum: DateTime.tryParse(json['minimum'] as String? ?? ''),
    );
  }

  /// The maximum date of the movies.
  final DateTime? maximum;

  /// The minimum date of the movies.
  final DateTime? minimum;
}
