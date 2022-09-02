part of 'search_cubit.dart';

/// {@template search_state}
/// The cubit state of the search.
/// {@endtemplate}
abstract class SearchState extends Equatable {
  /// {@macro search_state}
  const SearchState();

  bool get isFailure => this is SearchFailure;
  bool get isInternetFailure => this is SearchInternetFailure;
  bool get isTypeFailure => this is SearchTypeFailure;
  bool get isAttempting => this is SearchAttempting;
  bool get isSuccess => this is SearchSuccess;
  bool get isEmpty => this is SearchEmpty;

  @override
  List<Object> get props => [];
}

/// {@template search_attempting}
/// This represent the attempting state of the search feature.
/// {@endtemplate}
class SearchAttempting extends SearchState {
  /// {@macro home_attempting}
  const SearchAttempting();
}

/// {@template search_empty}
/// This used to represent the empty state of the search feature,
/// so when there is no movie for the current query we show this state.
/// {@endtemplate}
class SearchEmpty extends SearchState {
  /// {@macro search_empty}
  const SearchEmpty();
}

/// {@template search_success}
/// This represent the state of success for the search made.
/// {@endtemplate}
class SearchSuccess extends SearchState {
  /// {@macro search_success}
  const SearchSuccess({
    this.movies = const [],
    this.pageIndex = 1,
    this.isLastPage = false,
    this.query = '',
  });

  final List<Movie> movies;
  final int pageIndex;
  final bool isLastPage;
  final String query;

  @override
  List<Object> get props => [
        movies,
        pageIndex,
        isLastPage,
        query,
      ];
}

/// {@template search_failure}
/// This represent the failure state of the search feature.
/// {@endtemplate}
class SearchFailure extends SearchState {
  /// {@macro search_failure}
  const SearchFailure();
}

/// {@template search_internet_failure}
/// When the state of failure is due to the lack of internet.
/// {@endtemplate}
class SearchInternetFailure extends SearchFailure {
  /// {@macro search_internet_failure}
  const SearchInternetFailure();
}

/// {@template home_type_failure}
/// When the state of failure is due to the type of the response not
/// matching the expected type.
/// {@endtemplate}
class SearchTypeFailure extends SearchFailure {
  /// {@macro search_type_failure}
  const SearchTypeFailure();
}

/// {@template home_unknown_failure}
/// When the state of failure is due to an unknown error.
/// {@endtemplate}
class SearchUnknownFailure extends SearchFailure {
  /// {@macro search_unknown_failure}
  const SearchUnknownFailure();
}
