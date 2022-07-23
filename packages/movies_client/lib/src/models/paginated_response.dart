import 'package:movies_client/src/models/movies_dates.dart';

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

  /// Returns a new [PaginatedResponse] with the given [results].
  factory PaginatedResponse.fromJson(T Function(Map<String, dynamic> map) itemParser, Map<String, dynamic> json) {
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
      results: parsedItems,
    );
  }
}
