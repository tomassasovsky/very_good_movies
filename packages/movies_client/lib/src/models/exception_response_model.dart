part of 'models.dart';

/// A class that contains the error gotten from the backend methods.
class ExceptionResponse with EquatableMixin implements Exception {
  /// Creates a new instance of the [ExceptionResponse] class.
  const ExceptionResponse({
    this.exception,
    this.statusCode,
    this.path,
  });

  /// Creates a new instance of the [ExceptionResponse] class from a JSON
  factory ExceptionResponse.fromMap(Map<dynamic, dynamic> json, String? path) {
    json = json.cast<String, dynamic>();
    return ExceptionResponse(
      exception: json['status_message'] as String?,
      statusCode: (json['status_code'] as num?)?.toInt() ?? 500,
      path: path,
    );
  }

  /// The exception gotten from the backend.
  final String? exception;

  /// The status code gotten from the backend.
  final int? statusCode;

  /// The path used in the request.
  final String? path;

  @override
  String toString() {
    return 'ExceptionResponse(exception: $exception, statusCode: $statusCode, path: $path)';
  }

  @override
  List<Object?> get props => [exception, statusCode, path];
}
