import 'package:equatable/equatable.dart';

part 'credits.dart';
part 'exception_response_model.dart';
part 'movie.dart';
part 'movies_dates.dart';
part 'paginated_response.dart';

/// The JSON serializable model for the API response.
typedef JSON = Map<String, dynamic>;

/// When de API response is a List of [JSON]
typedef JSONLIST = List<JSON>;
