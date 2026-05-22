import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/api/api_client.dart';
import '../../../core/extensions/build_context_ext.dart';
import '../../../core/utils/relative_time.dart';
import '../../../core/widgets/error_view.dart';
import '../../../l10n/app_localizations.dart';
import '../../../models/notification.dart';
import '../../auth/providers/auth_provider.dart';
import '../../auth/widgets/auth_gate.dart';
import '../providers/notifications_provider.dart';

class NotificationsScreen extends ConsumerStatefulWidget {
  const NotificationsScreen({super.key});

  @override
  ConsumerState<NotificationsScreen> createState() =>
      _NotificationsScreenState();
}

class _NotificationsScreenState extends ConsumerState<NotificationsScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) _clearBadge();
    });
  }

  Future<void> _clearBadge() async {
    try {
      final client = ref.read(apiClientProvider);
      await Future.wait<void>([
        client.post(
          'notifications',
          queryParameters: {'action': 'markAllAsSeen'},
        ),
        client.post(
          'notifications',
          queryParameters: {'action': 'resetNewCount'},
        ),
      ]);
      if (mounted) ref.read(authProvider.notifier).setNotificationCount(0);
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final feedState = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.notificationsScreenTitle),
      ),
      body: AuthGate(
        child: RefreshIndicator(
          onRefresh: () async {
            ref.invalidate(notificationsProvider);
            await ref.read(notificationsProvider.future);
          },
          child: CustomScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            slivers: [
              switch (feedState) {
                AsyncLoading() => const SliverFillRemaining(
                    child: Center(child: CircularProgressIndicator()),
                  ),
                AsyncError(:final error) => SliverFillRemaining(
                    child: ErrorView(
                      error: error,
                      onRetry: () => ref.invalidate(notificationsProvider),
                    ),
                  ),
                AsyncData(:final value) => _NotificationsList(feed: value),
              },
            ],
          ),
        ),
      ),
    );
  }
}

// ── List ──────────────────────────────────────────────────────────────────────

class _NotificationsList extends ConsumerWidget {
  const _NotificationsList({required this.feed});

  final NotificationFeedState feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (feed.items.isEmpty && !feed.isLoadingMore && !feed.hasMore) {
      return SliverFillRemaining(
        hasScrollBody: false,
        child: Center(
          child: Text(
            context.l10n.notificationsEmpty,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      );
    }

    return SliverMainAxisGroup(
      slivers: [
        SliverList.separated(
          itemCount: feed.items.length + 1,
          separatorBuilder: (_, _) => const Divider(height: 1),
          itemBuilder: (context, index) {
            if (index == feed.items.length) {
              return _NotificationsFooter(feed: feed);
            }
            return _NotificationTile(notification: feed.items[index]);
          },
        ),
      ],
    );
  }
}

// ── Footer ────────────────────────────────────────────────────────────────────

class _NotificationsFooter extends ConsumerWidget {
  const _NotificationsFooter({required this.feed});

