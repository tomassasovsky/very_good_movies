import 'package:bloc/bloc.dart';
import 'package:credits_repository/credits_repository.dart';
import 'package:data_persistence_repository/data_persistence_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:movies_repository/movies_repository.dart';

part 'settings_state.dart';

abstract class SettingsCubitBase {
  void toggleDarkMode();
  void changeLanguage(String language);
}

class SettingsCubit extends Cubit<SettingsState> implements SettingsCubitBase {
  SettingsCubit({
    required ThemeMode themeMode,
    required String language,
    required DataPersistenceRepository dataPersistenceRepository,
    required MoviesRepository moviesRepository,
    required CreditsRepository creditsRepository,
  })  : _dataPersistenceRepository = dataPersistenceRepository,
        _moviesRepository = moviesRepository,
        _creditsRepository = creditsRepository,
        super(
          SettingsState(
            themeMode: themeMode,
            language: language,
          ),
        );

  @override
  Future<void> changeLanguage(String language) async {
    await _dataPersistenceRepository.setLanguage(language);
    _moviesRepository.setLanguage(language);
    _creditsRepository.setLanguage(language);
    emit(state.copyWith(language: language));
  }

  @override
  Future<void> toggleDarkMode() async {
    if (state.isDarkMode) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          statusBarIconBrightness: Brightness.light, // For Android (dark icons)
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(
          systemNavigationBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.grey.shade700,
          statusBarIconBrightness: Brightness.dark, // For Android (dark icons)
        ),
      );
    }
    await _dataPersistenceRepository.toggleDarkMode();
    emit(
      state.copyWith(
        themeMode: state.isDarkMode ? ThemeMode.light : ThemeMode.dark,
      ),
    );
  }

  final DataPersistenceRepository _dataPersistenceRepository;
  final MoviesRepository _moviesRepository;
  final CreditsRepository _creditsRepository;
}
