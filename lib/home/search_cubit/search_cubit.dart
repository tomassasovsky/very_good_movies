import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';

part 'search_state.dart';

abstract class SearchCubitBase {
  const SearchCubitBase();

  /// This method is used to search for movies.
  Future<void> searchMovies(String query);

  /// This method is used to search for more movies.
  Future<void> searchMoreMovies(String query);
}

class SearchCubit extends Cubit<SearchState> implements SearchCubitBase {
  SearchCubit({
    required MoviesRepository moviesRepository,
  })  : _moviesRepository = moviesRepository,
        super(const SearchSuccess());

  @override
  Future<void> searchMovies(String query) async {
    final _state = state;
    if (_state is SearchSuccess) {
      if (_state.query == query) {
        return;
      }
    }

    emit(const SearchAttempting());

    try {
      final response = await _moviesRepository.searchMovie(1, query);
      if (response.totalPages == 0) {
        return emit(const SearchEmpty());
      }
      emit(
        SearchSuccess(
          query: query,
          movies: response.results,
          isLastPage: response.totalPages == 1,
        ),
      );
    } on SocketException {
      emit(const SearchInternetFailure());
    } on SpecifiedTypeNotMatchedException {
      emit(const SearchTypeFailure());
    } catch (error) {
      emit(const SearchUnknownFailure());
    }
  }

  final MoviesRepository _moviesRepository;

  @override
  Future<void> searchMoreMovies(String query) async {
    final _state = state;
    if (_state is! SearchSuccess) return;
    final newIndex = _state.pageIndex + 1;
    try {
      final response = await _moviesRepository.searchMovie(newIndex, query);
      emit(
        SearchSuccess(
          query: query,
          movies: [..._state.movies, ...response.results],
          pageIndex: newIndex,
          isLastPage: response.totalPages == newIndex,
        ),
      );
    } on SocketException {
      emit(const SearchInternetFailure());
    } on SpecifiedTypeNotMatchedException {
      emit(const SearchTypeFailure());
    } catch (error) {
      emit(const SearchUnknownFailure());
    }
  }
}
