/// {@template movies_dates}
/// A class that contains the dates of the movies.
/// {@endtemplate}
class MoviesDates {
  /// {@macro movies_dates}
  const MoviesDates({
    this.maximum,
    this.minimum,
  });

  /// The maximum date of the movies.
  final DateTime? maximum;

  /// The minimum date of the movies.
  final DateTime? minimum;
}
