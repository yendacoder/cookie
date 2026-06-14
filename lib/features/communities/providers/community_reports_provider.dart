import 'package:cookie/core/api/api_client.dart';
import 'package:cookie/features/communities/models/community_reports_state.dart';
import 'package:cookie/models/report.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'community_reports_provider.g.dart';

const _kReportsPageSize = 10;

@riverpod
class CommunityReports extends _$CommunityReports {
  late String _communityId;
  late ReportFilter _filter;

  @override
  Future<CommunityReportsState> build(
    String communityId,
    ReportFilter filter,
  ) async {
    _communityId = communityId;
    _filter = filter;
    return _loadPage(1);
  }

  Future<CommunityReportsState> _loadPage(int page) async {
    final response = await ref
        .read(apiClientProvider)
        .get(
          'communities/$_communityId/reports',
          queryParameters: {
            'filter': _filter.apiValue,
            'page': page,
            'limit': _kReportsPageSize,
          },
        );
    final data = response.data as Map<String, dynamic>;
    final details = CommunityReportsDetails.fromJson(
      data['details'] as Map<String, dynamic>,
    );
    final reports = ((data['reports'] as List?) ?? const [])
        .cast<Map<String, dynamic>>()
        .map(Report.fromJson)
        .toList();
    return CommunityReportsState(
      reports: reports,
      details: details,
      filter: _filter,
      page: page,
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final loadedPage = current.page;
    state = AsyncData(
      CommunityReportsState(
        reports: current.reports,
        details: current.details,
        filter: current.filter,
        page: current.page,
        isLoadingMore: true,
      ),
    );

    try {
      final next = await _loadPage(loadedPage + 1);
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.page == loadedPage) {
        state = AsyncData(
          CommunityReportsState(
            reports: [...value.reports, ...next.reports],
            details: next.details,
            filter: _filter,
            page: loadedPage + 1,
          ),
        );
      }
    } catch (e) {
      if (state case AsyncData(
        :final value,
      ) when value.isLoadingMore && value.page == loadedPage) {
        state = AsyncData(
          CommunityReportsState(
            reports: value.reports,
            details: value.details,
            filter: value.filter,
            page: value.page,
            loadMoreError: e,
          ),
        );
      }
    }
  }

  /// Dismisses a report without taking any action on its target.
  Future<void> ignore(Report report) async {
    await ref
        .read(apiClientProvider)
        .delete('communities/$_communityId/reports/${report.id}');

    final current = state.value;
    if (current == null) return;
    state = AsyncData(
      CommunityReportsState(
        reports: current.reports.where((r) => r.id != report.id).toList(),
        details: current.details,
        filter: current.filter,
        page: current.page,
      ),
    );
  }
}
