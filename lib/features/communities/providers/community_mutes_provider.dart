import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../core/api/api_client.dart';
import 'muted_communities_list_provider.dart';

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

  Future<void> mute(String communityId, String communityName) async {
    state = {...state, communityId};
    ref
        .read(mutedCommunitiesListProvider.notifier)
        .add(communityId, communityName);
    try {
      await ref
          .read(apiClientProvider)
          .post('mutes', data: {'communityId': communityId});
    } catch (_) {
      ref.read(mutedCommunitiesListProvider.notifier).remove(communityId);
      state = state.difference({communityId});
      rethrow;
    }
  }

  Future<void> unmute(String communityId) async {
    state = state.difference({communityId});
    late final String? communityName;
    try {
      communityName = ref
          .read(mutedCommunitiesListProvider)
          .firstWhere((it) => it.mutedCommunityId == communityId)
          .mutedCommunity
          ?.name;
    } catch (_) {
      // shouldn't happen, but just in case, will show unknown community name
      // until refresh
      communityName = null;
    }
    ref.read(mutedCommunitiesListProvider.notifier).remove(communityId);
    try {
      await ref
          .read(apiClientProvider)
          .delete('mutes/communities/$communityId');
    } catch (_) {
      ref
          .read(mutedCommunitiesListProvider.notifier)
          .add(communityId, communityName ?? 'unknown');
      state = {...state, communityId};
      rethrow;
    }
  }
}
