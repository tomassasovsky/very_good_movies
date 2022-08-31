// ignore_for_file: one_member_abstracts

import 'package:bloc/bloc.dart';
import 'package:credits_repository/credits_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:movies_client/movies_client.dart';

part 'details_state.dart';

abstract class DetailsCubitBase {
  /// This method is used to get the credits of the movie.
  Future<void> getCredits(int page, int movieId);
}

class DetailsCubit extends Cubit<DetailsState> implements DetailsCubitBase {
  DetailsCubit({
    required CreditsRepository creditsRepository,
  })  : _creditsRepository = creditsRepository,
        super(const DetailsInitial());

  @override
  Future<void> getCredits(int page, int? movieId) async {
    emit(const DetailsAttempting());
    try {
      final credits = await _creditsRepository.getCredits(page, movieId);
      emit(DetailsSuccess(credits));
    } catch (_) {
      emit(const DetailsFailure());
    }
  }

  final CreditsRepository _creditsRepository;
}
