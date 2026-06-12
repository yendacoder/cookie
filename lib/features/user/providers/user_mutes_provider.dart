import 'package:cookie/features/user/providers/muted_users_list_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:cookie/core/api/api_client.dart';

part 'user_mutes_provider.g.dart';

// "Breaks community rules" — the closest fit for a blocked/abusive user's
// content, since the block action has no reason picker of its own.
const _blockReportReason = 1;

/// Mutes [userId] and reports [targetId] (a post or comment) so moderators
/// are notified of the content that prompted the block.
///
/// The report is best-effort: if it fails, the block itself still stands.
Future<void> blockUserAndReport(
  WidgetRef ref, {
  required String userId,
  required String username,
  required String targetId,
  required String targetType,
}) async {
  await ref.read(userMutesProvider.notifier).mute(userId, username);
  try {
    await ref
        .read(apiClientProvider)
        .post(
          '_report',
          data: {
            'targetId': targetId,
            'type': targetType,
            'reason': _blockReportReason,
          },
        );
  } catch (_) {
    // Report is best-effort; the block itself already succeeded.
  }
}

@Riverpod(keepAlive: true)
class UserMutes extends _$UserMutes {
  @override
  Set<String> build() => {};

  void initialize(Set<String> mutedUserIds) {
    state = mutedUserIds;
  }

  void clear() {
    state = {};
  }

  Future<void> mute(String userId, String username) async {
    state = {...state, userId};
    ref.read(mutedUsersListProvider.notifier).add(userId, username);
    try {
      await ref.read(apiClientProvider).post('mutes', data: {'userId': userId});
    } catch (_) {
      ref.read(mutedUsersListProvider.notifier).remove(userId);
      state = state.difference({userId});
      rethrow;
    }
  }

  Future<void> unmute(String userId) async {
    state = state.difference({userId});
    late final String? username;
    try {
      username = ref
          .read(mutedUsersListProvider)
          .firstWhere((it) => it.mutedUserId == userId)
          .mutedUser
          ?.username;
    } catch (_) {
      // shouldn't happen, but just in case, will show unknown username
      // until refresh
      username = null;
    }
    ref.read(mutedUsersListProvider.notifier).remove(userId);
    try {
      await ref.read(apiClientProvider).delete('mutes/users/$userId');
    } catch (_) {
      ref
          .read(mutedUsersListProvider.notifier)
          .add(userId, username ?? 'unknown');
      state = {...state, userId};
      rethrow;
    }
  }
}
