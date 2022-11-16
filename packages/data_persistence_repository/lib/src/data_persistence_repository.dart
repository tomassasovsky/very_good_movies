import 'package:hive/hive.dart';
import 'package:movies_client/movies_client.dart';
import 'package:path_provider/path_provider.dart';

/// {@template data_persistence_repository}
/// Repository to handle data persistence.
///
/// To understand more about the package we use to save data, please visit:
/// https://pub.dev/packages/hive.
/// {@endtemplate}
class DataPersistenceRepository {
  /// {@macro data_persistence_repository}
  const DataPersistenceRepository();

  /// Method to initialize the repository.
  Future<void> init() async {
    final directory = await getApplicationSupportDirectory();
    if (!directory.existsSync()) {
      directory.createSync();
    }

    Hive
      ..init(directory.path)
      ..registerAdapter(LanguageAdapter());

    await Future.wait([
      Hive.openBox<dynamic>(DataPersistenceRepository._settingBox),
    ]);

    if (isDarkMode == null) {
      await settingBox.put(AppSettingsKeys.isDarkMode.name, true);
    }
  }

  /// Method to get the settings [Box].
  Box<dynamic> get settingBox => Hive.box<dynamic>(DataPersistenceRepository._settingBox);

  /// Method to get the language of the app.
  Language? get language => settingBox.get(AppSettingsKeys.language.name) as Language?;

  /// Method to get the theme of the app.
  bool? get isDarkMode => settingBox.get(AppSettingsKeys.isDarkMode.name) as bool?;

  /// Method to set the language of the app.
  Future<void> setLanguage(Language language) async => settingBox.put(AppSettingsKeys.language.name, language);

  /// Method to set the theme of the app.
  Future<void> toggleDarkMode() async => settingBox.put(AppSettingsKeys.isDarkMode.name, !isDarkMode!);

  /// The name of the app settings box.
  static const _settingBox = 'settings';
}

/// {@template app_settings_keys}
/// Enum with all the settings keys.
/// {@endtemplate}
enum AppSettingsKeys {
  /// Language key.
  language,

  /// App theme key.
  isDarkMode,
}
