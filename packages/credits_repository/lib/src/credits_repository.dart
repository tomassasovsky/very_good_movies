import 'package:movies_client/movies_client.dart';

/// {@template credits_repository}
/// The repository used to retrieve all the [MoviesClient] methods related to the credits.
/// {@endtemplate}
class CreditsRepository {
  /// {@macro credits_repository}
  const CreditsRepository(
    MoviesClient client,
  ) : _client = client;

  /// The client used to make requests.
  final MoviesClient _client;

  /// Method that make the request to get the most popular movies.
  Future<Credits> getCredits(int page, int? movieId) async {
    /// If the movieId is null, then we will throw an [ArgumentError].
    if (movieId == null) {
      throw ArgumentError.notNull('movieId');
    }

    return _client.getCredits(page, movieId);
  }
}
