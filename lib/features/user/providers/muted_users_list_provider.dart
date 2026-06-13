import 'package:cookie/models/initial_response.dart';
import 'package:cookie/models/public_user.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

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

  /// Adds a basic muted user record with mostly placeholder data
  /// until a proper sync with server
  void add(String userId, String username) {
    state = [
      ...state,
      InitialUserMute(
        id: userId,
        mutedUserId: userId,
        mutedUser: PublicUser(
          id: userId,
          username: username,
          points: 0,
          isAdmin: false,
          noPosts: 0,
          noComments: 0,
          createdAt: DateTime.now(),
          deleted: false,
          isBanned: false,
        ),
      ),
    ];
  }

  void remove(String userId) {
    state = [
      for (final m in state)
        if (m.mutedUserId != userId) m,
    ];
  }
}
