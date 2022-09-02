import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';

part 'home_state.dart';

abstract class HomeCubitBase {
  const HomeCubitBase();

  /// This method is used to get all the movies we
  /// are going to be using in the home feature.
  Future<void> getMovies();

  /// This method is used to fetch more popular movies.
  Future<void> getMorePopularMovies();
}

class HomeCubit extends Cubit<HomeState> implements HomeCubitBase {
  HomeCubit({
    required MoviesRepository moviesRepository,
  })  : _moviesRepository = moviesRepository,
        super(const HomeInitial());

  @override
  Future<void> getMovies() async {
    emit(const HomeAttempting());

    try {
      final movies = await Future.wait([
        _moviesRepository.getPopular(1),
        _moviesRepository.getNowPlaying(1),
      ]);

      final popularMovies = movies.first;
      final nowPlayingMovies = movies.last;

      emit(
        HomeSuccess(
          popularMovies: popularMovies.results,
          nowPlayingMovies: nowPlayingMovies.results,
        ),
      );
    } on SocketException {
      emit(const HomeInternetFailure());
    } on SpecifiedTypeNotMatchedException {
      emit(const HomeTypeFailure());
    } catch (error) {
      emit(const HomeUnknownFailure());
    }
  }

  final MoviesRepository _moviesRepository;

  @override
  Future<void> getMorePopularMovies() async {
    final _state = state;
    if (_state is! HomeSuccess) return;
    emit(
      HomeFetchingMoreMovies.fromSuccess(_state),
    );
    try {
      final newPopularMovies = await _moviesRepository.getPopular(
        _state.popularIndex + 1,
      );

      _state.popularMovies.addAll(newPopularMovies.results);

      emit(
        _state.copyWith(
          popularIndex: _state.popularIndex + 1,
        ),
      );
    } on SocketException {
      emit(const HomeInternetFailure());
    } on SpecifiedTypeNotMatchedException {
      emit(const HomeTypeFailure());
    } catch (error) {
      emit(const HomeUnknownFailure());
    }
  }
}
