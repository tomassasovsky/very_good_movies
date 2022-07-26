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
  Future<Credit> getCredits(int page) async {
    return _client.getCredits(page);
  }
}
