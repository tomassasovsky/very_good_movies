// ignore_for_file: prefer_const_constructors
import 'package:movies_client/movies_client.dart';
import 'package:movies_repository/movies_repository.dart';
import 'package:test/test.dart';

void main() {
  group('MoviesRepository', () {
    test('can be instantiated', () {
      expect(
        MoviesRepository(
          MoviesClient(
            apiKey: '',
            language: '',
          ),
        ),
        isNotNull,
      );
    });
  });
}
