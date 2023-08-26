enum ApiErrorType {
  network,
  api,
  parse,
  server,
  unknown,
}

class ApiError implements Exception {
  final String? status;
  final String? code;
  final String? message;
  final ApiErrorType errorType;

  ApiError._(this.errorType, {this.status, this.code, this.message});

  factory ApiError.api(String status, String code, String? message) {
    return ApiError._(ApiErrorType.api, status: status, code: code, message: message);
  }

  factory ApiError.network(String message) {
    return ApiError._(ApiErrorType.network, message: message);
  }

  factory ApiError.parse(String message) {
    return ApiError._(ApiErrorType.parse, message: message);
  }

  factory ApiError.server() {
    return ApiError._(ApiErrorType.server);
  }

  factory ApiError.unknown() {
    return ApiError._(ApiErrorType.unknown);
  }

  @override
  String toString() {
    return 'Error $errorType; status: $status; code: $code; message: $message';
  }
}
