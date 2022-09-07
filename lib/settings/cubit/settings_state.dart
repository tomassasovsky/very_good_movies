part of 'settings_cubit.dart';

class SettingsState extends Equatable {
  const SettingsState({
    required this.themeMode,
    required this.language,
  });

  final ThemeMode themeMode;
  final String language;

  bool get isDarkMode => themeMode == ThemeMode.dark;

  SettingsState copyWith({
    ThemeMode? themeMode,
    String? language,
  }) {
    return SettingsState(
      themeMode: themeMode ?? this.themeMode,
      language: language ?? this.language,
    );
  }

  @override
  List<Object> get props => [
        themeMode,
        language,
      ];
}
