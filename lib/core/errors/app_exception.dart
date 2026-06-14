import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';

/// Typed error hierarchy for the app.
///
/// Use [AppException.from] to wrap any raw exception before displaying it.
/// The factory inspects the error type and produces the most specific subtype.
sealed class AppException implements Exception {
  const AppException();

  factory AppException.from(Object error) {
    if (error is AppException) return error;
    if (error is DioException) return NetworkException(error);
    if (error is CheckedFromJsonException) {
      return ParseException(error, offendingField: _fieldPath(error));
    }
    if (error is TypeError || error is FormatException) {
      return ParseException(error);
    }
    return UnknownException(error);
  }
}

/// A network or HTTP-level failure (timeout, no connection, non-2xx, etc.).
final class NetworkException extends AppException {
  NetworkException(this.cause);

  final DioException cause;

  bool get isOffline => switch (cause.type) {
    DioExceptionType.connectionError ||
    DioExceptionType.connectionTimeout ||
    DioExceptionType.receiveTimeout ||
    DioExceptionType.sendTimeout => true,
    _ => false,
  };
}

/// A JSON parsing failure.
///
/// [offendingField] contains the dot-separated key path to the failing field
/// when [CheckedFromJsonException] is the root cause (requires `checked: true`
/// in build.yaml).
final class ParseException extends AppException {
  ParseException(this.cause, {this.offendingField});

  final Object cause;
  final String? offendingField;
}

/// Any other unexpected error.
final class UnknownException extends AppException {
  UnknownException(this.cause);

  final Object cause;
}

/// Extracts a human-readable error message suitable for showing directly to
/// the user, preferring the server-provided `message` field from a JSON
/// error response over Dio's generic exception text.
String apiErrorMessage(Object error) {
  if (error is DioException) {
    final data = error.response?.data;
    if (data is Map && data['message'] is String) {
      return data['message'] as String;
    }
  }
  return error.toString();
}

/// Walks the [CheckedFromJsonException] chain and builds a field path like
/// `communities → proPic → averageColor`.
String? _fieldPath(CheckedFromJsonException error) {
  final keys = <String>[];
  Object? current = error;
  while (current is CheckedFromJsonException) {
    final key = current.key;
    if (key != null) keys.add(key);
    current = current.innerError;
  }
  return keys.isEmpty ? null : keys.join(' → ');
}
