import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/communities/models/community_reports_state.dart';
import 'package:cookie/features/communities/providers/community_reports_provider.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

// ---------------------------------------------------------------------------
// Mocks & helpers
// ---------------------------------------------------------------------------

class _MockDio extends Mock implements Dio {}

Map<String, dynamic> _reportJson(int id) => {
  'id': id,
  'communityId': 'comm-1',
  'reason': 'Spam',
  'reasonId': 1,
  'type': 'post',
  'targetId': 'post-$id',
  'createdAt': '2024-01-01T00:00:00.000Z',
};

Response<dynamic> _page(
  List<int> ids, {
  int noReports = 0,
  int noPostReports = 0,
  int noCommentReports = 0,
}) => Response(
  data: {
    'reports': ids.map(_reportJson).toList(),
    'details': {
      'noReports': noReports,
      'noPostReports': noPostReports,
      'noCommentReports': noCommentReports,
    },
  },
  statusCode: 200,
  requestOptions: RequestOptions(path: ''),
);

ProviderContainer _container(_MockDio dio) =>
    ProviderContainer(overrides: [apiClientProvider.overrideWithValue(dio)]);

// ---------------------------------------------------------------------------
// Tests
// ---------------------------------------------------------------------------

void main() {
  late _MockDio mockDio;
  final provider = communityReportsProvider('comm-1', ReportFilter.all);

  setUp(() => mockDio = _MockDio());

  group('CommunityReports — initial load', () {
    test('returns reports and details from first page', () async {
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page([1, 2], noReports: 5));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(provider.future);
      expect(state.reports.map((r) => r.id), [1, 2]);
      expect(state.page, 1);
      expect(state.total, 5);
      expect(state.hasMore, true);
    });

    test('hasMore is false when reports cover the total', () async {
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page([1, 2], noReports: 2));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final state = await container.read(provider.future);
      expect(state.hasMore, false);
    });
  });

  group('CommunityReports — loadMore', () {
    test('appends second page reports', () async {
      var callCount = 0;
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        return callCount == 1
            ? _page([1, 2], noReports: 4)
            : _page([3, 4], noReports: 4);
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      final state = container.read(provider).value!;
      expect(state.reports.map((r) => r.id), [1, 2, 3, 4]);
      expect(state.page, 2);
      expect(state.hasMore, false);
    });

    test('loadMore no-op when hasMore is false', () async {
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page([1, 2], noReports: 2));

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      verify(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('sets loadMoreError on failure and keeps existing reports', () async {
      var callCount = 0;
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async {
        callCount++;
        if (callCount == 1) return _page([1], noReports: 5);
        throw Exception('network error');
      });

      final container = _container(mockDio);
      addTearDown(container.dispose);

      await container.read(provider.future);
      await container.read(provider.notifier).loadMore();

      final state = container.read(provider).value!;
      expect(state.reports.map((r) => r.id), [1]);
      expect(state.isLoadingMore, false);
      expect(state.loadMoreError, isNotNull);
    });
  });

  group('CommunityReports — ignore', () {
    test('removes the report from state and calls DELETE', () async {
      when(
        () => mockDio.get(
          'communities/comm-1/reports',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => _page([1, 2], noReports: 2));
      when(() => mockDio.delete('communities/comm-1/reports/1')).thenAnswer(
        (_) async => Response(
          data: null,
          statusCode: 200,
          requestOptions: RequestOptions(path: ''),
        ),
      );

      final container = _container(mockDio);
      addTearDown(container.dispose);

      final initial = await container.read(provider.future);
      await container.read(provider.notifier).ignore(initial.reports[0]);

      final state = container.read(provider).value!;
      expect(state.reports.map((r) => r.id), [2]);
      verify(() => mockDio.delete('communities/comm-1/reports/1')).called(1);
    });
  });
}
