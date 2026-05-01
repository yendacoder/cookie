import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'api_client.g.dart';

const _baseUrl = 'https://discuit.org/api/';

@Riverpod(keepAlive: true)
CookieJar cookieJar(Ref ref) => CookieJar();

@Riverpod(keepAlive: true)
Dio apiClient(Ref ref) {
  final jar = ref.read(cookieJarProvider);
  final dio = Dio(
    BaseOptions(
      baseUrl: _baseUrl,
      connectTimeout: const Duration(seconds: 15),
      receiveTimeout: const Duration(seconds: 15),
      contentType: 'application/json',
    ),
  );

  // Stores SID + csrftoken cookies from responses and sends them with requests.
  dio.interceptors.add(CookieManager(jar));

  // Discuit requires the csrftoken cookie value in an X-Csrf-Token header for
  // all non-GET requests. The token is issued by the server on the first GET
  // to any endpoint (typically /_initial) and stays valid for the session.
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) async {
        if (options.method != 'GET') {
          final cookies = await jar.loadForRequest(Uri.parse(_baseUrl));
          final csrfToken = cookies
              .where((c) => c.name == 'csrftoken')
              .map((c) => c.value)
              .firstOrNull;
          if (csrfToken != null) {
            options.headers['X-Csrf-Token'] = csrfToken;
          }
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}
