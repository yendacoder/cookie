import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../models/initial_response.dart';

part 'muted_users_list_provider.g.dart';

@Riverpod(keepAlive: true)
class MutedUsersList extends _$MutedUsersList {
  @override
  List<InitialUserMute> build() => [];

  void initialize(List<InitialUserMute> mutes) {
    state = mutes;
  }

  void clear() {
    state = [];
  }

  void remove(String userId) {
    state = [for (final m in state) if (m.mutedUserId != userId) m];
  }
}
