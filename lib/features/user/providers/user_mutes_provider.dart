import 'package:cookie/features/user/providers/muted_users_list_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';

part 'user_mutes_provider.g.dart';

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
