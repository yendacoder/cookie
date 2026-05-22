import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import '../../../models/notification.dart';
import '../../auth/providers/auth_provider.dart';

part 'notifications_provider.g.dart';

class NotificationFeedState {
  NotificationFeedState({
    required this.items,
    this.nextCursor,
    this.isLoadingMore = false,
    this.loadMoreError,
  });

  final List<AppNotification> items;
  final String? nextCursor;
  final bool isLoadingMore;
  final Object? loadMoreError;

  bool get hasMore => nextCursor != null;
}

@riverpod
class NotificationsNotifier extends _$NotificationsNotifier {
  @override
  Future<NotificationFeedState> build() => _loadPage(null);

  Future<NotificationFeedState> _loadPage(String? cursor) async {
    final response = await ref.read(apiClientProvider).get(
      'notifications',
      queryParameters: {'next': ?cursor},
    );
    final data = response.data as Map<String, dynamic>;
    final newCount = data['newCount'] as int? ?? 0;
    ref.read(authProvider.notifier).setNotificationCount(newCount);
    return NotificationFeedState(
      items: (data['items'] as List)
          .cast<Map<String, dynamic>>()
          .map(AppNotification.fromJson)
          .toList(),
      nextCursor: data['next']?.toString(),
    );
  }

  Future<void> loadMore() async {
    final current = state.value;
    if (current == null || current.isLoadingMore || !current.hasMore) return;

    final cursor = current.nextCursor!;
    state = AsyncData(NotificationFeedState(
      items: current.items,
      nextCursor: cursor,
      isLoadingMore: true,
    ));

    try {
      final page = await _loadPage(cursor);
      if (state case AsyncData(:final value)
          when value.isLoadingMore && value.nextCursor == cursor) {
        state = AsyncData(NotificationFeedState(
          items: [...value.items, ...page.items],
          nextCursor: page.nextCursor,
        ));
      }
    } catch (e) {
      if (state case AsyncData(:final value)
          when value.isLoadingMore && value.nextCursor == cursor) {
        state = AsyncData(NotificationFeedState(
          items: value.items,
          nextCursor: value.nextCursor,
          loadMoreError: e,
        ));
      }
    }
  }
}
