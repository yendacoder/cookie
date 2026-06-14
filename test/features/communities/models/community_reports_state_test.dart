import 'package:cookie/features/communities/models/community_reports_state.dart';
import 'package:cookie/models/report.dart';
import 'package:flutter_test/flutter_test.dart';

Report _dummyReport(int id) => Report(
  id: id,
  communityId: 'comm-1',
  reason: 'Spam',
  reasonId: 1,
  type: 'post',
  targetId: 'post-$id',
  createdAt: DateTime(2024),
);

CommunityReportsState _state(ReportFilter filter, int reportCount) =>
    CommunityReportsState(
      reports: List.generate(reportCount, _dummyReport),
      details: const CommunityReportsDetails(
        numReports: 5,
        numPostReports: 3,
        numCommentReports: 2,
      ),
      filter: filter,
      page: 1,
    );

void main() {
  group('CommunityReportsState.total', () {
    test('uses numReports for ReportFilter.all', () {
      expect(_state(ReportFilter.all, 0).total, 5);
    });

    test('uses numPostReports for ReportFilter.posts', () {
      expect(_state(ReportFilter.posts, 0).total, 3);
    });

    test('uses numCommentReports for ReportFilter.comments', () {
      expect(_state(ReportFilter.comments, 0).total, 2);
    });
  });

  group('CommunityReportsState.hasMore', () {
    test('true when fewer reports are loaded than total', () {
      expect(_state(ReportFilter.posts, 1).hasMore, true);
    });

    test('false once all reports for the filter are loaded', () {
      expect(_state(ReportFilter.posts, 3).hasMore, false);
    });
  });
}
