import 'package:movies_client/movies_client.dart';

/// {@template movies_repository}
/// The repository used to retrieve all the [MoviesClient] methods related to the movies.
/// {@endtemplate}
class MoviesRepository {
  /// {@macro movies_repository}
  const MoviesRepository(
    MoviesClient client,
  ) : _client = client;

  /// The client used to make requests.
  final MoviesClient _client;

  /// Method that make the request to get the now playing movies.
  Future<PaginatedResponse<Movie>> getNowPlaying(int page) async {
    return _client.getNowPlaying(page);
  }

  /// Method that make the request to search with a specific query.
  Future<PaginatedResponse<Movie>> searchMovie(int page, String query) async {
    return _client.searchMovie(page, query);
  }

  /// Method that make the request to get the most popular movies.
  Future<PaginatedResponse<Movie>> getPopular(int page) async {
    return _client.getPopular(page);
  }
}
