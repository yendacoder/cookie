import 'package:cookie/l10n/app_localizations.dart';
import 'package:cookie/models/post.dart';

enum PostSort {
  hot,
  latest,
  activity,
  day,
  week,
  month,
  year,
  all;

  /// Matches the API's `sort` query parameter values exactly.
  String get apiValue => name;

  String label(AppLocalizations l10n) => switch (this) {
    hot => l10n.sortHot,
    latest => l10n.sortNew,
    activity => l10n.sortActivity,
    day => l10n.sortDay,
    week => l10n.sortWeek,
    month => l10n.sortMonth,
    year => l10n.sortYear,
    all => l10n.sortAll,
  };
}

class PostFeedState {
  PostFeedState({
    required this.posts,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<Post> posts;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
}
