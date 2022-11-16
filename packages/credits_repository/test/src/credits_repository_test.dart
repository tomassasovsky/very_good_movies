// ignore_for_file: prefer_const_constructors
import 'package:credits_repository/credits_repository.dart';
import 'package:movies_client/movies_client.dart';
import 'package:test/test.dart';

void main() {
  group('CreditsRepository', () {
    test('can be instantiated', () {
      expect(
        CreditsRepository(
          MoviesClient(
            apiKey: '',
            language: Language(
              iso: 'en_US',
              englishName: 'English',
              name: 'English',
            ),
          ),
        ),
        isNotNull,
      );
    });
  });
}
