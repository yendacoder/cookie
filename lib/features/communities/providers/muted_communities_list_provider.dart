import 'package:cookie/models/community.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/initial_response.dart';

part 'muted_communities_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MutedCommunitiesList extends _$MutedCommunitiesList {
  @override
  List<InitialCommunityMute> build() => [];

  void initialize(List<InitialCommunityMute> mutes) {
    state = mutes;
  }

  void clear() {
    state = [];
  }

  /// Adds a basic muted community record with mostly placeholder data
  /// until a proper sync with server
  void add(String communityId, String communityName) {
    state = [
      ...state,
      InitialCommunityMute(
        id: communityId,
        mutedCommunityId: communityId,
        mutedCommunity: Community(
          id: communityId,
          userId: '',
          name: communityName,
          nsfw: false,
          noMembers: 0,
          postingRestricted: false,
          createdAt: DateTime.now(),
        ),
      ),
    ];
  }

  void remove(String communityId) {
    state = [
      for (final m in state)
        if (m.mutedCommunityId != communityId) m,
    ];
  }
}
