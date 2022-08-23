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
          popularMovies: popularMovies,
          nowPlayingMovies: nowPlayingMovies,
        ),
      );
    } catch (error) {
      emit(const HomeFailure());
    }
  }

  final MoviesRepository _moviesRepository;
}