  final NotificationFeedState feed;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (!feed.isLoadingMore && feed.hasMore) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (context.mounted) {
          ref.read(notificationsProvider.notifier).loadMore();
        }
      });
    }

    if (feed.isLoadingMore) {
      return const Padding(
        padding: EdgeInsets.all(24),
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (feed.loadMoreError != null) {
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
            TextButton(
              onPressed: () =>
                  ref.read(notificationsProvider.notifier).loadMore(),
              child: Text(context.l10n.retryButton),
            ),
          ],
        ),
      );
    }

    if (!feed.hasMore) {
      return Padding(
        padding: const EdgeInsets.all(24),
        child: Center(
          child: Text(
            context.l10n.feedEndOfContent,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
          ),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}

// ── Tile ──────────────────────────────────────────────────────────────────────

class _NotificationTile extends StatelessWidget {
  const _NotificationTile({required this.notification});

  final AppNotification notification;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;
    final isNew = !notification.seen;

    return InkWell(
      onTap: () => _navigate(context),
      child: ColoredBox(
        color: isNew
            ? colorScheme.primaryContainer.withValues(alpha: 0.35)
            : Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(
                _icon(notification.type),
                size: 20,
                color: isNew
                    ? colorScheme.primary
                    : colorScheme.onSurfaceVariant,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _title(context.l10n, notification),
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight:
                            isNew ? FontWeight.w500 : FontWeight.normal,
                      ),
                    ),
                    if (_subtitle(notification) case final String sub) ...[
                      const SizedBox(height: 2),
                      Text(
                        sub,
                        style: textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                    const SizedBox(height: 4),
                    Text(
                      notification.createdAt.toRelativeString(context.l10n),
                      style: textTheme.labelSmall?.copyWith(
                        color: colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (isNew)
                Padding(
                  padding: const EdgeInsets.only(left: 8, top: 2),
                  child: Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: colorScheme.primary,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context) {
    final notif = notification.notif;
    switch (notification.type) {
      case 'new_comment':
      case 'comment_reply':
      case 'deleted_post':
        _pushPost(context, notif['post'] as Map<String, dynamic>?);
      case 'new_votes':
        if (notif['targetType'] == 'comment') {
          final comment =
              (notif['comment'] ?? notif['post']) as Map<String, dynamic>?;
          final communityName = comment?['communityName'] as String?;
          final postPublicId = comment?['postPublicId'] as String?;
          if (communityName != null && postPublicId != null) {
            context.push('/c/$communityName/post/$postPublicId');
          }
        } else {
          _pushPost(context, notif['post'] as Map<String, dynamic>?);
        }
      case 'mod_add':
        final communityName = notif['communityName'] as String?;
        if (communityName != null) context.push('/c/$communityName');
    }
  }

  void _pushPost(BuildContext context, Map<String, dynamic>? post) {
    final communityName = post?['communityName'] as String?;
    final publicId = post?['publicId'] as String?;
    if (communityName != null && publicId != null) {
      context.push('/c/$communityName/post/$publicId');
    }
  }

  IconData _icon(String type) => switch (type) {
        'new_comment' => Icons.mode_comment_outlined,
        'comment_reply' => Icons.reply_outlined,
        'new_votes' => Icons.arrow_upward_outlined,
        'deleted_post' => Icons.delete_outline,
        'mod_add' => Icons.shield_outlined,
        'new_badge' => Icons.stars_outlined,
        _ => Icons.notifications_outlined,
      };

  String _title(AppLocalizations l10n, AppNotification n) {
    final notif = n.notif;
    return switch (n.type) {
      'new_comment' => () {
          final author = notif['commentAuthor'] as String? ?? 'Someone';
          final count = notif['noComments'] as int? ?? 1;
          return count > 1
              ? l10n.notifNewCommentMultiple(author, count - 1)
              : l10n.notifNewComment(author);
        }(),
      'comment_reply' =>
        l10n.notifCommentReply(notif['commentAuthor'] as String? ?? 'Someone'),
      'new_votes' => () {
          final count = notif['noVotes'] as int? ?? 0;
          final raw = notif['targetType'] as String? ?? 'post';
          return count == 1
              ? l10n.notifNewVotesSingle(raw)
              : l10n.notifNewVotesMultiple(count, raw);
        }(),
      'deleted_post' => l10n.notifDeletedPost,
      'mod_add' => l10n.notifModAdd(notif['communityName'] as String? ?? ''),
      'new_badge' => l10n.notifNewBadge,
      _ => n.type,
    };
  }

  String? _subtitle(AppNotification n) {
    final notif = n.notif;
    return switch (n.type) {
      'new_comment' ||
      'comment_reply' ||
      'new_votes' ||
      'deleted_post' =>
        (notif['post'] as Map<String, dynamic>?)?['title'] as String?,
      _ => null,
    };
  }
}
