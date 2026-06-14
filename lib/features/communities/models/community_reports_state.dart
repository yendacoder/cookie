import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/report.dart';

enum ReportFilter {
  all,
  posts,
  comments;

  /// Matches the API's `filter` query parameter values exactly.
  String get apiValue => name;

  String label(AppLocalizations l10n) => switch (this) {
    ReportFilter.all => l10n.modToolsReportsFilterAll,
    ReportFilter.posts => l10n.modToolsReportsFilterPosts,
    ReportFilter.comments => l10n.modToolsReportsFilterComments,
  };
}

class CommunityReportsState {
  CommunityReportsState({
    required this.reports,
    required this.details,
    required this.filter,
    required this.page,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<Report> reports;
  final CommunityReportsDetails details;
  final ReportFilter filter;
  final int page;
  final bool isLoadingMore;
  final Object? loadMoreError;

  int get total => switch (filter) {
    ReportFilter.all => details.numReports,
    ReportFilter.posts => details.numPostReports,
    ReportFilter.comments => details.numCommentReports,
  };

  bool get hasMore => reports.length < total;
}
