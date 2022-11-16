import 'package:hive/hive.dart';
part 'language.g.dart';

/// {@template language}
/// A class that represents a language item from the API.
/// {@endtemplate}
@HiveType(typeId: 0) // This type is just to tell hive which model it is.
class Language {
  /// {@macro language}
  const Language({
    required this.iso,
    required this.englishName,
    required this.name,
  });

  /// Creates an English [Language].
  factory Language.enUS() => const Language(
        iso: 'en',
        englishName: 'English',
        name: 'English',
      );

  /// This method returns a new [Language] with the given [Map<String, dynamic>].
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      iso: json['iso_639_1'] as String,
      englishName: json['english_name'] as String,
      name: json['name'] as String,
    );
  }

  @HiveField(0)

  /// The ISO code of the language.
  final String iso;

  @HiveField(1)

  /// The english name of the language.
  final String englishName;

  @HiveField(2)

  /// The name of the language. avisame cuando estes
  final String name;
}
