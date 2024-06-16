import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:cookie/api/api_client.dart';
import 'package:cookie/api/api_error.dart';
import 'package:cookie/api/auth_record.dart';

typedef PerformRequestCallback = Future<HttpClientRequest> Function();
typedef ParseResultCallback<J, T> = T Function(J json, List<Cookie> cookies);
typedef ParseResultObjectCallback<T> = T Function(Map<String, dynamic> json, List<Cookie> cookies);

class Repository {
  final client = ApiClient();

  Future<List<T>> performRequestListResult<T>(
      AuthRecord? authRecord,
      PerformRequestCallback performRequestCallback,
      ParseResultObjectCallback<T> parseResultObjectCallback, {dynamic body}) async {
    return performRequest<Iterable<dynamic>, List<T>>(
        authRecord,
        performRequestCallback,
        (json, cookies) => List<T>.from(json.map(
            (obj) => parseResultObjectCallback(obj as Map<String, dynamic>, cookies))), body);
  }

  Future<T> performRequestObjectResult<T>(
      AuthRecord? authRecord,
      PerformRequestCallback performRequestCallback,
      ParseResultObjectCallback<T> parseResultObjectCallback, {dynamic body}) async {
    return performRequest<Map<String, dynamic>, T>(
        authRecord, performRequestCallback, parseResultObjectCallback, body);
  }

  Future<void> performRequestEmptyResult(
      AuthRecord? authRecord,
      PerformRequestCallback performRequestCallback, {dynamic body}) async {
    return performRequest<Map<String, dynamic>, void>(
        authRecord, performRequestCallback, (_, __) {}, body);
  }

  Future<String> readResponse(HttpClientResponse response) {
    final completer = Completer<String>();
    final contents = StringBuffer();
    response.transform(utf8.decoder).listen((data) {
      contents.write(data);
    }, onDone: () => completer.complete(contents.toString()));
    return completer.future;
  }


  Future<T> performRequest<J, T>(
      AuthRecord? authRecord,
      PerformRequestCallback performRequestCallback,
      ParseResultCallback<J, T> parseResultCallback,
      dynamic body) async {
    final HttpClientResponse response;
    try {
      final request = await performRequestCallback();
      client.setHeaders(request, sessionToken: authRecord?.sessionToken,
        csrfToken: authRecord?.csrfToken);
      if (body != null) {
        if (body is List<int>) {
          request.add(body);
        } else {
          request.add(utf8.encode(json.encode(body)));
        }
      }
      response = await request.close();
    } catch (error, stackTrace) {
      log('network error: $error');
      log('stackTrace: $stackTrace');
      throw ApiError.network(error.toString());
    }
    try {
      if (response.statusCode >= 200 && response.statusCode < 300) {
        final res = json.decode(await readResponse(response)) as J;
        final T data;
        try {
          data = parseResultCallback(res, response.cookies);
        } catch (error, stackTrace) {
          log('parse error: $error');
          log('stackTrace: $stackTrace');
          throw ApiError.parse(error.toString());
        }
        return data;
      } else {
        final Map<String, dynamic> res;
        try {
          res = json.decode(await readResponse(response))
              as Map<String, dynamic>;
        } catch (error, stackTrace) {
          log('server error: $error');
          log('stackTrace: $stackTrace');
          throw ApiError.server();
        }
        log('api error: $res');
        throw ApiError.api(res['status'].toString(), res['code'].toString(), res['message']?.toString());
      }
    } catch (error, stackTrace) {
      if (error is ApiError) {
        rethrow;
      }
      log('unknown error: $error');
      log('stackTrace: $stackTrace');
      return throw ApiError.unknown();
    }
  }
}
