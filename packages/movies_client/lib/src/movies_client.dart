/// {@template movies_client}
/// The Client used to make requests to the Movie's API.
/// {@endtemplate}
class MoviesClient {
  /// {@macro movies_client}
  MoviesClient({
    required String apiKey,
    required this.language,
  }) : _apiKey = apiKey;

  /// The API key that use to make requests.
  final String _apiKey;

  /// Language of the movies.
  String language;

  static const _authority = 'api.themoviedb.org';
}
