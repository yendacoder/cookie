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

  Future<void> mute(String userId) async {
    state = {...state, userId};
    try {
      await ref.read(apiClientProvider).post(
        'mutes',
        data: {'userId': userId},
      );
    } catch (_) {
      state = state.difference({userId});
      rethrow;
    }
  }

  Future<void> unmute(String userId) async {
    state = state.difference({userId});
    try {
      await ref.read(apiClientProvider).delete('mutes/users/$userId');
    } catch (_) {
      state = {...state, userId};
      rethrow;
    }
  }
}
