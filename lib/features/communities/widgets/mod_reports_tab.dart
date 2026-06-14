import 'package:cookie/core/errors/app_exception.dart';
import 'package:cookie/core/extensions/build_context_ext.dart';
import 'package:cookie/core/hero_tag_scope.dart';
import 'package:cookie/core/utils/markdown_utils.dart';
import 'package:cookie/core/utils/relative_time.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_divider.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_progress_indicator.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_segmented_button.dart';
import 'package:cookie/core/widgets/adaptive/adaptive_snackbar.dart';
import 'package:cookie/core/widgets/error_view.dart';
import 'package:cookie/features/communities/models/community_reports_state.dart';
import 'package:cookie/features/communities/providers/community_reports_provider.dart';
import 'package:cookie/models/report.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

/// The "Reports" tab of [ModToolsScreen] — lets mods browse, filter, and
/// dismiss user-submitted reports on posts and comments.
class ModReportsTab extends ConsumerStatefulWidget {
  const ModReportsTab({
    super.key,
    required this.communityId,
    required this.communityName,
  });

  final String communityId;
  final String communityName;

  @override
  ConsumerState<ModReportsTab> createState() => _ModReportsTabState();
}

class _ModReportsTabState extends ConsumerState<ModReportsTab> {
  ReportFilter _filter = ReportFilter.all;
  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.extentAfter < 400) {
      ref
          .read(communityReportsProvider(widget.communityId, _filter).notifier)
          .loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final reportsAsync = ref.watch(
      communityReportsProvider(widget.communityId, _filter),
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: AdaptiveSegmentedButton<ReportFilter>(
            segments: [
              for (final filter in ReportFilter.values)
                AdaptiveButtonSegment(value: filter, label: filter.label(l10n)),
            ],
            selected: {_filter},
            onSelectionChanged: (selected) =>
                setState(() => _filter = selected.first),
          ),
        ),
        Expanded(
          child: switch (reportsAsync) {
            AsyncData(:final value) when value.reports.isEmpty => _EmptyState(),
            AsyncData(:final value) => ListView.separated(
              controller: _scrollController,
              itemCount: value.reports.length + 1,
              separatorBuilder: (_, _) => const AdaptiveDivider(height: 1),
              itemBuilder: (context, index) {
                if (index == value.reports.length) {
                  return _ReportsFooter(
                    state: value,
                    communityId: widget.communityId,
                    filter: _filter,
                  );
                }
                return _ReportCard(
                  report: value.reports[index],
                  communityName: widget.communityName,
                  communityId: widget.communityId,
                  filter: _filter,
                );
              },
            ),
            AsyncError(:final error) => ErrorView(
              error: error,
              onRetry: () => ref.invalidate(
                communityReportsProvider(widget.communityId, _filter),
              ),
            ),
            _ => const Center(child: AdaptiveProgressIndicator()),
          },
        ),
      ],
    );
  }
}

// ── Empty state ───────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  const _EmptyState();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        context.l10n.modToolsReportsEmpty,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurfaceVariant,
        ),
      ),
    );
  }
}

// ── Report card ──────────────────────────────────────────────────────────────

class _ReportCard extends ConsumerWidget {
  const _ReportCard({
    required this.report,
    required this.communityName,
    required this.communityId,
    required this.filter,
  });

  final Report report;
  final String communityName;
  final String communityId;
  final ReportFilter filter;

  Future<void> _ignore(BuildContext context, WidgetRef ref) async {
    try {
      await ref
          .read(communityReportsProvider(communityId, filter).notifier)
          .ignore(report);
    } catch (e) {
      if (context.mounted) {
        showPlatformSnackBar(context, apiErrorMessage(e));
      }
    }
  }

  void _view(BuildContext context) {
    final post = report.targetPost;
    final comment = report.targetComment;
    if (post != null) {
      context.push(
        '/c/${post.communityName}/post/${post.publicId}',
        extra: (
          post: post,
          heroTagScope: HeroTagScope(.moderating, id: communityName),
        ),
      );
    } else if (comment != null) {
      context.push('/c/${comment.communityName}/post/${comment.postPublicId}');
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.modToolsReportsReason(report.reason),
                  style: textTheme.labelSmall?.copyWith(color: muted),
                ),
              ),
              Text(
                report.createdAt.toRelativeString(l10n),
                style: textTheme.labelSmall?.copyWith(color: muted),
              ),
            ],
          ),
          const SizedBox(height: 6),
          _ReportTarget(report: report),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              AdaptiveTextButton(
                onPressed: () => _ignore(context, ref),
                child: Text(l10n.modToolsReportsIgnore),
              ),
              AdaptiveTextButton(
                onPressed: () => _view(context),
                child: Text(l10n.modToolsReportsView),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ReportTarget extends StatelessWidget {
  const _ReportTarget({required this.report});

  final Report report;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final textTheme = Theme.of(context).textTheme;
    final muted = Theme.of(context).colorScheme.onSurfaceVariant;

    final post = report.targetPost;
    if (post != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(post.title, style: textTheme.bodyMedium),
          if (post.deleted) ...[
            const SizedBox(height: 4),
            Text(
              l10n.modToolsReportsRemoved,
              style: textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      );
    }

    final comment = report.targetComment;
    if (comment != null) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            markdownToPlainText(comment.body),
            style: textTheme.bodyMedium,
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
          if (comment.postTitle case final String title
              when title.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              l10n.commentPostReference(title),
              style: textTheme.labelSmall?.copyWith(color: muted),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (comment.deleted) ...[
            const SizedBox(height: 4),
            Text(
              l10n.modToolsReportsRemoved,
              style: textTheme.labelSmall?.copyWith(
                color: Theme.of(context).colorScheme.error,
              ),
            ),
          ],
        ],
      );
    }

    return const SizedBox.shrink();
  }
}

// ── Footer (loading / load-more error / end of content) ───────────────────────

class _ReportsFooter extends ConsumerWidget {
  const _ReportsFooter({
    required this.state,
    required this.communityId,
    required this.filter,
  });

  final CommunityReportsState state;
  final String communityId;
  final ReportFilter filter;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (state.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: AdaptiveProgressIndicator()),
      );
    }

    if (state.loadMoreError != null) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: Text(
                context.l10n.feedLoadMoreError,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.error,
                ),
              ),
            ),
            AdaptiveTextButton(
              onPressed: () => ref
                  .read(communityReportsProvider(communityId, filter).notifier)
                  .loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
