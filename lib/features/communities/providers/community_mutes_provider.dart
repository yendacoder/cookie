import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';

part 'community_mutes_provider.g.dart';

@Riverpod(keepAlive: true)
class CommunityMutes extends _$CommunityMutes {
  @override
  Set<String> build() => {};

  void initialize(Set<String> mutedCommunityIds) {
    state = mutedCommunityIds;
  }

  void clear() {
    state = {};
  }

  Future<void> mute(String communityId) async {
    state = {...state, communityId};
    try {
      await ref.read(apiClientProvider).post(
        'mutes',
        data: {'communityId': communityId},
      );
    } catch (_) {
      state = state.difference({communityId});
      rethrow;
    }
  }

  Future<void> unmute(String communityId) async {
    state = state.difference({communityId});
    try {
      await ref
          .read(apiClientProvider)
          .delete('mutes/communities/$communityId');
    } catch (_) {
      state = {...state, communityId};
      rethrow;
    }
  }
}
