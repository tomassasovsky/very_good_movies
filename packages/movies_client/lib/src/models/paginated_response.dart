part of 'models.dart';

/// {@template paginated_response}
/// A generic class for paginated responses.
/// {@endtemplate}
class PaginatedResponse<T> {
  /// {@macro paginated_response}
  const PaginatedResponse({
    this.id,
    this.page = 0,
    this.totalPages = 0,
    this.totalResults = 0,
    this.dates,
    required this.results,
  });

  /// Returns a new [PaginatedResponse] with the given [results].
  factory PaginatedResponse.fromJson(T Function(Map<String, dynamic> map) itemParser, Map<String, dynamic> json) {
    final dates = json['dates'] as Map<String, dynamic>?;

    // make sure we're dealing with a JSON map
    json = json.cast<String, dynamic>();

    // extract the results from the map
    late final List<Map<String, dynamic>> items;

    final mapResults = json['results'];

    if (mapResults is List) {
      items = mapResults.cast<Map<dynamic, dynamic>>().map((Map<dynamic, dynamic> item) => item.cast<String, dynamic>()).toList();
    } else if (mapResults is Map) {
      items = [mapResults.cast<String, dynamic>()];
    }

    // parse the results into a list of objects
    final parsedItems = items.map(itemParser).toList();

    return PaginatedResponse(
      id: json['id'] as int?,
      results: parsedItems,
      page: json['page'] as int? ?? 0,
      totalPages: json['total_pages'] as int? ?? 0,
      totalResults: json['total_results'] as int? ?? 0,
      dates: dates == null ? null : MoviesDates.fromJson(dates),
    );
  }

  /// The id of the response.
  final int? id;

  /// The page of the response.
  final int page;

  /// The total number of pages.
  final int totalPages;

  /// The total number of results.
  final int totalResults;

  /// The results of the response.
  final List<T>? results;

  /// The dates of the movies.
  final MoviesDates? dates;
}
