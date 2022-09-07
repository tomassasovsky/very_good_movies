part of 'models.dart';

/// {@template language}
/// A class that represents a language item from the API.
/// {@endtemplate}
class Language {
  /// {@macro language}
  const Language({
    required this.iso,
    required this.englishName,
    required this.name,
  });

  /// This method returns a new [Language] with the given [Map<String, dynamic>].
  factory Language.fromJson(Map<String, dynamic> json) {
    return Language(
      iso: json['iso_639_1'] as String,
      englishName: json['english_name'] as String,
      name: json['name'] as String,
    );
  }

  /// The ISO code of the language.
  final String iso;

  /// The english name of the language.
  final String englishName;

  /// The name of the language.
  final String name;
}
