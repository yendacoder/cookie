import 'package:cookie/features/feedback/providers/feedback_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class _MockDio extends Mock implements Dio {}

const _diagnostics = {'version': '1.2.3', 'os': 'android'};
const _endpoint = 'https://feedback.example.com/v1/feedback';
const _config = FeedbackConfig(endpoint: _endpoint, appId: 'fork');

void main() {
  group('buildFeedbackPayload', () {
    test('trims message and omits empty optional fields', () {
      final payload = buildFeedbackPayload(
        appId: 'cookie',
        category: .bug,
        message: '  It crashed  ',
        email: '   ',
      );
      expect(payload, {
        'app': 'cookie',
        'category': 'bug',
        'message': 'It crashed',
      });
    });

    test('includes trimmed email and diagnostics', () {
      final payload = buildFeedbackPayload(
        appId: 'cookie',
        category: .content,
        message: 'Spam in c/foo',
        email: ' me@example.com ',
        diagnostics: _diagnostics,
      );
      expect(payload['category'], 'content');
      expect(payload['email'], 'me@example.com');
      expect(payload['meta'], _diagnostics);
    });

    test('truncates long diagnostic values to the server limit', () {
      final payload = buildFeedbackPayload(
        appId: 'cookie',
        category: .other,
        message: 'x',
        diagnostics: {'osVersion': 'a' * 500},
      );
      expect((payload['meta'] as Map)['osVersion'], hasLength(200));
    });
  });

  test('feedback is disabled when FEEDBACK_ENDPOINT is not defined', () {
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(container.read(feedbackConfigProvider), isNull);
  });

  test('isValidFeedbackEmail', () {
    expect(isValidFeedbackEmail('a@b.co'), isTrue);
    expect(isValidFeedbackEmail('a@b'), isFalse);
    expect(isValidFeedbackEmail('a b@c.de'), isFalse);
    expect(isValidFeedbackEmail('${'a' * 250}@b.co'), isFalse);
  });

  group('FeedbackService.send', () {
    late _MockDio dio;
    late ProviderContainer container;

    setUp(() {
      dio = _MockDio();
      container = ProviderContainer(
        overrides: [
          feedbackConfigProvider.overrideWithValue(_config),
          feedbackClientProvider.overrideWithValue(dio),
          feedbackDiagnosticsProvider.overrideWithValue(_diagnostics),
        ],
      );
    });

    tearDown(() => container.dispose());

    FeedbackService service() => container.read(feedbackServiceProvider);

    void stubPost(Future<Response<dynamic>> Function() answer) => when(
      () => dio.post<dynamic>(any(), data: any(named: 'data')),
    ).thenAnswer((_) => answer());

    DioException httpError(int status) => DioException(
      requestOptions: RequestOptions(path: _endpoint),
      response: Response(
        statusCode: status,
        requestOptions: RequestOptions(path: _endpoint),
      ),
      type: .badResponse,
    );

    test('posts payload with diagnostics to the endpoint', () async {
      stubPost(
        () async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: _endpoint),
        ),
      );

      await service().send(category: .suggestion, message: 'Dark mode+');

      final captured =
          verify(
                () => dio.post<dynamic>(
                  _endpoint,
                  data: captureAny(named: 'data'),
                ),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured['app'], 'fork');
      expect(captured['category'], 'suggestion');
      expect(captured['meta'], _diagnostics);
    });

    test('omits diagnostics when opted out', () async {
      stubPost(
        () async => Response(
          statusCode: 200,
          requestOptions: RequestOptions(path: _endpoint),
        ),
      );

      await service().send(
        category: .bug,
        message: 'x',
        includeDiagnostics: false,
      );

      final captured =
          verify(
                () => dio.post<dynamic>(any(), data: captureAny(named: 'data')),
              ).captured.single
              as Map<String, dynamic>;
      expect(captured.containsKey('meta'), isFalse);
    });

    test('maps 429 to rateLimited', () async {
      stubPost(() => Future.error(httpError(429)));
      await expectLater(
        service().send(category: .bug, message: 'x'),
        throwsA(
          isA<FeedbackException>().having(
            (e) => e.failure,
            'failure',
            FeedbackFailure.rateLimited,
          ),
        ),
      );
    });

    test('maps other errors to failed', () async {
      stubPost(() => Future.error(httpError(502)));
      await expectLater(
        service().send(category: .bug, message: 'x'),
        throwsA(
          isA<FeedbackException>().having(
            (e) => e.failure,
            'failure',
            FeedbackFailure.failed,
          ),
        ),
      );
    });
  });
}
