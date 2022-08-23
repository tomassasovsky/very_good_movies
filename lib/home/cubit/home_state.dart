part of 'home_cubit.dart';

/// {@template home_state}
/// The cubit state of the home feature.
/// {@endtemplate}
abstract class HomeState extends Equatable {
  /// {@macro home_state}
  const HomeState();

  @override
  List<Object?> get props => [];
}

/// {@template home_initial}
/// This represent the initial state of the home feature.
/// {@endtemplate}
class HomeInitial extends HomeState {
  /// {@macro home_initial}
  const HomeInitial();
}

/// {@template home_attempting}
/// This represent the attempting state of the home feature.
/// {@endtemplate}
class HomeAttempting extends HomeState {
  /// {@macro home_attempting}
  const HomeAttempting();
}

/// {@template home_success}
/// This represent the state of success for the request made in the
/// home feature.
/// {@endtemplate}
class HomeSuccess extends HomeState {
  /// {@macro home_success}
  const HomeSuccess({
    required this.popularMovies,
    required this.nowPlayingMovies,
  });

  final PaginatedResponse<Movie> popularMovies;
  final PaginatedResponse<Movie> nowPlayingMovies;

  @override
  List<Object?> get props => [popularMovies, nowPlayingMovies];
}

/// {@template home_failure}
/// This represent the error state of the home feature.
/// {@endtemplate}
class HomeFailure extends HomeState {
  /// {@macro home_failure}
  const HomeFailure();
}
