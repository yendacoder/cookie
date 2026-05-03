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

  void remove(String communityId) {
    state = [for (final m in state) if (m.mutedCommunityId != communityId) m];
  }
}
