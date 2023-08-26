import 'dart:io';

class ApiClient {
  static late ApiClient _apiClient;

  static void init(String host) {
    _apiClient = ApiClient._(host);
  }

  factory ApiClient() {
    return _apiClient;
  }

  ApiClient._(this._host);

  final String _host;

  /// We are using dart:io instead of http package because
  /// http currently does not support cookies
  /// https://github.com/dart-lang/http/issues/24
  final HttpClient _client = HttpClient();

  HttpClient get http => _client;

  Uri initRequest(String path, {Map<String, dynamic>? parameters}) {
    return Uri.https(_host, 'api/$path', parameters);
  }

  void setHeaders(HttpClientRequest request, {
    String? sessionToken,
    String? csrfToken,
  }) async {
    request.headers.add(HttpHeaders.acceptHeader, 'application/json');

    if (sessionToken != null) {
      request.headers.add(HttpHeaders.cookieHeader, 'SID=$sessionToken');
    }
    if (csrfToken != null) {
      request.headers.add('X-Csrf-Token', csrfToken);
    }
  }
}
