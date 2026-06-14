import 'package:cookie/core/errors/app_exception.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('apiErrorMessage', () {
    test('returns the message field from a JSON error response', () {
      final error = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          data: {
            'status': 404,
            'code': 'user_not_found',
            'message': 'User not found.',
          },
          statusCode: 404,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(apiErrorMessage(error), 'User not found.');
    });

    test('falls back to toString when response has no message field', () {
      final error = DioException(
        requestOptions: RequestOptions(path: ''),
        response: Response(
          data: 'plain text body',
          statusCode: 500,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      expect(apiErrorMessage(error), error.toString());
    });

    test('falls back to toString for non-Dio errors', () {
      final error = Exception('boom');
      expect(apiErrorMessage(error), error.toString());
    });
  });
}
