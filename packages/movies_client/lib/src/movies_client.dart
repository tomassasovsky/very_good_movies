import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:movies_client/src/models/models.dart';

/// {@template movies_client}
/// The Client used to make requests to the Movie Database API.
/// {@endtemplate}
class MoviesClient {
  /// {@macro movies_client}
  MoviesClient({
    required String apiKey,
    required this.language,
  }) : _apiKey = apiKey;

  /// The API key that use to make requests.
  final String _apiKey;

  /// Language of the movies.
  String language;

  /// The query parameters used across all requests.
  JSON get defaultParams => {
        'api_key': _apiKey,
        'language': language,
      };

  /// The client used to make requests.
  final _client = http.Client();

  /// The base URL of the API.
  static const _authority = 'api.themoviedb.org';

  /// Method that make the request to search with a specific query.
  Future<PaginatedResponse<Movie>> searchMovie(int page, String query) async {
    final response = await _get<JSON>('3/search/movie', {
      'page': '$page',
      'query': query,
    });

    try {
      return PaginatedResponse<Movie>.fromJson(Movie.fromJson, response);
    } catch (e) {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// Method that make the request to get the now playing movies.
  Future<PaginatedResponse<Movie>> getNowPlaying(int page) async {
    final response = await _get<JSON>('/3/movie/now_playing', {
      'page': '$page',
    });

    try {
      return PaginatedResponse<Movie>.fromJson(Movie.fromJson, response);
    } catch (e) {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// Method that make the request to get the most popular movies.
  Future<PaginatedResponse<Movie>> getPopular(int page) async {
    final response = await _get<JSON>('/3/movie/popular', {
      'page': '$page',
    });

    try {
      return PaginatedResponse<Movie>.fromJson(Movie.fromJson, response);
    } catch (e) {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// Method that make the request to get the most popular movies.
  Future<Credit> getCredits(int page) async {
    final response = await _get<JSON>('/3/movie/popular', {
      'page': '$page',
    });

    try {
      return Credit.fromJson(response);
    } catch (e) {
      throw const SpecifiedTypeNotMatchedException();
    }
  }

  /// A method to make the request to the API.
  Future<T> _get<T>(String endpoint, Map<String, dynamic>? queryParameters) async {
    final url = Uri.https(_authority, endpoint, {
      ...?queryParameters,
      ...defaultParams,
    });

    // Await the http get response, then decode the json-formatted response.
    final response = await _client.get(url);
    return _handleResponse<T>(response);
  }

  /// A method that takes a [http.Response] and returns the type specified by [T].
  T _handleResponse<T>(http.Response response) {
    try {
      if (response is T) return response as T;

      final decodedResponse = jsonDecode(response.body);

      if (response.isFailure && decodedResponse is JSON) {
        if (decodedResponse.containsKey('status_message')) {
          throw ExceptionResponse.fromMap(
            decodedResponse,
            response.request?.url.path,
          );
        }
        throw HttpRequestFailure(
          response.statusCode,
          response.reasonPhrase ?? '',
        );
      }

      if (decodedResponse is T) return decodedResponse;

      try {
        if (T == JSON) {
          return (decodedResponse as Map).cast<String, dynamic>() as T;
        } else if (T == JSONLIST) {
          final newResponse = (decodedResponse as List)
              .map<JSON>(
                (dynamic item) => (item as Map).cast<String, dynamic>(),
              )
              .toList();
          return newResponse as T;
        }

        return decodedResponse as T;
      } catch (_) {
        throw const SpecifiedTypeNotMatchedException();
      }
    } on FormatException {
      throw const JsonDecodeException();
    }
  }
}

/// {@template http_request_failure}
/// Thrown if an http request returns a non-200 status code.
/// {@endtemplate}
class HttpRequestFailure implements Exception {
  /// {@macro http_request_failure}
  const HttpRequestFailure(this.statusCode, this.error);

  /// The status code of the response.
  final int statusCode;

  /// The error message of the response.
  final String error;

  @override
  String toString() => 'HttpRequestFailure(statusCode: $statusCode, error: $error)';
}

/// {@template json_decode_exception}
/// Thrown if an http response throws an error during decoding.
/// {@endtemplate}
class JsonDecodeException implements Exception {
  /// {@macro json_decode_exception}
  const JsonDecodeException();
}

/// {@template specified_type_not_matched_exception}
/// Thrown if an http response doesn't match the expected type.
/// {@endtemplate}
class SpecifiedTypeNotMatchedException implements Exception {
  /// {@macro specified_type_not_matched_exception}
  const SpecifiedTypeNotMatchedException();
}

/// An extension to add an `isSuccess` and `isFailure` property to the [http.Response] class.
extension Result on http.Response {
  /// Returns true if the response is a success.
  bool get isSuccess => statusCode >= 200 && statusCode < 300;

  /// Returns true if the response is a failure.
  bool get isFailure => !isSuccess;
}
