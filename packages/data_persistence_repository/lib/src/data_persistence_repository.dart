import 'package:hive/hive.dart';
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

    Hive.init(directory.path);

    await Future.wait([
      Hive.openBox<dynamic>(DataPersistenceRepository._settingBox),
    ]);
  }

  /// Method to get the settings [Box].
  Box<dynamic> get settingBox => Hive.box<dynamic>(DataPersistenceRepository._settingBox);

  /// Method to get the language of the app.
  String? get language => settingBox.get(AppSettingsKeys.language.name) as String?;

  /// Method to set the language of the app.
  Future<void> setLanguage(String language) async => settingBox.put(AppSettingsKeys.language, language);

  /// The name of the app settings box.
  static const _settingBox = 'settings';
}

/// {@template app_settings_keys}
/// Enum with all the settings keys.
/// {@endtemplate}
enum AppSettingsKeys {
  /// Language key.
  language,
}
